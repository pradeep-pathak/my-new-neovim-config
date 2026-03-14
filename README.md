# My New Minimal Neovim Configuration

This is my personal Neovim setup, optimized for **Lua** and **Go** development (I've been doing a lot of it cuz i'm learning it rn), with a modern UI, fuzzy finding, Git integration, and LSP support. It uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

---

## Features

* **Colorscheme:** `Catppuccin` (mocha)
* **Statusline:** `lualine.nvim` with icons
* **Bufferline:** `bufferline.nvim` with diagnostics support
* **File Explorer:** `nvim-tree.lua`
* **Fuzzy Finder:** `telescope.nvim` for files, buffers, live grep, and more
* **Git Integration:** `gitsigns.nvim` for inline Git indicators
* **Dashboard:** `dashboard-nvim` for startup shortcuts
* **LSP & Completion:**

  * `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig.nvim`
  * LSP servers: `lua_ls`, `gopls`
  * Completion via `nvim-cmp` + `cmp-nvim-lsp` + `LuaSnip`

---

## Requirements

* Neovim ≥ 0.9
* Git
* Node.js (optional for some LSP servers)
* Language servers installed via Mason (`lua_ls`, `gopls`)

---

## Installation

1. **Clone the config repository**

```bash
git clone https://github.com/pradeep-pathak/my-new-neovim-config.git ~/.config/nvim
```

2. **Open Neovim**:

```bash
nvim
```

* Lazy.nvim will automatically bootstrap and install all plugins.

3. **Install LSP servers** via Mason:

```vim
:Mason
```

Or ensure automatic installation:

```lua
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "gopls" }
})
```

---

## Keybindings

### General

| Key                 | Action                  |
| ------------------- | ----------------------- |
| `<leader>h`         | Clear search highlights |
| `jk`                | Exit insert mode        |
| `<Tab>` / `<S-Tab>` | Cycle buffers           |
| `<leader>q`         | Close buffer            |
| `<C-h/j/k/l>`       | Navigate windows        |

### Telescope

| Key          | Action     |
| ------------ | ---------- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep  |
| `<leader>fb` | Buffers    |
| `<leader>fh` | Help tags  |

### NvimTree

| Key         | Action               |
| ----------- | -------------------- |
| `<leader>e` | Toggle file explorer |

### LSP

| Key          | Action              |
| ------------ | ------------------- |
| `gd`         | Go to definition    |
| `K`          | Hover documentation |
| `<leader>rn` | Rename symbol       |
| `<leader>ca` | Code actions        |

---

## Customization

* **Colorscheme:** Change the `flavour` in `require("catppuccin").setup({ flavour = "mocha" })`
* **Statusline & Bufferline:** Adjust separators or themes in `lualine` and `bufferline` setup.
* **Dashboard:** Update shortcuts and icons in `dashboard-nvim` setup.

---

## Tips

* Persistent undo is enabled (`undofile = true`)
* Smart searching with `ignorecase` + `smartcase`
* Lazy.nvim ensures plugins are loaded on demand for faster startup
* Use `:Lazy update` to update plugins

---

This config gives a smooth, modern Neovim experience while keeping things lightweight and easy to replicate on new machines.
