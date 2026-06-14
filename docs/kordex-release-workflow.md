# Kordex Daily Update and Release Workflow

This document describes the workflow to follow when updating Kordex, testing it, packaging it, and publishing a new npm version.

Kordex is distributed through:

```txt
kordex
@softadastra/kordex-linux-x64
```

The `kordex` package is the npm CLI wrapper.

The `@softadastra/kordex-linux-x64` package contains the Linux x64 native binary.

## 1. Start from a clean repository

From the Kordex root:

```bash
cd /home/softadastra/softadastra/kordex
git status
```

Expected result:

```txt
nothing to commit, working tree clean
```

If the repository is not clean, commit or restore the current changes before starting a new update.

## 2. Update Kordex source code

Work on the correct module or file.

Examples:

```txt
modules/runtime
modules/bindings
modules/std
modules/cli
README.md
npm/kordex
npm/linux-x64
scripts
```

If the change is inside a submodule, commit inside the submodule first.

Example:

```bash
cd modules/cli
git status
git add src/RunCommand.cpp
git commit -m "fix(run): do not print success message after scripts"
git push
```

Then return to the main repository:

```bash
cd /home/softadastra/softadastra/kordex
git status
```

Commit the updated submodule pointer:

```bash
git add modules/cli
git commit -m "chore(cli): update CLI module"
```

## 3. Build and install locally

From the Kordex root:

```bash
vix build --clean --preset dev-ninja --build-target install -v -- \
  -DKORDEX_ENABLE_QUICKJS=ON \
  -DKORDEX_ENABLE_NATIVE_ENGINE=OFF \
  -DKORDEX_BUILD_APP=ON \
  -DKORDEX_ENABLE_INSTALL=ON \
  -DCMAKE_INSTALL_PREFIX="$PWD/install-kordex"
```

Verify the installed binary:

```bash
./install-kordex/bin/kordex --version
```

Expected output example:

```txt
Kordex 0.1.0
```

## 4. Test basic JavaScript execution

Create a temporary test file:

```bash
cat > /tmp/kordex-test.js <<'EOF'
console.log("Hello from Kordex");
EOF
```

Run it:

```bash
./install-kordex/bin/kordex run /tmp/kordex-test.js
```

Expected output:

```txt
Hello from Kordex
```

The CLI should not print extra success messages such as:

```txt
Ran main.js
```

## 5. Create the local Linux release

Run:

```bash
./scripts/package-linux.sh
```

Expected files:

```txt
dist/kordex-linux-x86_64.tar.gz
dist/kordex-linux-x86_64.tar.gz.sha256
```

Verify the checksum:

```bash
cd dist
sha256sum -c kordex-linux-x86_64.tar.gz.sha256
cd ..
```

Expected output:

```txt
kordex-linux-x86_64.tar.gz: OK
```

## 6. Test the Linux archive

```bash
rm -rf ~/kordex-archive-test
mkdir -p ~/kordex-archive-test

tar -xzf dist/kordex-linux-x86_64.tar.gz -C ~/kordex-archive-test

~/kordex-archive-test/bin/kordex --version
```

Expected output:

```txt
Kordex 0.1.0
```

Test script execution:

```bash
cat > ~/kordex-archive-test/main.js <<'EOF'
console.log("Hello from Kordex archive");
EOF

~/kordex-archive-test/bin/kordex run ~/kordex-archive-test/main.js
```

Expected output:

```txt
Hello from Kordex archive
```

## 7. Build the npm packages locally

Kordex npm distribution is split into two packages:

```txt
@softadastra/kordex-linux-x64
kordex
```

Run:

```bash
./scripts/package-npm-linux.sh
```

Expected files:

```txt
npm/linux-x64/softadastra-kordex-linux-x64-<version>.tgz
npm/kordex/kordex-<version>.tgz
```

The native package should contain the binary:

```txt
bin/kordex
index.js
package.json
```

The wrapper package should stay small:

```txt
bin/kordex.js
README.md
package.json
```

## 8. Test the npm packages locally

Run:

```bash
./scripts/test-npm-linux.sh
```

Expected output:

```txt
Kordex 0.1.0
Hello from split Kordex npm packages
Hello from split Kordex npm packages
Kordex split npm Linux package test passed.
```

This validates:

```txt
npm install local native package
npm install local wrapper package
node_modules/.bin/kordex --version
node_modules/.bin/kordex run main.js
npx kordex run main.js
```

## 9. Run the full local release workflow

For a complete local Linux release, run:

```bash
./scripts/release-linux-local.sh
```

This performs:

```txt
build install
Linux archive package
SHA256 checksum
npm native package
npm wrapper package
```

Then run the npm smoke test again:

```bash
./scripts/test-npm-linux.sh
```

## 10. Update package versions

There are two kinds of releases.

### Wrapper-only release

