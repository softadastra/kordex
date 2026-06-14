#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "${ROOT_DIR}"

echo "==> Building and installing Kordex"

vix build --clean --preset dev-ninja --build-target install -v -- \
  -DKORDEX_ENABLE_QUICKJS=ON \
  -DKORDEX_ENABLE_NATIVE_ENGINE=OFF \
  -DKORDEX_BUILD_APP=ON \
  -DKORDEX_ENABLE_INSTALL=ON \
  -DCMAKE_INSTALL_PREFIX="${ROOT_DIR}/install-kordex"

echo "==> Packaging Linux archive"

"${ROOT_DIR}/scripts/package-linux.sh"

echo "==> Packaging npm Linux package"

"${ROOT_DIR}/scripts/package-npm-linux.sh"

echo ""
echo "Linux local release created:"
echo "  dist/kordex-linux-x86_64.tar.gz"
echo "  dist/kordex-linux-x86_64.tar.gz.sha256"
echo "  npm/kordex/kordex-0.1.0.tgz"
