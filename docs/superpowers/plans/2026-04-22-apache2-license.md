# Apache 2.0 License Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the GPLv2 license with Apache 2.0 across the entire repository — info.xml, all PHP source files (via SPDX header), and a new LICENSE file.

**Architecture:** Three-part change: (1) update `appinfo/info.xml` licence tag, (2) add `LICENSE` file with Apache 2.0 full text, (3) prepend an SPDX `// SPDX-License-Identifier: Apache-2.0` comment to every `.php` file that doesn't already have one. The `.php-cs-fixer.dist.php` does NOT use an `HeaderCommentFixer` rule, so headers are added manually.

**Tech Stack:** PHP, git

---

## File Map

| Action | File |
|--------|------|
| Modify | `appinfo/info.xml` |
| Create | `LICENSE` |
| Modify (add header) | `appinfo/app.php` |
| Modify (add header) | `appinfo/install.php` |
| Modify (add header) | `lib/Application.php` |
| Modify (add header) | `lib/Command/AssignRole.php` |
| Modify (add header) | `lib/Command/CommandBase.php` |
| Modify (add header) | `lib/Command/CommandMigration.php` |
| Modify (add header) | `lib/Command/Init.php` |
| Modify (add header) | `lib/Command/MigrateFiles.php` |
| Modify (add header) | `lib/Command/MigrateGroups.php` |
| Modify (add header) | `lib/Command/MigrateShares.php` |
| Modify (add header) | `lib/Command/MigrateUsers.php` |
| Modify (add header) | `lib/Command/Verify.php` |
| Modify (add header) | `lib/ConflictLog/LogFile.php` |
| Modify (add header) | `lib/ConflictLog/LogService.php` |
| Modify (add header) | `lib/Helper/EMailAddress.php` |
| Modify (add header) | `lib/Helper/ProcessOutputLineProcessor.php` |
| Modify (add header) | `lib/Helper/SharePermissionMapper.php` |
| Modify (add header) | `lib/Helper/Storage.php` |
| Modify (add header) | `lib/Helper/UserGroupFinder.php` |
| Modify (add header) | `lib/Helper/UserHandler.php` |
| Modify (add header) | `lib/MigrationState/Exceptions/MigrateException.php` |
| Modify (add header) | `lib/MigrationState/Exceptions/UnskippableException.php` |
| Modify (add header) | `lib/MigrationState/Exceptions/VerifyStateException.php` |
| Modify (add header) | `lib/MigrationState/Factory.php` |
| Modify (add header) | `lib/MigrationState/Migration.php` |
| Modify (add header) | `lib/MigrationState/State.php` |
| Modify (add header) | `lib/MigrationState/StateAssignRole.php` |
| Modify (add header) | `lib/MigrationState/StateFinish.php` |
| Modify (add header) | `lib/MigrationState/StateInit.php` |
| Modify (add header) | `lib/MigrationState/StateMigrateFiles.php` |
| Modify (add header) | `lib/MigrationState/StateMigrateGroups.php` |
| Modify (add header) | `lib/MigrationState/StateMigrateShares.php` |
| Modify (add header) | `lib/MigrationState/StateMigrateUsers.php` |
| Modify (add header) | `lib/MigrationState/StateVerify.php` |
| Modify (add header) | `lib/OCIS/Client.php` |
| Modify (add header) | `lib/OCIS/ClientException.php` |
| Modify (add header) | `lib/OCIS/ClientService.php` |
| Modify (add header) | `lib/OCIS/DavException.php` |
| Modify (add header) | `tests/bootstrap.php` |
| Modify (add header) | `tests/unit/ExampleTest.php` |
| Modify (add header) | `tests/unit/RCloneTest.php` |

---

### Task 1: Update `appinfo/info.xml` licence tag

**Files:**
- Modify: `appinfo/info.xml`

- [ ] **Step 1: Change the licence tag**

In `appinfo/info.xml`, replace:
```xml
    <licence>GPLv2</licence>
```
with:
```xml
    <licence>Apache-2.0</licence>
```

- [ ] **Step 2: Verify the change**

Run: `grep licence appinfo/info.xml`
Expected output: `    <licence>Apache-2.0</licence>`

---

### Task 2: Add the Apache 2.0 LICENSE file

**Files:**
- Create: `LICENSE`

- [ ] **Step 1: Create the LICENSE file**

Create `LICENSE` at the repository root with the full Apache 2.0 license text:

