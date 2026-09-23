#!/usr/bin/env bash
# Shared helpers for the acceptance suite. Source this from every script.
#
# Expects (with sensible defaults) the following to be set in the environment:
#   OCIS_ADMIN, OCIS_PW, OCIS_HOST, OC11_ADMIN, OC11_PW
# and COMPOSE_FILE / the working directory to be tests/acceptance.

set -euo pipefail

# ---------------------------------------------------------------------------
# Configuration (overridable via environment / .env)
# ---------------------------------------------------------------------------
: "${OCIS_ADMIN:=admin}"
: "${OCIS_PW:=admin}"
: "${OCIS_HOST:=ocis:9200}"          # how ownCloud Classic (and the migration) reach oCIS
: "${OC11_ADMIN:=admin}"
: "${OC11_PW:=admin}"

# In-network base URLs (resolved from inside a container on `mignet`).
OC11_BASE="http://oc11:8080"
OC11_DAV="$OC11_BASE/remote.php/dav/files"
OC11_OCS="$OC11_BASE/ocs/v1.php/apps/files_sharing/api/v1/shares"
OCIS_BASE="https://${OCIS_HOST}"

# Directory layout (ACCEPTANCE_DIR is tests/acceptance).
ARTIFACTS="${ACCEPTANCE_DIR:-.}/artifacts"

# ---------------------------------------------------------------------------
# Logging
# ---------------------------------------------------------------------------
log()  { printf '\033[1;34m[%s]\033[0m %s\n' "$(date +%H:%M:%S)" "$*" >&2; }
warn() { printf '\033[1;33m[warn]\033[0m %s\n' "$*" >&2; }
err()  { printf '\033[1;31m[err ]\033[0m %s\n' "$*" >&2; }

# ---------------------------------------------------------------------------
# docker compose wrappers
# ---------------------------------------------------------------------------
dc() { docker compose "$@"; }

# Run `occ` inside the oc11 container. -T disables the pseudo-TTY so stdin can
# be piped (required for the interactive password/role prompts).
occ() { docker compose exec -T oc11 occ "$@"; }

# Run an arbitrary command inside the oc11 container (as the web user where it
# matters). Used for curl-based seeding from inside the network.
in_oc11() { docker compose exec -T oc11 "$@"; }

# Run a command inside the ocis container (has curl).
in_ocis() { docker compose exec -T ocis "$@"; }

# ---------------------------------------------------------------------------
# Retry helper: retry <attempts> <delay-seconds> <command...>
# ---------------------------------------------------------------------------
retry() {
  local attempts="$1" delay="$2"; shift 2
  local i=1
  while true; do
    if "$@"; then return 0; fi
    if [ "$i" -ge "$attempts" ]; then
      err "command failed after ${attempts} attempts: $*"
      return 1
    fi
    i=$((i + 1))
    sleep "$delay"
  done
}

# ---------------------------------------------------------------------------
# curl helpers (run from inside the oc11 container so service names resolve)
# ---------------------------------------------------------------------------

# oc11_curl <user> <password> <curl-args...>
# Talks to the ownCloud Classic instance over the docker network.
oc11_curl() {
  local user="$1" pw="$2"; shift 2
  in_oc11 curl -sS -u "$user:$pw" "$@"
}

# ocis_curl <user> <password> <curl-args...>
# Talks to oCIS over the docker network (insecure: self-signed cert).
ocis_curl() {
  local user="$1" pw="$2"; shift 2
  in_oc11 curl -sS -k -u "$user:$pw" "$@"
}

mkdir -p "$ARTIFACTS"
