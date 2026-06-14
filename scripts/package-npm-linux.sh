#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

MAIN_NPM_DIR="${ROOT_DIR}/npm/kordex"
LINUX_NPM_DIR="${ROOT_DIR}/npm/linux-x64"
LINUX_BIN_DIR="${LINUX_NPM_DIR}/bin"
BINARY="${ROOT_DIR}/install-kordex/bin/kordex"

if [ ! -x "${BINARY}" ]; then
  echo "error: Kordex binary not found or not executable: ${BINARY}" >&2
  echo "hint: run the install build first." >&2
  exit 1
fi

echo "==> Packaging @softadastra/kordex-linux-x64"

rm -rf "${LINUX_BIN_DIR}"
mkdir -p "${LINUX_BIN_DIR}"

cp "${BINARY}" "${LINUX_BIN_DIR}/kordex"
chmod +x "${LINUX_BIN_DIR}/kordex"

cd "${LINUX_NPM_DIR}"
rm -f *.tgz
npm pack

rm -rf "${LINUX_BIN_DIR}"

echo "==> Packaging kordex wrapper"

cd "${MAIN_NPM_DIR}"
rm -f *.tgz
npm pack

echo ""
echo "Created:"
ls -lah "${LINUX_NPM_DIR}"/*.tgz
ls -lah "${MAIN_NPM_DIR}"/*.tgz
