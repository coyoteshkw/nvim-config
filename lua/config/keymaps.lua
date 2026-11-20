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

-- 快速切换前后 buffer
map("n", "H", "<cmd>bprevious<cr>", { silent = true, desc = "Previous buffer" })
map("n", "L", "<cmd>bnext<cr>", { silent = true, desc = "Next buffer" })

-- 保存退出
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })

-- 分号代替冒号，避免重复按 Shift
map({ "n", "x", "o" }, ";", ":", { desc = "Command-line" })

-- 关闭搜索高亮
-- map("n", "<leader>n", "<cmd>nohlsearch<cr>", { silent = true, desc = "No Highlight" })
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

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

-- === <C-f> / <C-b> ===
-- 普通/可视模式：浮窗（补全文档、诊断详情等）打开时滚动浮窗，否则照常翻页。
-- 插入模式：不参与浮窗滚动，就是单纯的前后移动一个字符（Emacs 习惯）。
--
-- 普通/可视模式必须用 Lua 函数做 expr 映射。写成 vimscript 表达式字符串时，
-- 返回的 "<C-f>" 会被 replace_keycodes 换成内部键码，那串字节可能被当作文本
-- 插入缓冲区（同类问题见提交 b0edf24，表现为输入 <80>kr）。
local function scroll_float(direction)
  if vim.fn.exists("*coc#float#has_scroll") == 1 and vim.fn["coc#float#has_scroll"]() == 1 then
    vim.fn["coc#float#scroll"](direction)
    return true
  end
  return false
end

local function float_or(direction, fallback)
  if scroll_float(direction) then
    return ""
  end
  return fallback
end

local float_opts = { silent = true, nowait = true, expr = true, replace_keycodes = true }

map({ "n", "v" }, "<C-f>", function()
  return float_or(1, "<C-f>")
end, float_opts)
map({ "n", "v" }, "<C-b>", function()
  return float_or(0, "<C-b>")
end, float_opts)

-- 插入模式：普通映射，不走 expr，避免键码替换那一层
map("i", "<C-f>", "<Right>", { silent = true, desc = "Forward one character" })
map("i", "<C-b>", "<Left>", { silent = true, desc = "Backward one character" })

-- neovide
if vim.g.neovide then
  -- 允许 Neovide 接收 Command 键的输入
  vim.g.neovide_input_use_logo = 1
  vim.keymap.set({ "n", "i", "v", "c", "t" }, "<D-v>", function()
    -- 调用 Neovim 内置的粘贴函数，能更好地处理多行文本和缩进
    vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
  end, { silent = true, desc = "Paste from system clipboard" })
end

-- tmux support for comments: 终端里 <C-/> 实际发送的字节就是 <C-_> (0x1F)
-- 注意：不能直接映射到 "gcc/stdgc"，因为 gc 是 operator-pending 的，
-- 从映射 RHS 直接接上会吃掉后续输入；用 :normal 强制刷新一次即可。
map("n", "<C-_>", ":<C-U>normal gcc<CR>", { silent = true, desc = "Toggle comment line" })
map("x", "<C-_>", ":<C-U>normal gc<CR>",  { silent = true, desc = "Toggle comment selection" })

