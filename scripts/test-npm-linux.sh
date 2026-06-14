#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGE="${ROOT_DIR}/npm/kordex/kordex-0.1.0.tgz"
TEST_DIR="${HOME}/kordex-npm-test"

if [ ! -f "${PACKAGE}" ]; then
  echo "error: npm package not found: ${PACKAGE}" >&2
  echo "hint: run ./scripts/package-npm-linux.sh or ./scripts/release-linux-local.sh first." >&2
  exit 1
fi

rm -rf "${TEST_DIR}"
mkdir -p "${TEST_DIR}"

cd "${TEST_DIR}"

npm init -y >/dev/null
npm install "${PACKAGE}"

cat > main.js <<'EOF'
console.log("Hello from Kordex npm package");
EOF

./node_modules/.bin/kordex --version
./node_modules/.bin/kordex run main.js
npx kordex run main.js

echo "Kordex npm Linux package test passed."
