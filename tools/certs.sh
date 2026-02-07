#!/usr/bin/env sh
set -eu

CERT_DIR="$1"
CERT_NAME="$2"

CRT="$CERT_DIR/$CERT_NAME.crt"
KEY="$CERT_DIR/$CERT_NAME.key"

if [ -f "$CRT" ]; then
    echo "Certificate already exists: $CRT"
    exit 0
fi

echo "Generating certificate for $CERT_NAME"

mkcert \
    -cert-file "$CRT" \
    -key-file "$KEY" \
    localhost 127.0.0.1

chmod 644 "$CRT"
chmod 400 "$KEY"

echo "Done"
