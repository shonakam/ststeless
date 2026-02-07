#!/usr/bin/env sh
set -eu

echo "Checking mkcert..."

if command -v mkcert >/dev/null 2>&1; then
	echo "mkcert already installed"
	exit 0
fi

echo "Installing mkcert..."

if command -v brew >/dev/null 2>&1; then
	brew install mkcert
elif command -v apt-get >/dev/null 2>&1; then
	sudo apt-get update
	sudo apt-get install -y libnss3-tools
	curl -L https://dl.filippo.io/mkcert/latest?for=linux/amd64 -o mkcert
	chmod +x mkcert
	sudo mv mkcert /usr/local/bin/mkcert
elif command -v yum >/dev/null 2>&1; then
	sudo yum install -y nss-tools
	curl -L https://dl.filippo.io/mkcert/latest?for=linux/amd64 -o mkcert
	chmod +x mkcert
	sudo mv mkcert /usr/local/bin/mkcert
else
	echo "Unsupported OS"
	exit 1
fi

echo "Installing mkcert local CA..."
mkcert -install

echo "mkcert installation complete"
