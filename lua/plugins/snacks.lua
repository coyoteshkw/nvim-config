return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- 缩进线(带动态效果)
      indent = {
        enabled = true,
        priority = 1,
        char = "│",
        only_scope = false,
        only_current = false,
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
        },
      },
      -- 滚动动画
      scroll = {
        -- write here
      },
      -- You can enable other snacks modules here
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = {
        enabled = false,
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
          open = false,            -- show open folds icons
          git_hl = false,          -- use Git Signs hl for fold icons
        },
        git = {
          -- patterns to match Git signs
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50, -- refresh at most every 50ms
      },
      words = { enabled = true },
      -- Enhanced UI modules
      terminal = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      dashboard = {
        -- your dashboard configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = "󱦹 ", key = "b", desc = "Blog", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.expand('~/Documents/blog/coyotec-blog/src/content/posts')})" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        }
      }
    },
    keys = {
      { "<leader>tn",      function() Snacks.notifier.hide() end,                                      desc = "Dismiss All Notifications" },
      { "<leader>bd",      function() Snacks.bufdelete() end,                                          desc = "Delete Buffer" },
      { "<leader>gg",      function() Snacks.lazygit() end,                                            desc = "Lazygit" },
      { "<leader>gb",      function() Snacks.git.blame_line() end,                                     desc = "Git Blame Line" },
      { "<leader>gf",      function() Snacks.lazygit.log_file() end,                                   desc = "Lazygit Current File Log" },
      { "<leader>gl",      function() Snacks.lazygit.log() end,                                        desc = "Lazygit Log (cwd)" },
      { "<leader>fR",      function() Snacks.rename.rename_file() end,                                 desc = "Rename File" },
      -- Picker
      { "<leader><space>", function() Snacks.picker.smart() end,                                       desc = "Smart Find Files" },
      -- <leader>f: find files
      { "<leader>ff",      function() Snacks.picker.files() end,                                       desc = "Find Files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                                   desc = "Find Git Files" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                                      desc = "Recent Files" },
      { "<leader>fb",      function() Snacks.picker.buffers() end,                                     desc = "Buffers" },
      { "<leader>fk",      function() Snacks.picker.keymaps() end,                                     desc = "Keymaps" },
      -- <leader>f: find inside files
      { "<leader>f/",      function() Snacks.picker.grep() end,                                        desc = "Grep (Root Dir)" },
      { "<leader>fw",      function() Snacks.picker.grep_word() end,                                   desc = "Grep Word / Selection",       mode = { "n", "x" } },
      -- Toggles
      { "<leader>tL",      function() Snacks.toggle.line_number():toggle() end,                        desc = "Toggle Line Numbers" },
      { "<leader>tr",      function() Snacks.toggle.option("relativenumber"):toggle() end,             desc = "Toggle Relative Line Numbers" },
      { "<leader>td",      function() Snacks.toggle.diagnostics():toggle() end,                        desc = "Toggle Diagnostics" },
      { "<leader>ts",      function() Snacks.toggle.option("signcolumn", { off = "no" }):toggle() end, desc = "Toggle Sign Column" },
    },
  },
}
