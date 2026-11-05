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

-- 命令行补全
opt.wildmenu = true
opt.wildmode = "list:longest,full"

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
