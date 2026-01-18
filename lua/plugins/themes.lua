return {
  { "morhetz/gruvbox" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "junegunn/seoul256.vim" },
  { "joshdick/onedark.vim" },
  { "ayu-theme/ayu-vim" },
  {
    "sainnhe/everforest",
    init = function()
      -- Configuration from appearance.vim
      vim.g.everforest_background = "soft"
      vim.g.everforest_better_performance = 1
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_diagnostic_text_highlight = 1
      vim.g.everforest_diagnostic_line_highlight = 1
      vim.g.everforest_inlay_hints_background = "dimmed"
    end,
  },
  { "embark-theme/vim", name = "embark", branch = "main" },
  { "cocopon/iceberg.vim" },
}
