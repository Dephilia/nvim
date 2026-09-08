#!/usr/bin/env bash
# Build an offline tarball of this config plus vim.pack plugins and mason packages.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"
NAME="nvim-offline-${OS}-${ARCH}"
STAGING="${STAGING:-$ROOT/dist/staging}"
XDG_ROOT="${XDG_ROOT:-$ROOT/dist/xdg}"
OUT_DIR="${OUT_DIR:-$ROOT/dist}"
BUNDLE="$STAGING/$NAME"

MASON_PACKAGES=(
  lua-language-server
  clangd
  rust-analyzer
  bash-language-server
  html-lsp
  typescript-language-server
  ruff
)

if ! command -v nvim >/dev/null 2>&1; then
  echo "nvim is required to build the bundle" >&2
  exit 1
fi

rm -rf "$STAGING" "$XDG_ROOT"
mkdir -p \
  "$XDG_ROOT/config" \
  "$XDG_ROOT/data" \
  "$XDG_ROOT/state" \
  "$XDG_ROOT/cache" \
  "$BUNDLE/config" \
  "$BUNDLE/data" \
  "$OUT_DIR"

ln -sfn "$ROOT" "$XDG_ROOT/config/nvim"

export XDG_CONFIG_HOME="$XDG_ROOT/config"
export XDG_DATA_HOME="$XDG_ROOT/data"
export XDG_STATE_HOME="$XDG_ROOT/state"
export XDG_CACHE_HOME="$XDG_ROOT/cache"

echo "Installing vim.pack plugins..."
nvim --headless +qa

echo "Installing mason packages..."
nvim --headless \
  --cmd "set rtp+=$ROOT" \
  -c "MasonInstall ${MASON_PACKAGES[*]}" \
  -c qa

echo "Assembling $NAME..."
rsync -a --exclude '.git' --exclude 'dist' "$ROOT/" "$BUNDLE/config/"
if [[ -d "$XDG_DATA_HOME/nvim/site" ]]; then
  mkdir -p "$BUNDLE/data/site"
  rsync -a "$XDG_DATA_HOME/nvim/site/" "$BUNDLE/data/site/"
fi
if [[ -d "$XDG_DATA_HOME/nvim/mason" ]]; then
  mkdir -p "$BUNDLE/data/mason"
  rsync -a "$XDG_DATA_HOME/nvim/mason/" "$BUNDLE/data/mason/"
fi
cp "$ROOT/scripts/install-offline.sh" "$BUNDLE/install.sh"
chmod +x "$BUNDLE/install.sh"

{
  echo "name=$NAME"
  echo "built_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "os=$OS"
  echo "arch=$ARCH"
  nvim --version | head -n 1
  echo "mason=${MASON_PACKAGES[*]}"
} >"$BUNDLE/MANIFEST.txt"

mkdir -p "$OUT_DIR"
tar -C "$STAGING" -czf "$OUT_DIR/$NAME.tar.gz" "$NAME"
echo "Wrote $OUT_DIR/$NAME.tar.gz"
