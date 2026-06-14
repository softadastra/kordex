#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

MAIN_PACKAGE="${ROOT_DIR}/npm/kordex/kordex-0.1.0.tgz"
LINUX_PACKAGE="${ROOT_DIR}/npm/linux-x64/kordex-linux-x64-0.1.0.tgz"
TEST_DIR="${HOME}/kordex-npm-test"

if [ ! -f "${LINUX_PACKAGE}" ]; then
  echo "error: Linux npm package not found: ${LINUX_PACKAGE}" >&2
  echo "hint: run ./scripts/package-npm-linux.sh or ./scripts/release-linux-local.sh first." >&2
  exit 1
fi

if [ ! -f "${MAIN_PACKAGE}" ]; then
  echo "error: main npm package not found: ${MAIN_PACKAGE}" >&2
  echo "hint: run ./scripts/package-npm-linux.sh or ./scripts/release-linux-local.sh first." >&2
  exit 1
fi

rm -rf "${TEST_DIR}"
mkdir -p "${TEST_DIR}"

cd "${TEST_DIR}"

npm init -y >/dev/null

npm install "${LINUX_PACKAGE}"
npm install "${MAIN_PACKAGE}"

cat > main.js <<'EOF'
console.log("Hello from split Kordex npm packages");
EOF

./node_modules/.bin/kordex --version
./node_modules/.bin/kordex run main.js
npx kordex run main.js

echo "Kordex split npm Linux package test passed."
