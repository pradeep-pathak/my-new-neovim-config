-- ======================
-- bootstrap lazy.nvim
-- ======================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- ======================
-- plugins
-- ======================

require("lazy").setup({

    -- colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },

    --- better syntax highlighting & indentation
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                exclude = {
                    filetypes = {
                        "dashboard",
                        "NvimTree",
                    }
                }
            })
        end
    },

    -- lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },

    -- bufferline
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },

    -- telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }
    },

    -- git signs
    {
        "lewis6991/gitsigns.nvim"
    },

    -- file tree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },

    -- dashboard
    {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip"
        }
    },

    {
        "nvimdev/lspsaga.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        }
    },

})

-- ======================
-- basic settings
-- ======================

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.g.mapleader = " "

-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Enable persistent undo history
vim.opt.undofile = true

-- better searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- leader h to clear search highlight
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { silent = true })

-- jk to escape
vim.keymap.set("i", "jk", "<Esc>", { silent = true })

-- next / previous buffer
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true })

-- close buffer instantly
vim.keymap.set("n", "<leader>q", ":bd<CR>", { silent = true })

-- ctrl navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")


-- ======================
-- colorscheme
-- ======================

require("catppuccin").setup({
    flavour = "mocha"
})

vim.cmd.colorscheme("catppuccin")


-- ======================
-- lualine
-- ======================

require("lualine").setup({
    options = {
        theme = "auto",
        section_separators = "",
        component_separators = "|"
    }
})

-- ======================
-- bufferline
-- ======================

require("bufferline").setup({
    options = {
        mode = "buffers",
        diagnostics = "nvim_lsp",
        separator_style = "slant",

        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }
        }
    }
})

-- ======================
-- telescope
-- ======================

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- ======================
-- gitsigns
-- ======================

require("gitsigns").setup()

-- ======================
-- nvim-tree
-- ======================

require("nvim-tree").setup()

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })

-- ======================
-- dashboard
-- ======================

require("dashboard").setup({
    theme = 'hyper',
    config = {
        week_header = {
            enable = true,
        },
        shortcut = {
            { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
                icon = ' ',
                icon_hl = '@variable',
                desc = 'Files',
                group = 'Label',
                action = 'Telescope find_files',
                key = 'f',
            },
            {
                desc = ' Apps',
                group = 'DiagnosticHint',
                action = 'Telescope app',
                key = 'a',
            },
            {
                desc = ' dotfiles',
                group = 'Number',
                action = 'Telescope dotfiles',
                key = 'd',
            },
        },
    },
})

-- ======================
-- mason
-- ======================

require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "gopls" }
})


-- ======================
-- LSP
-- ======================

-- lua
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

-- go
vim.lsp.config("gopls", {})

-- enable servers
vim.lsp.enable("lua_ls")
vim.lsp.enable("gopls")

-- ======================
-- completion
-- ======================

local cmp = require("cmp")

cmp.setup({
    sources = {
        { name = "nvim_lsp" }
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
})

-- ======================
-- lspsaga
-- ======================

require("lspsaga").setup()


-- ======================
-- Keybinds for LSP
-- ======================

vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