```
                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
      not limited to compiled object code, generated documentation,
      and conversions to other media types.

      "Work" shall mean the work of authorship made available under
      the License, as indicated by a copyright notice that is included in
      or attached to the work (an example is provided in the Appendix below).

      "Derivative Works" shall mean any work, whether in Source or Object
      form, that is based on (or derived from) the Work and for which the
      editorial revisions, annotations, elaborations, or other modifications
      represent, as a whole, an original work of authorship. For the purposes
      of this License, Derivative Works shall not include works that remain
      separable from, or merely link (or bind by name) to the interfaces of,
      the Work and Derivative Works thereof.

      "Contribution" shall mean, as submitted to the Licensor for inclusion
      in the Work by the copyright owner or by an individual or Legal Entity
      authorized to submit on behalf of the copyright owner. For the purposes
      of this definition, "submitted" means any form of electronic, verbal,
      or written communication sent to the Licensor or its representatives,
      including but not limited to communication on electronic mailing lists,
      source code control systems, and issue tracking systems that are managed
      by, or on behalf of, the Licensor for the purpose of submitting and
      discussing improvements to the Work, but excluding communication that
      is conspicuously marked or designated in writing by the copyright owner
      as "Not a Contribution."

      "Contributor" shall mean Licensor and any Legal Entity on behalf of
      whom a Contribution has been received by the Licensor and included
      within the Work.

   2. Grant of Copyright License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      copyright license to reproduce, prepare Derivative Works of,
      publicly display, publicly perform, sublicense, and distribute the
      Work and such Derivative Works in Source or Object form.

   3. Grant of Patent License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      (except as stated in this section) patent license to make, have made,
      use, offer to sell, sell, import, and otherwise transfer the Work,
      where such license applies only to those patent contributions made by
      such Contributor that are necessarily infringed by their Contribution(s)
      alone or by the combined work (in which such Contribution(s) were
      submitted. If You institute patent litigation against any entity
      (including a cross-claim or counterclaim in a lawsuit) alleging that
      the Work or any Contributor's contributions directly or indirectly
      infringe any patent, then any patent rights granted to You under this
      License for that Work shall terminate as of the date such litigation is
      filed.

   4. Redistribution. You may reproduce and distribute copies of the
      Work or Derivative Works thereof in any medium, with or without
      modifications, and in Source or Object form, provided that You
      meet the following conditions:

      (a) You must give any other recipients of the Work or Derivative
          Works a copy of this License; and

      (b) You must cause any modified files to carry prominent notices
          stating that You changed the files; and

      (c) You must retain, in the Source form of any Derivative Works
          that You distribute, all copyright, patent, trademark, and
          attribution notices from the Source form of the Work,
          excluding those notices that do not pertain to any part of
          the Derivative Works; and

      (d) If the Work includes a "NOTICE" text file as part of its
          distribution, You must include a readable copy of the
          attribution notices contained within such NOTICE file, in
          at least one of the following places: within a NOTICE text
          file distributed as part of the Derivative Works; within
          the Source form or documentation, if provided along with the
          Derivative Works; or, within a display generated by the
          Derivative Works, if and wherever such third-party notices
          normally appear. The contents of the NOTICE file are for
          informational purposes only and do not modify the License.
          You may add Your own attribution notices within Derivative
          Works that You distribute, alongside or in addition to the
          NOTICE text from the Work, provided that such additional
          attribution notices cannot be construed as modifying the License.

      You may add Your own license statement for Your modifications and
      may provide additional grant of rights to use, copy, modify, merge,
      publish, distribute, sublicense, and/or sell copies of the
      Contribution, either on an explicit royalty-free basis or
      commercially with fees.

   5. Submission of Contributions. Unless You explicitly state otherwise,
      any Contribution intentionally submitted for inclusion in the Work
      by You to the Licensor shall be under the terms and conditions of
      this License, without any additional terms or conditions.
      Notwithstanding the above, nothing herein shall supersede or modify
      the terms of any separate license agreement you may have executed
      with Licensor regarding such Contributions.

   6. Trademarks. This License does not grant permission to use the trade
      names, trademarks, service marks, or product names of the Licensor,
      except as required for reasonable and customary use in describing the
      origin of the Work and reproducing the content of the NOTICE file.

   7. Disclaimer of Warranty. Unless required by applicable law or
      agreed to in writing, Licensor provides the Work (and each
      Contributor provides its Contributions) on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
      implied, including, without limitation, any conditions of title,
      MERCHANTIBILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are
      solely responsible for determining the appropriateness of using or
      redistributing the Work and assume any risks associated with Your
      exercise of permissions under this License.

   8. Limitation of Liability. In no event and under no legal theory,
      whether in tort (including negligence), contract, or otherwise,
      unless required by applicable law (such as deliberate and grossly
      negligent acts) or agreed to in writing, shall any Contributor be
      liable to You for damages, including any direct, indirect, special,
      incidental, or exemplary damages of any character arising as a
      result of this License or out of the use or inability to use the
      Work (including but not limited to damages for loss of goodwill,
      work stoppage, computer failure or malfunction, or all other
      commercial damages or losses), even if such Contributor has been
      advised of the possibility of such damages.

   9. Accepting Warranty or Additional Liability. While redistributing
      the Work or Derivative Works thereof, You may choose to offer,
      and charge a fee for, acceptance of support, warranty, indemnity,
      or other liability obligations and/or rights consistent with this
      License. However, in accepting such obligations, You may offer only
      conditions on Your own behalf and on behalf of all other Contributors,
      to imply their acceptance of the License terms.

   END OF TERMS AND CONDITIONS

   APPENDIX: How to apply the Apache License to your work.

      To apply the Apache License to your work, attach the following
      boilerplate notice, with the fields enclosed by brackets "[]"
      replaced with your own identifying information. (Don't include
      the brackets!)  The text should be enclosed in the appropriate
      comment syntax for the file format; patent notices for most
      files should be omitted.

   Copyright [yyyy] [name of copyright owner]

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
```

