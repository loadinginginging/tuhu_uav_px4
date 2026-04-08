#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEFAULT_TARGET="${PX4_DEFAULT_TARGET:-px4_fmu-v6c_default}"

cd "${ROOT_DIR}"

if ! command -v git >/dev/null 2>&1; then
	echo "git is required before running this script."
	exit 1
fi

echo "[1/3] Syncing submodule URLs"
git submodule sync --recursive

echo "[2/3] Updating submodules"
git submodule update --init --recursive

echo "[3/3] Installing Ubuntu build dependencies"
bash "${ROOT_DIR}/Tools/setup/ubuntu.sh" "$@"

cat <<EOF

Environment setup finished.

If this is the first time you ran the script, open a new shell or run:
  source ~/.profile

Default build example:
  make ${DEFAULT_TARGET}
EOF
