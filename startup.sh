#!/bin/sh

set -eu

UUID="${XRAY_UUID:-550e8400-e29b-41d4-a716-446655440000}"

DOMAIN=""

if [ -n "${CODESPACE_NAME:-}" ]; then
    DOMAIN="${CODESPACE_NAME}-443.app.github.dev"
fi

echo ""
echo "===================================="
echo "           XRAY READY"
echo "===================================="
echo ""

echo "[+] Domain:"
echo "${DOMAIN}"
echo ""

echo "[+] VLESS Configs:"
echo ""

for IP in \
94.130.50.12 \
50.7.5.83 \
63.141.252.203
do
    echo "vless://${UUID}@${IP}:443?encryption=none&security=tls&sni=${DOMAIN}&type=xhttp&path=%2F&mode=packet-up#codespace-${IP}"
    echo ""
done

echo "[+] Starting Xray..."
echo ""

exec /usr/local/bin/xray run -config /etc/xray/config.json
