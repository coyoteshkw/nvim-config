return {
  {
    -- <C-p> (g:ctrlp_map) is not a lazy.nvim trigger, so load eagerly
    "ctrlpvim/ctrlp.vim",
    enabled = false,
    lazy = false,
    init = function()
      vim.g.ctrlp_show_hidden = 0
      vim.g.ctrlp_map = '<C-p>'
    end,
  },
  { "junegunn/fzf",                   lazy = false },
  {
    "junegunn/fzf.vim",
    enabled = false,
    dependencies = { "junegunn/fzf" },
    -- <leader>ff is owned by snacks.nvim picker; keep fzf on its own commands
  },
  {
    "mileszs/ack.vim",
    enabled = false,
    cmd = { "Ack", "AckAdd", "AckFromSearch", "LAck" }
  },
  { "christoomey/vim-tmux-navigator", lazy = false },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      -- 大S使用 ; 和 , 来增加/减少选择范围
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "tpope/vim-sleuth"
  }
}
