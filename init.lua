-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable the lazy.nvim plugin manager
require("config.lazy")

-- Helper function to source Vimscript configuration files
local function source_config(filename)
  local config_path = vim.fn.stdpath("config") .. "/config/" .. filename
  if vim.fn.filereadable(config_path) == 1 then
    vim.cmd("source " .. config_path)
  else
    vim.notify("Config file not found: " .. config_path, vim.log.levels.WARN)
  end
end

-- Source basic settings (indentation, UI options, etc.)
source_config("basic.vim")

-- Source key mappings
source_config("keymaps.vim")

-- Source appearance settings (colorscheme, etc.)
-- This must be done AFTER plugins are loaded so the colorschemes are available
source_config("appearance.vim")
