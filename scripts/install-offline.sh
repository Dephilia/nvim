#!/usr/bin/env bash
# Install an offline nvim bundle into XDG config/data dirs.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
CONFIG_SRC="$ROOT/config"
DATA_SRC="$ROOT/data"
CONFIG_DST="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
DATA_DST="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"

if [[ ! -d "$CONFIG_SRC" || ! -d "$DATA_SRC" ]]; then
  echo "Missing config/ or data/ next to install.sh" >&2
  exit 1
fi

mkdir -p "$CONFIG_DST" "$DATA_DST"
cp -R "$CONFIG_SRC/." "$CONFIG_DST/"
if [[ -d "$DATA_SRC/site" ]]; then
  mkdir -p "$DATA_DST/site"
  cp -R "$DATA_SRC/site/." "$DATA_DST/site/"
fi
if [[ -d "$DATA_SRC/mason" ]]; then
  mkdir -p "$DATA_DST/mason"
  cp -R "$DATA_SRC/mason/." "$DATA_DST/mason/"
fi

echo "Installed config -> $CONFIG_DST"
echo "Installed data   -> $DATA_DST"
if command -v nvim >/dev/null 2>&1; then
  nvim --version | head -n 1
else
  echo "nvim is not on PATH. Install Neovim 0.12+ before launching." >&2
fi
