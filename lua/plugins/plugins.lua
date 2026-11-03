return {
  {
    "preservim/vim-markdown",
    ft = "markdown",
    init = function()
      vim.g.vim_markdown_borderless_table = 1
    end,
  },
  "xheisenbugx/org.nvim",
  main = "org",
  lazy = false, -- startup cost is small: heavy modules load on first use
  opts = {
    org_directory = "~/Documents/org",
    agenda_files = { "~/Documents/org/**/*.org" },
    default_notes_file = "~/Documents/org/refile.org",
  },
  -- { "easymotion/vim-easymotion" },
  {
    "rhysd/clever-f.vim",
    init = function()
      vim.g.clever_f_chars_match_any_signs = ";"
      vim.g.clever_f_smart_case = 1
    end,
  },
  { "tpope/vim-surround", lazy = false },
  { "tpope/vim-unimpaired", lazy = false },
  {
    "tpope/vim-commentary",
    keys = {
      { "<C-/>", ":Commentary<CR>", desc = "Toggle Comment" },
    },
  },
  -- { "michaeljsmith/vim-indent-object" },
  { "terryma/vim-expand-region", lazy = false },
  { "godlygeek/tabular", cmd = { "Tabularize" } },
}
