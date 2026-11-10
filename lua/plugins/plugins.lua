return {
  -- { "easymotion/vim-easymotion" },
  {
    "rhysd/clever-f.vim",
    init = function()
      vim.g.clever_f_chars_match_any_signs = ";"
      vim.g.clever_f_smart_case = 1
    end,
  },
  -- 快速增删改包围符号（括号、引号、标签等）
  { "tpope/vim-surround",        lazy = false },
  { "tpope/vim-unimpaired",      lazy = false },
  -- 注释插件，可以用mini.comment代替，但我发现其实这个也挺好用的，而且gc{真的很不错啊
  -- {
  --   "tpope/vim-commentary",
  --   keys = {
  --     { "<C-/>", ":Commentary<CR>", desc = "Toggle Comment" },
  --   },
  -- },
  -- { "michaeljsmith/vim-indent-object" },
  { "terryma/vim-expand-region", lazy = false },
  -- 对齐变量
  -- 运行方法：在选择模式下执行:Tab /=对齐等号 :Tab /: 对齐冒号
  -- 参考：http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
  { "godlygeek/tabular",         cmd = { "Tabularize" } },
  -- 更美观的折叠态展示插件
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {
      foldtext = {
        padding = { width = 3 },
        lineCount = { template = "󰘖 %d", hlgroup = "Comment" },
        diagnosticsCount = true,
        gitsignsCount = true,
      },
      foldKeymaps = {
        setup = true,                   -- modifies `h`, `l`, `^`, and `$`
        closeOnlyOnFirstColumn = false, -- `h` and `^` only fold in the 1st column
        scrollLeftOnCaret = false,      -- `^` should scroll left (basically mapped to `0^`)
      },
    },                                  -- required even when using default config

    -- recommended: disable vim's auto-folding
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },
  -- vim-repeat插件，被多人力荐
  { "tpope/vim-repeat" },
  -- 自动保存退出前的会话，简单插件
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      -- add any custom options here
    }
  },
  -- 在靠近缩进线时改变缩进线的颜色，在不靠近时则不展示，在普通模式下绝对不展示
  { 'Bekaboo/deadcolumn.nvim', opts = {} }
}
