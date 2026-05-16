#!/bin/sh

set -eu

XRAY_VERSION="v26.3.27"
XRAY_URL="https://github.com/XTLS/Xray-core/releases/download/${XRAY_VERSION}/Xray-linux-64.zip"

TMP_DIR="/tmp/xray-install"

echo "[+] Installing Xray..."

mkdir -p "${TMP_DIR}"

cd "${TMP_DIR}"

wget -q -O xray.zip "${XRAY_URL}"

unzip -oq xray.zip

install -m 755 xray /usr/local/bin/xray

rm -rf "${TMP_DIR}"

echo "[+] Xray installed successfully"
