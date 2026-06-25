#!/usr/bin/env bash
# Create OC10 users from fixtures/users.csv (idempotent).
#  - active users get logged in once (authenticated PROPFIND) to set last_login,
#    otherwise the migration would skip their files/shares.
#  - the disabled user is created then disabled (must NOT migrate).
#  - the never-logged-in user is left without a login (files/shares skipped).
set -euo pipefail
ACCEPTANCE_DIR="${ACCEPTANCE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
cd "$ACCEPTANCE_DIR"
source lib/common.sh

user_exists() { occ user:list 2>/dev/null | grep -qE "^[[:space:]]*-[[:space:]]*$1:"; }

# The OC10 admin is created by the image without an email; `verify` requires
# every enabled user to have a valid, unique email. Set one before seeding the
# fixture users.
log "setting admin email"
occ user:modify "$OC10_ADMIN" email "admin@example.org" >/dev/null

# Read the CSV on FD 3: commands inside the loop use `docker compose exec -T`
# which would otherwise consume the CSV from stdin after the first iteration.
while IFS=, read -r uid pw email enabled login <&3; do
  case "$uid" in ''|\#*) continue ;; esac

  if user_exists "$uid"; then
    log "user $uid already exists"
  else
    log "creating user $uid ($email)"
    docker compose exec -T -e OC_PASS="$pw" oc10 \
      occ user:add --password-from-env --display-name "$uid" --email "$email" "$uid"
  fi

  # Ensure the email is set even if the user pre-existed.
  occ user:modify "$uid" email "$email" >/dev/null

  if [ "$enabled" = "no" ]; then
    log "disabling user $uid"
    occ user:disable "$uid" >/dev/null
  else
    occ user:enable "$uid" >/dev/null
  fi

  if [ "$login" = "yes" ]; then
    log "logging in user $uid (sets last_login)"
    # Authenticated DAV request triggers a login event -> last_login is set.
    in_oc10 curl -sS -u "$uid:$pw" -X PROPFIND \
      "$OC10_DAV/$uid/" -H 'Depth: 0' -o /dev/null
  fi
done 3< fixtures/users.csv

log "users seeded"
occ user:list
