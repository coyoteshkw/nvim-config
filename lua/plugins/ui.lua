return {
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    init = function()
      -- Single source of truth for the airline theme is lua/plugins/themes.lua
      -- (g:airline_theme is set there, matching the active colorscheme).
      -- Airline look & feel only:
      vim.g.airline_left_sep = ''
      vim.g.airline_left_alt_sep = ''
      vim.g.airline_right_sep = ''
      vim.g.airline_right_alt_sep = ''
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_section_x = '%{strftime("%H:%M")}'
      -- Skip display if encoding matches default
      vim.g['airline#parts#ffenc#skip_expected_string'] = 'utf-8[unix]'
      vim.g.airline_section_z = '%p%% %l/%L'
    end,
  },
  { "mhinz/vim-startify" },
  {
    "machakann/vim-highlightedyank",
    init = function()
      vim.g.highlightedyank_highlight_duration = 500
    end,
  },
}
