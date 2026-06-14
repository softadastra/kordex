#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NPM_DIR="${ROOT_DIR}/npm/kordex"
NATIVE_DIR="${NPM_DIR}/native/linux-x64/bin"
BINARY="${ROOT_DIR}/install-kordex/bin/kordex"

if [ ! -x "${BINARY}" ]; then
  echo "error: Kordex binary not found or not executable: ${BINARY}" >&2
  echo "hint: run the install build first." >&2
  exit 1
fi

rm -rf "${NPM_DIR}/native"
mkdir -p "${NATIVE_DIR}"

cp "${BINARY}" "${NATIVE_DIR}/kordex"
chmod +x "${NATIVE_DIR}/kordex"

cd "${NPM_DIR}"

rm -f kordex-*.tgz

npm pack

rm -rf "${NPM_DIR}/native"

echo "Created ${NPM_DIR}/kordex-0.1.0.tgz"
