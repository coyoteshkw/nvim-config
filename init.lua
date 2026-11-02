-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable Netrw (we are using mini.files)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 基础选项（缩进、UI、折叠、光标形状等）
require("config.options")

-- 键位映射
require("config.keymaps")

-- Enable the lazy.nvim plugin manager
require("config.lazy")

-- 配色方案与主题相关高亮
-- 必须放在插件加载之后，否则配色方案还不可用
require("config.colorscheme")
