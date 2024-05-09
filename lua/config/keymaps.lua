-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set

-- use jk to exit insert mode
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Buffer move
map("", "<leader>n", ":bnext<cr>", { desc = "Buffer next" })
map("", "<leader>p", ":bprevious<cr>", { desc = "Buffer previous" })
map("", "<leader>d", ":bdelete<cr>", { desc = "Buffer delete" })
