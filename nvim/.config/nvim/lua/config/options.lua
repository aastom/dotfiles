-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ─── Editor ─────────────────────────────────────────────────────────────────
vim.opt.relativenumber = true       -- relative line numbers
vim.opt.number = true               -- show current line number
vim.opt.scrolloff = 8               -- keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8           -- keep 8 columns left/right of cursor
vim.opt.wrap = false                -- no line wrapping
vim.opt.linebreak = true            -- break at word boundaries when wrap=true
vim.opt.colorcolumn = "120"         -- ruler at 120 chars
vim.opt.signcolumn = "yes"          -- always show sign column

-- ─── Indentation ────────────────────────────────────────────────────────────
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- ─── Search ─────────────────────────────────────────────────────────────────
vim.opt.ignorecase = true
vim.opt.smartcase = true            -- case-sensitive when uppercase used
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ─── UI ─────────────────────────────────────────────────────────────────────
vim.opt.termguicolors = true
vim.opt.cursorline = true           -- highlight current line
vim.opt.splitbelow = true           -- new horizontal splits go below
vim.opt.splitright = true           -- new vertical splits go right
vim.opt.showmode = false            -- mode shown by lualine
vim.opt.pumheight = 10              -- max items in popup menu
vim.opt.conceallevel = 2            -- hide markup in markdown/org

-- ─── Files ──────────────────────────────────────────────────────────────────
vim.opt.undofile = true             -- persistent undo
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.updatetime = 250            -- faster CursorHold events
vim.opt.timeoutlen = 300            -- faster which-key popup

-- ─── Clipboard ──────────────────────────────────────────────────────────────
vim.opt.clipboard = "unnamedplus"   -- use system clipboard by default

-- ─── Completion ─────────────────────────────────────────────────────────────
vim.opt.completeopt = { "menu", "menuone", "noselect" }
