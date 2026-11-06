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
  { "tpope/vim-surround",   lazy = false },
  { "tpope/vim-unimpaired", lazy = false },
  {
    "tpope/vim-commentary",
    keys = {
      { "<C-/>", ":Commentary<CR>", desc = "Toggle Comment" },
    },
  },
  -- { "michaeljsmith/vim-indent-object" },
  { "terryma/vim-expand-region", lazy = false },
  { "godlygeek/tabular",         cmd = { "Tabularize" } },
  -- 折叠插件
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {}, -- required even when using default config

    -- recommended: disable vim's auto-folding
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },
  {
    "y3owk1n/dotmd.nvim",
    cmd = {
      "DotMdCreateNote",
      "DotMdCreateTodoToday",
      "DotMdCreateJournal",
      "DotMdInbox",
      "DotMdNavigate",
      "DotMdPick",
      "DotMdOpen",
    },
    event = "VeryLazy",
    ---@type DotMd.Config
    opts = {
      root_dir = "~/Documents/dotmd", -- set it to your desired directory or remain at it is
      default_split = "float",        -- or "vertical" or "horizontal" or "none" based on your preference
      rollover_todo = {
        enabled = true,               -- enable rollover
      },
      picker = "snacks"               -- or "fzf" or "telescope" or "mini" based on your preference
    },
    keys = {
      {
        "<leader>nc",
        function()
          require("dotmd").create_note()
        end,
        desc = "[DotMd] Create new note",
      },
      {
        "<leader>nt",
        function()
          require("dotmd").create_todo_today()
        end,
        desc = "[DotMd] Create todo for today",
      },
      {
        "<leader>ni",
        function()
          require("dotmd").inbox()
        end,
        desc = "[DotMd] Inbox",
      },
      {
        "<leader>nj",
        function()
          require("dotmd").create_journal()
        end,
        desc = "[DotMd] Create journal",
      },
      {
        "<leader>np",
        function()
          require("dotmd").navigate("previous")
        end,
        desc = "[DotMd] Navigate to previous todo",
      },
      {
        "<leader>nn",
        function()
          require("dotmd").navigate("next")
        end,
        desc = "[DotMd] Navigate to next todo",
      },
      {
        "<leader>no",
        function()
          require("dotmd").open({
            pluralise_query = true, -- recommended
          })
        end,
        desc = "[DotMd] Open",
      },
      {
        "<leader>sna",
        function()
          require("dotmd").pick()
        end,
        desc = "[DotMd] Everything",
      },
      {
        "<leader>snA",
        function()
          require("dotmd").pick({
            grep = true,
          })
        end,
        desc = "[DotMd] Search everything grep",
      },
      {
        "<leader>snn",
        function()
          require("dotmd").pick({
            type = "notes",
          })
        end,
        desc = "[DotMd] Search notes",
      },
      {
        "<leader>snN",
        function()
          require("dotmd").pick({
            type = "notes",
            grep = true,
          })
        end,
        desc = "[DotMd] Search notes grep",
      },
      {
        "<leader>snt",
        function()
          require("dotmd").pick({
            type = "todos",
          })
        end,
        desc = "[DotMd] Search todos",
      },
      {
        "<leader>snT",
        function()
          require("dotmd").pick({
            type = "todos",
            grep = true,
          })
        end,
        desc = "[DotMd] Search todos grep",
      },
      {
        "<leader>snj",
        function()
          require("dotmd").pick({
            type = "journals",
          })
        end,
        desc = "[DotMd] Search journal",
      },
      {
        "<leader>snJ",
        function()
          require("dotmd").pick({
            type = "journals",
            grep = true,
          })
        end,
        desc = "[DotMd] Search journal grep",
      },
    },
  },
}
