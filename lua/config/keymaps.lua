-- ======================================
--
--            Keyboard Mapping
--
-- ======================================
-- 由 config/keymaps.vim 迁移而来

local map = vim.keymap.set

-- 快速退出插入模式
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })

-- 快速移动（保持与原 noremap 一致：普通 / 可视 / 操作符模式）
map({ "n", "x", "o" }, "J", "5j", { desc = "Move down 5 lines" })
map({ "n", "x", "o" }, "K", "5k", { desc = "Move up 5 lines" })
map("n", "<BS>", "ciw", { desc = "Change inner word" })

-- 保存退出
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- 分号代替冒号，避免重复按 Shift
map({ "n", "x", "o" }, ";", ":", { desc = "Command-line" })

-- 关闭搜索高亮
map("n", "<leader>n", "<cmd>nohlsearch<cr>", { silent = true, desc = "No Highlight" })

-- 折叠开关：0 <-> 99
map("n", "god", function()
  vim.opt.foldlevel = vim.opt.foldlevel:get() == 0 and 99 or 0
end, { desc = "Toggle all folds" })

-- === 终端窗口导航 ===
-- 注意：vim-tmux-navigator 也接管了 <C-h/j/k/l>，这里的映射可能被其覆盖
map("t", "<C-j>", "<C-w><C-j>", { desc = "Terminal: move down" })
map("t", "<C-k>", "<C-w><C-k>", { desc = "Terminal: move up" })
map("t", "<C-l>", "<C-w><C-l>", { desc = "Terminal: move right" })
map("t", "<C-h>", "<C-w><C-h>", { desc = "Terminal: move left" })

-- 插入模式换行（在 tmux 下无效，与原配置一致）
map("i", "<C-Enter>", "<Esc>o", { desc = "Insert newline below" })

-- === 命令行模式 ===
map("c", "<C-A>", "<Home>", { desc = "Cmdline: beginning" })
map("c", "<C-E>", "<End>", { desc = "Cmdline: end" })
map("c", "<C-K>", "<C-U>", { desc = "Cmdline: kill to start" })

-- 强制退出缩写：:qqq -> :q!
vim.cmd([[cnoreabbrev qqq q!]])