Use this when only the npm README, wrapper script, package metadata, or documentation changed.

Update only:

```txt
npm/kordex/package.json
```

Example:

```json
{
  "version": "0.1.1"
}
```

Keep the native dependency unchanged if the binary did not change:

```json
"optionalDependencies": {
  "@softadastra/kordex-linux-x64": "0.1.0"
}
```

Publish only:

```txt
kordex
```

### Native runtime release

Use this when the C++ runtime binary changed.

Update:

```txt
npm/linux-x64/package.json
npm/kordex/package.json
```

Example:

```json
{
  "version": "0.1.1"
}
```

Also update the wrapper dependency:

```json
"optionalDependencies": {
  "@softadastra/kordex-linux-x64": "0.1.1"
}
```

Publish in this order:

```txt
1. @softadastra/kordex-linux-x64
2. kordex
```

The native package must always be published before the wrapper package.

## 11. Dry-run before publishing

Before publishing, always run:

```bash
npm publish npm/linux-x64/*.tgz --dry-run --access public
npm publish npm/kordex/*.tgz --dry-run
```

Check the output carefully.

The native package must include:

```txt
bin/kordex
index.js
package.json
```

The wrapper package must include:

```txt
README.md
bin/kordex.js
package.json
```

## 12. Publish to npm

### Native runtime release

Publish native package first:

```bash
npm publish npm/linux-x64/*.tgz --access public
```

Then publish the wrapper:

```bash
npm publish npm/kordex/*.tgz
```

### Wrapper-only release

Publish only the wrapper:

```bash
npm publish npm/kordex/*.tgz
```

## 13. Verify npm publication

Check versions:

```bash
npm view @softadastra/kordex-linux-x64 version
npm view kordex version
```

Check package info:

```bash
npm info kordex
npm info @softadastra/kordex-linux-x64
```

Expected:

```txt
latest version is visible
maintainer is softadastra
package description is correct
README is visible on npm
```

## 14. Test from the official npm registry

Create a clean test project:

```bash
rm -rf ~/kordex-real-npm-test
mkdir -p ~/kordex-real-npm-test
cd ~/kordex-real-npm-test

npm init -y
npm install kordex
```

Test the CLI:

```bash
npx kordex --version
```

Create a script:

```bash
cat > main.js <<'EOF'
console.log("Hello from official npm Kordex");
EOF
```

Run it:

```bash
npx kordex run main.js
```

Expected output:

```txt
Hello from official npm Kordex
```

## 15. Commit source changes

Generated artifacts should not be committed.

Do not commit:

```txt
dist/
install-kordex/
build-ninja/
npm/kordex/*.tgz
npm/linux-x64/*.tgz
npm/linux-x64/bin/
npm/kordex/native/
```

Commit only source files, scripts, docs, package metadata, and submodule pointers.

Example:

```bash
git status
git add .
git commit -m "chore(npm): prepare Kordex release"
git push origin main
```

Use specific commit messages when possible:

```txt
fix(run): do not print success message after scripts
docs(npm): improve Kordex package README
chore(npm): update package versions
chore(release): update Linux release workflow
test(npm): validate npm package smoke test
```

## 16. Tag a release when needed

For a real runtime release, create a tag:

```bash
git tag v0.1.1
git push origin v0.1.1
```

Use a tag when the runtime binary changes and a GitHub Release should be generated.

For a README-only npm release, a tag is optional.

## 17. Daily checklist

Before ending the day, confirm:

```txt
git status is clean
CI is green
npm package test passes
README is updated if public behavior changed
CHANGELOG is updated if runtime behavior changed
package versions are consistent
published npm version works from a clean project
```

Commands:

```bash
git status
git log --oneline -5
./scripts/release-linux-local.sh
./scripts/test-npm-linux.sh
npm view kordex version
```

## 18. Release rules

Use these rules to avoid mistakes:

```txt
Never publish the wrapper before the native package.
Never publish a package without dry-run.
Never commit generated .tgz files.
Never commit native binaries into npm source folders.
Never reuse an npm version.
Never publish a new npm version before testing it locally.
Never assume npm has updated instantly; verify with npm view.
```

## 19. Current npm package layout

```txt
npm/
├── kordex/
│   ├── README.md
│   ├── package.json
│   └── bin/
│       └── kordex.js
│
└── linux-x64/
    ├── package.json
    └── index.js
```

Generated during packaging:

```txt
npm/kordex/kordex-<version>.tgz
npm/linux-x64/softadastra-kordex-linux-x64-<version>.tgz
npm/linux-x64/bin/kordex
```

After packaging, `npm/linux-x64/bin/` must be removed automatically by the script.

## 20. Current public npm packages

```txt
kordex
@softadastra/kordex-linux-x64
```

Install:

```bash
npm install kordex
```

Run:

```bash
npx kordex --version
npx kordex run main.js
```