- [ ] **Step 2: Verify the file**

Run: `head -3 LICENSE`
Expected output:
```
                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/
```

---

### Task 3: Add SPDX headers to all PHP files

**Files:**
- Modify: all `.php` files listed in the file map above

The SPDX header to add is a single line inserted after the opening `<?php` tag (with a blank line between them):

```php
<?php

// SPDX-License-Identifier: Apache-2.0
```

For files where `<?php` is immediately followed by a namespace declaration (no blank line), insert the header line and preserve the blank line:

```php
<?php
// SPDX-License-Identifier: Apache-2.0

namespace ...
```

Use the pattern: after `<?php`, on the very next line, insert `// SPDX-License-Identifier: Apache-2.0`.

- [ ] **Step 1: Add SPDX header to all PHP files using sed**

Run this from the repository root:

```bash
find . -name "*.php" \
  ! -path "./vendor/*" \
  ! -path "./vendor-bin/*" \
  ! -path "./.phan/*" \
  -exec sed -i '1s|^<?php$|<?php\n// SPDX-License-Identifier: Apache-2.0|' {} \;
```

- [ ] **Step 2: Verify headers were added**

Run: `grep -l "SPDX-License-Identifier" $(find . -name "*.php" ! -path "./vendor/*" ! -path "./vendor-bin/*" ! -path "./.phan/*")`

Expected: all PHP files listed in the file map are printed (42 files total).

Run: `grep -L "SPDX-License-Identifier" $(find . -name "*.php" ! -path "./vendor/*" ! -path "./vendor-bin/*" ! -path "./.phan/*")`

Expected: no output (all files covered).

- [ ] **Step 3: Spot-check a few files**

Run: `head -3 lib/Application.php lib/OCIS/Client.php tests/unit/ExampleTest.php`

Expected for each file: first line `<?php`, second line `// SPDX-License-Identifier: Apache-2.0`.

---

### Task 4: Commit all changes

**Files:** all modified/created files

- [ ] **Step 1: Stage all changes**

```bash
git add LICENSE appinfo/info.xml appinfo/app.php appinfo/install.php \
  lib/Application.php \
  lib/Command/AssignRole.php lib/Command/CommandBase.php lib/Command/CommandMigration.php \
  lib/Command/Init.php lib/Command/MigrateFiles.php lib/Command/MigrateGroups.php \
  lib/Command/MigrateShares.php lib/Command/MigrateUsers.php lib/Command/Verify.php \
  lib/ConflictLog/LogFile.php lib/ConflictLog/LogService.php \
  lib/Helper/EMailAddress.php lib/Helper/ProcessOutputLineProcessor.php \
  lib/Helper/SharePermissionMapper.php lib/Helper/Storage.php \
  lib/Helper/UserGroupFinder.php lib/Helper/UserHandler.php \
  lib/MigrationState/Exceptions/MigrateException.php \
  lib/MigrationState/Exceptions/UnskippableException.php \
  lib/MigrationState/Exceptions/VerifyStateException.php \
  lib/MigrationState/Factory.php lib/MigrationState/Migration.php \
  lib/MigrationState/State.php lib/MigrationState/StateAssignRole.php \
  lib/MigrationState/StateFinish.php lib/MigrationState/StateInit.php \
  lib/MigrationState/StateMigrateFiles.php lib/MigrationState/StateMigrateGroups.php \
  lib/MigrationState/StateMigrateShares.php lib/MigrationState/StateMigrateUsers.php \
  lib/MigrationState/StateVerify.php \
  lib/OCIS/Client.php lib/OCIS/ClientException.php \
  lib/OCIS/ClientService.php lib/OCIS/DavException.php \
  tests/bootstrap.php tests/unit/ExampleTest.php tests/unit/RCloneTest.php
```

- [ ] **Step 2: Commit**

```bash
git commit -m "$(cat <<'EOF'
chore: relicense from GPLv2 to Apache-2.0

- Add LICENSE file (Apache 2.0 full text)
- Update appinfo/info.xml licence tag to Apache-2.0
- Add SPDX-License-Identifier: Apache-2.0 header to all PHP source files

Closes #26

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
EOF
)"
```

- [ ] **Step 3: Verify the commit**

Run: `git show --stat HEAD`

Expected: shows `LICENSE` created, `appinfo/info.xml` modified, and all PHP files modified.
