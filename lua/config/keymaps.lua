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

-- === 浮窗滚动：<C-f> / <C-b> ===
-- 浮窗（补全文档、诊断详情等）打开时滚动浮窗；没有浮窗时普通/可视模式
-- 照常翻页，插入模式不做任何事。
--
-- 必须用 Lua 函数做 expr 映射。写成 vimscript 表达式字符串时，返回的
-- "<Right>" 会被 replace_keycodes 换成内部键码 \x80kr，那串字节会被当作
-- 文本插入缓冲区（表现为输入 <80>kr），而不是执行按键。
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

map({ "n", "v" }, "<C-f>", function() return float_or(1, "<C-f>") end, float_opts)
map({ "n", "v" }, "<C-b>", function() return float_or(0, "<C-b>") end, float_opts)
-- 插入模式没有 fallback：没浮窗时按下去什么都不发生
map("i", "<C-f>", function() return float_or(1, "") end, float_opts)
map("i", "<C-b>", function() return float_or(0, "") end, float_opts)
