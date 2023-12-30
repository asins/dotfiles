-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local mode_all = { "n", "v", "i" }
local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }
local mode_ni = { "n", "i" }

local set = vim.keymap.set

vim.keymap.del("n", "<leader>l", {})

set("n", "y", '"+y', { noremap = true, silent = true, desc = "复制内容" })
set(mode_v, "y", '"+ygv<ESC>', { noremap = true, silent = true, desc = "复制内容" })
set(mode_i, "<C-z>", "<ESC>ua", { noremap = true, silent = true, desc = "撤销" })
