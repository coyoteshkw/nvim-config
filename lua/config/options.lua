-- ======================================
--
--            Basic Settings
--
-- ======================================
-- 由 config/basic.vim 迁移而来

local opt = vim.opt

-- 界面
opt.mouse = "a"
opt.number = true
opt.numberwidth = 4
opt.relativenumber = true
opt.ruler = true
opt.laststatus = 2
opt.title = true
opt.scrolloff = 3
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false

-- 编辑行为
opt.hidden = true
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.autoindent = true
opt.backspace = "indent,eol,start"

-- 缩进：两空格
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true

-- 搜索
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- 命令行补全（配合 mini.cmdline 的 autocomplete）
-- wildmenu : 显示候选
-- wildmode : "noselect,full"
--            noselect = 只弹出 pum，不预选、不自动改写输入
--            full     = 按 <Tab> 时才把匹配项补进命令行
--            注：不要只写 "list"会退回旧的 wildmenu 多列网格，
--            候选多时会铺满整屏并出现 -- More --，而不是 pum 弹窗
-- wildoptions: pum = 垂直 popup 菜单；fuzzy = 模糊匹配
opt.wildmenu = true
opt.wildmode = "noselect,full"
opt.wildoptions = "pum,fuzzy"
opt.pumheight = 10


-- 响应速度 / 无提示音
opt.belloff = "all"
opt.updatetime = 300
opt.timeout = true
opt.ttimeout = true
opt.ttimeoutlen = 1
opt.ttyfast = true

-- 复制粘贴使用系统剪贴板（macOS）
opt.clipboard = "unnamed"

-- 插入/普通模式光标形状
-- 说明：t_SI / t_EI 属于终端选项，无 TUI 的环境（headless）下不存在，
-- 用 pcall 包住以免整个配置加载中断。
pcall(function()
  vim.o.t_SI = "\27[6 q"
  vim.o.t_EI = "\27[2 q"
end)

-- 折叠：默认按缩进（无 treesitter 解析器时的兜底）；
-- 有解析器的文件类型由 lua/plugins/nvim-treesitter.lua 的 FileType 自动命令
-- 改成 foldmethod=expr + v:lua.vim.treesitter.foldexpr()。
opt.foldmethod = "indent"
opt.foldlevel = 99

-- 在 80 列（或该文件类型的 textwidth）处显示一条竖线
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ColorColumn", { clear = true }),
  callback = function()
    local tw = vim.bo.textwidth
    vim.opt_local.colorcolumn = tostring(tw > 0 and tw or 80)
  end,
})

-- 打开文件时跳转到上次关闭时的光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 0 and line <= vim.fn.line("$") and vim.bo.filetype ~= "commit" then
      vim.cmd([[normal! g`"]])
    end
  end,
})

-- markdown config
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    -- vim.opt_local.linebreak = true
    -- vim.opt_local.showbreak = " "  -- 清空软换行后的行首标记
    -- vim.opt_local.list = false     -- 关键：在 Markdown 中强制关闭 list
    -- vim.opt_local.listchars:remove({ "extends", "precedes" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- 只在软换行时，将 j/k 映射为视觉行移动
    vim.keymap.set("n", "j", "gj", { buffer = true, desc = "Move down visual line" })
    vim.keymap.set("n", "k", "gk", { buffer = true, desc = "Move up visual line" })
  end,
})

-- ======================================
--  Markdown 专属 scrolloff
-- ======================================
-- 目标：写 markdown 时光标不会贴到屏幕底部，
--       下移时光标下方始终保留至少 12 行可见内容。
-- 说明：
--   * Neovim 0.11+ 的 scrolloff 是窗口级选项，且窗口级取值按
--     「窗口 + 缓冲区」成对存储：切到其他文件类型会自动回退到
--     全局值（上方 opt.scrolloff = 3），切回 markdown 又会恢复 12。
--     因此这里只需单向设置，不必手工保存/还原。
--   * markdown 开启了 wrap，scrolloff 以「屏幕行」计，
--     这 12 行是肉眼可见的显示行，而不是缓冲区行。
--   * 窗口高度不足（h < 25）时上下留白无法同时满足，
--     Vim 会把光标维持在屏幕中部，滚动行为依然正常。
local MD_SCROLLOFF = 12

vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter", "WinEnter" }, {
  group = vim.api.nvim_create_augroup("MarkdownScrolloff", { clear = true }),
  callback = function()
    if vim.bo.filetype == "markdown" and vim.wo.scrolloff < MD_SCROLLOFF then
      vim.wo.scrolloff = MD_SCROLLOFF
    end
  end,
})
