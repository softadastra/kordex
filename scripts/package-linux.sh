#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INSTALL_DIR="${ROOT_DIR}/install-kordex"
PACKAGE_ROOT="${ROOT_DIR}/package-root"
DIST_DIR="${ROOT_DIR}/dist"
ASSET_NAME="kordex-linux-x86_64.tar.gz"

cd "${ROOT_DIR}"

rm -rf "${PACKAGE_ROOT}" "${DIST_DIR}"
mkdir -p "${PACKAGE_ROOT}/bin" "${DIST_DIR}"

cp "${INSTALL_DIR}/bin/kordex" "${PACKAGE_ROOT}/bin/"
cp README.md "${PACKAGE_ROOT}/"
cp LICENSE "${PACKAGE_ROOT}/"

tar -C "${PACKAGE_ROOT}" -czf "${DIST_DIR}/${ASSET_NAME}" .

cd "${DIST_DIR}"
sha256sum "${ASSET_NAME}" > "${ASSET_NAME}.sha256"
sha256sum -c "${ASSET_NAME}.sha256"

cd "${ROOT_DIR}"
rm -rf "${PACKAGE_ROOT}"

echo "Created ${DIST_DIR}/${ASSET_NAME}"
echo "Created ${DIST_DIR}/${ASSET_NAME}.sha256"
