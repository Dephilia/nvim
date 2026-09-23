# nvim

Neovim 0.12+ Lua config. No Vim compatibility. No tree-sitter plugin — highlighting is Vim syntax plus LSP semantic tokens.

Clone to `~/.config/nvim`. First launch installs plugins via `vim.pack`. First **interactive** launch also mason-installs language servers.

Leader is `,`. List every map with `:Telescope keymaps`.

## Features

- **UI**: kanagawa, lualine + buffer tabline, `` in the statusline when LSP is attached, nvim-notify, indent guides, rounded floats
- **Files**: nvim-tree, Telescope (files / grep / buffers / help)
- **Git**: gitsigns in the gutter, fugitive commands
- **LSP**: mason-managed servers + brew `ruff` / `ty` for Python; format, rename, code action, diagnostics
- **Completion**: blink.cmp (LSP, path, snippets, buffer). Enter accepts. `C-j` / `C-k` select
- **Navigation**: hop to word end, outline, Trouble
- **Edit utils**: listchars toggle, clean mode, auto-brackets, strip trailing space
- **Comments**: native `gc` / `gcc` (no comment plugin)

## Keymaps

Leader is shown as `,`.

### Insert

| Key | Action |
|-----|--------|
| `jj` | Escape |

blink.cmp uses `C-j` / `C-k` while the completion menu is open. Arrow keys work as usual.

### Buffers and tabs

| Key | Action |
|-----|--------|
| `C-h` / `C-l` | Previous / next buffer |
| `,C-h` / `,C-l` | Previous / next tab |
| `bo` / `bd` | New empty buffer / delete buffer |
| `,fb` | Find buffers (Telescope) |

### Telescope, tree, outline, hop

| Key | Action |
|-----|--------|
| `,,,` | Telescope picker |
| `,ff` | Find files |
| `,fg` | Live grep (needs ripgrep) |
| `,fb` | Buffers |
| `,fh` | Help tags |
| `,n` | File tree |
| `,t` | Symbol outline |
| `,e` | Hop to word end |

### Diagnostics and Trouble

| Key | Action |
|-----|--------|
| `Space e` | Diagnostic float |
| `[d` / `]d` | Previous / next diagnostic |
| `,xx` | Trouble diagnostics |
| `,xd` | Trouble diagnostics (this buffer) |
| `,xq` | Trouble quickfix |
| `,xl` | Trouble loclist |
| `gr` | Trouble LSP references |
| `F2` | Toggle built-in quickfix (notifies; empty list still opens) |

### LSP (after a server attaches)

| Key | Action |
|-----|--------|
| `gd` / `gD` / `gi` / `Space D` | Definition / declaration / implementation / type |
| `K` | Hover (`ruff` hover is off; `ty` provides it) |
| `C-k` | Signature help |
| `Space f` | Format (normal + visual) |
| `,ca` | Code action |
| `,rn` | Rename |

### Clipboard and view

| Key | Action |
|-----|--------|
| `,y` / `,p` | Selection clipboard (`*`) |
| `,Y` / `,P` | System clipboard (`+`) |
| `,h` | Toggle listchars (spaces/tabs/eol) |
| `,H` | Clean mode: hide numbers, listchars, indent guides, git signs |
| `,B` | Toggle auto-pairs for `{` `(` `'` `"` |
| `,C-r` | Source `$MYVIMRC` |

## Commands

| Command | Action |
|---------|--------|
| `:CleanModeToggle` | Same as `,H` |
| `:ClearSpaces` | Strip trailing whitespace (no keymap) |
| `:Mason` | LSP package UI |
| `:packupdate` | Update `vim.pack` plugins |

## Language servers

| Server | Source | Languages |
|--------|--------|-----------|
| `ruff` | brew (also mason) | Python lint/format |
| `ty` | brew | Python types / hover |
| `lua_ls` | mason | Lua |
| `clangd` | mason | C / C++ |
| `rust_analyzer` | mason | Rust |
| `bashls` | mason | Bash |
| `html` | mason | HTML |
| `jsonls` | mason | JSON / JSONC |
| `ts_ls` | mason | TypeScript / JavaScript |

## Plugins

Managed by `vim.pack` (`:packupdate`). Lockfile: `nvim-pack-lock.json`.

| Plugin | Role |
|--------|------|
| kanagawa.nvim | Colorscheme |
| lualine.nvim + tabline.nvim | Statusline and buffer line |
| nvim-tree.lua | File tree |
| telescope.nvim | Fuzzy finder |
| hop.nvim | Jump to word |
| outline.nvim | Symbols |
| trouble.nvim | Diagnostics list |
| gitsigns.nvim + vim-fugitive | Git |
| indent-blankline.nvim | Indent guides |
| nvim-notify | Notifications |
| mason.nvim + mason-lspconfig.nvim + nvim-lspconfig | LSP install / config |
| blink.cmp + blink.lib + friendly-snippets | Completion |
| nvim-navic | Breadcrumbs in lualine |
| nvim-web-devicons + plenary.nvim | Icons / Lua utils |

## Offline bundle

GitHub Actions builds tarballs of this config plus `vim.pack` plugins and mason language servers (`linux-x86_64`, `darwin-arm64`).

- **Run workflow** on **offline-bundle** (or push tag `latest`): replaces the single GitHub Release [`latest`](https://github.com/Dephilia/nvim/releases/tag/latest). The release *title* is the UTC date (`YYYY-MM-DD`); both OS tarballs are attached.
- Push to `main`: artifacts only (no release).
- Push a `v*` tag: a separate versioned release.
- Local: `./scripts/bundle.sh` writes `dist/nvim-offline-$(uname -s)-$(uname -m).tar.gz`.

On the offline machine (Neovim 0.12+ already installed):

```sh
tar -xzf nvim-offline-darwin-arm64.tar.gz
cd nvim-offline-darwin-arm64
./install.sh
```

That copies `config/` to `~/.config/nvim` and `data/site` + `data/mason` to `~/.local/share/nvim`. Mason binaries are **not** portable across OS/arch — use the matching artifact. `ty` is brew-only and is not in the bundle.

## Defaults we do **not** set

These already match Neovim 0.12, so setting them does nothing: `cmdheight`, `hidden`, `list`, `incsearch`, `hlsearch`, `autoindent`, `foldenable`.

## LICENSE

MIT License
