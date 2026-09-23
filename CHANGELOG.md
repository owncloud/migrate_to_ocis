# Table of Contents

* [Changelog for 3.0.2](#changelog-for-302-2026-09-23)
* [Changelog for 3.0.1](#changelog-for-301-2026-08-20)
* [Changelog for 3.0.0](#changelog-for-300-2026-07-27)
* [Changelog for 2.0.1](#changelog-for-201-2026-07-24)
* [Changelog for 2.0.0](#changelog-for-200-2026-07-02)

# Changelog for [3.0.2] (2026-09-23)

The following sections list the changes for 3.0.2.

[3.0.2]: https://github.com/owncloud/migrate_to_ocis/compare/v3.0.1...v3.0.2

## Summary

* Security - Update the bundled rclone binary to upstream v1.75.1: [#66](https://github.com/owncloud/migrate_to_ocis/issues/66)
* Bugfix - Fix the file migration when the insecure flag is not set: [#63](https://github.com/owncloud/migrate_to_ocis/issues/63)

## Details

* Security - Update the bundled rclone binary to upstream v1.75.1: [#66](https://github.com/owncloud/migrate_to_ocis/issues/66)

   The app bundled upstream rclone v1.75.0, whose known HIGH findings were Go
   standard library ones plus one in golang.org/x/crypto, all accepted with an
   expiry date because no rclone release carried the fixes yet. Advisories
   published since then turned the scan red with six findings those acceptances did
   not cover. Four were in rclone itself: CVE-2026-88018 (a full SigV4 signature
   bypass - `rclone serve s3 --auth-proxy` without `--auth-key` authenticates
   nobody) and CVE-2026-88044 (an `rclone rc` per-server auth-proxy bypass), both
   CRITICAL, plus CVE-2026-88017 (FTP cross-session auth-proxy confusion) and
   CVE-2026-88045 (S3 multipart memory exhaustion). The remaining two were not in
   rclone itself: CVE-2026-46603 (a golang.org/x/image/vp8l denial of service) and
   CVE-2026-84445 (a gRPC-Go denial of service).

   We've updated the binary to the official upstream release v1.75.1, which fixes
   all four rclone issues and vendors golang.org/x/image v0.45.0. Only the gRPC-Go
   finding is left, because v1.75.1 still pins the pseudo-version of
   google.golang.org/grpc that predates the fix. rclone master already carries the
   fixed one, so it clears with the next rclone release; until then it is accepted
   with an expiry date in .trivyignore.yaml, and it is not reachable here - the
   crash needs an inbound RPC to an xDS gRPC server, and this app only runs `rclone
   sync` between two WebDAV remotes and `rclone obscure`.

   Two further fixes in v1.75.1 land on the code path this app actually uses, even
   though neither reached the severity that failed the scan: CVE-2026-88046 stops
   source object names escaping the configured root on upload, and
   GHSA-3vxh-3pcx-9m8q confines names taken from a server's listing response to the
   directory that was listed.

   The update also retired the nine acceptances that file carried before. v1.75.1
   is built with go1.26.8, which closes the eight Go standard library findings
   accepted against v1.75.0's go1.26.5, and it vendors golang.org/x/crypto v0.56.0,
   which closes CVE-2026-56854.

   https://github.com/owncloud/migrate_to_ocis/issues/66
   https://github.com/owncloud/migrate_to_ocis/pull/67

* Bugfix - Fix the file migration when the insecure flag is not set: [#63](https://github.com/owncloud/migrate_to_ocis/issues/63)

   The rclone argument list was built with a ternary that produced an empty string
   whenever the migration had not been initialised with `--insecure`. Symfony's
   Process hands every element of that list to the binary as a discrete argument,
   so rclone received an empty argument, counted it as a third positional one next
   to the two remotes, and refused to run with `Command sync needs 2 arguments
   maximum: you provided 3 non flag arguments`.

   We've changed the argument list so that `--no-check-certificate` is only added
   when it actually applies. Migrating files against an oCIS with a trusted
   certificate - the only case affected - works again. The end-to-end test always
   initialises with `-k`, which is why this never surfaced in CI, so the argument
   list is now covered by unit tests for both cases.

   https://github.com/owncloud/migrate_to_ocis/issues/63
   https://github.com/owncloud/migrate_to_ocis/pull/68

# Changelog for [3.0.1] (2026-08-20)

The following sections list the changes for 3.0.1.

[3.0.1]: https://github.com/owncloud/migrate_to_ocis/compare/v3.0.0...v3.0.1

## Summary

* Security - Update the bundled rclone binary to upstream v1.75.0: [#56](https://github.com/owncloud/migrate_to_ocis/pull/56)

## Details

* Security - Update the bundled rclone binary to upstream v1.75.0: [#56](https://github.com/owncloud/migrate_to_ocis/pull/56)

   The app shipped a custom rclone fork build (v1.67.0-beta.8042.483c2feed, built
   2024-07-01 with Go 1.22.4). That binary carried 23 HIGH/CRITICAL
   vulnerabilities, 16 of them Go standard library issues - among them
   CVE-2025-68121 (crypto/tls certificate validation), CVE-2024-45337
   (golang.org/x/crypto) and CVE-2026-33186 (gRPC).

   We've replaced it with the official upstream release v1.75.0, which is built
   with Go 1.26.5 and reports no known HIGH or CRITICAL vulnerabilities. The fork
   was not needed: the app only runs `rclone sync` and `rclone obscure` against
   `type=webdav,vendor=owncloud` remotes, and upstream supports every flag the app
   passes, including `--webdav-owncloud-exclude-shares` and
   `--webdav-owncloud-exclude-mounts`.

   https://github.com/owncloud/migrate_to_ocis/pull/56

# Changelog for [3.0.0] (2026-07-27)

The following sections list the changes for 3.0.0.

[3.0.0]: https://github.com/owncloud/migrate_to_ocis/compare/v2.0.1...v3.0.0

## Summary

* Change - Support ownCloud Server 11 and drop ownCloud 10: [#53](https://github.com/owncloud/migrate_to_ocis/pull/53)

## Details

* Change - Support ownCloud Server 11 and drop ownCloud 10: [#53](https://github.com/owncloud/migrate_to_ocis/pull/53)

   This release targets ownCloud Server 11. The app now requires PHP 8.3 or newer,
   matching the ownCloud 11 runtime baseline, and its dependency range is pinned to
   ownCloud 11 only. As a consequence it no longer installs on ownCloud 10, which
   continues to be served by the 2.0.x release line.

   The release tarball is now signed with a G2 code-signing certificate using the
   standalone `ocsign` tool, because ownCloud 11 mandates a valid app signature and
   removed the `occ integrity:sign-app` command.

   https://github.com/owncloud/migrate_to_ocis/pull/53

# Changelog for [2.0.1] (2026-07-24)

The following sections list the changes for 2.0.1.

[2.0.1]: https://github.com/owncloud/migrate_to_ocis/compare/v2.0.0...v2.0.1

## Summary

* Bugfix - Select the migration role by name in the acceptance test: [#42](https://github.com/owncloud/migrate_to_ocis/issues/42)
* Change - Ship a properly signed release tarball: [#49](https://github.com/owncloud/migrate_to_ocis/pull/49)

## Details

* Bugfix - Select the migration role by name in the acceptance test: [#42](https://github.com/owncloud/migrate_to_ocis/issues/42)

   We fixed a flaky acceptance test that intermittently failed during file
   migration with "409 Conflict: intermediate collection does not exist". oCIS
   returns the available roles in a non-deterministic order, and the test picked
   the role by index (0), which sometimes resolved to the "User Light" role. That
   role has no personal drive, so migrated users had no home folder and the file
   migration failed.

   The migration driver now answers the role prompt with the role label "User"
   instead of an index, which deterministically selects the standard role
   regardless of the order oCIS returns the roles in.

   https://github.com/owncloud/migrate_to_ocis/issues/42

* Change - Ship a properly signed release tarball: [#49](https://github.com/owncloud/migrate_to_ocis/pull/49)

   The 2.0.0 release tarball was not signed with the ownCloud code-signing
   certificate, so it could not be verified by ownCloud Classic's integrity check.
   The 2.0.1 release distribution is signed with the G1 code-signing certificate,
   allowing `occ integrity:check-app migrate_to_ocis` to validate the app.

   https://github.com/owncloud/migrate_to_ocis/pull/49

# Changelog for [2.0.0] (2026-07-02)

The following sections list the changes for 2.0.0.

## Summary

* Change - Relicense from GPLv2 to Apache-2.0: [#27](https://github.com/owncloud/migrate_to_ocis/pull/27)

## Details

* Change - Relicense from GPLv2 to Apache-2.0: [#27](https://github.com/owncloud/migrate_to_ocis/pull/27)

   We relicensed the app from GPLv2 to the Apache License 2.0. The LICENSE file now
   carries the full Apache 2.0 text, the `licence` tag in `appinfo/info.xml` is set
   to `APL2`, and every PHP source file carries an `SPDX-License-Identifier:
   Apache-2.0` header.

   https://github.com/owncloud/migrate_to_ocis/issues/26
   https://github.com/owncloud/migrate_to_ocis/pull/27
