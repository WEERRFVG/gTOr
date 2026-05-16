#!/bin/sh

if pgrep xray >/dev/null
then
    exit 0
else
    echo "[!] Xray process stopped"
    exit 1
fi
