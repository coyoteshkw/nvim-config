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
    -- 为snacks添加更多快捷键，leader f e 在root dir打开snacks的explorer(Snacks.picker.explorer),<leader>fc查找配置文件(~/.config/nvim)，<leader>fEExplorer Snacks (cwd),<leader>sh搜索nvim help，<leader>sp	Search for Plugin Spec搜索插件规范，leader g d 查看snacks git diff (hunk)，leader g D查看git diff(origin)，leader g b 调用snacks git blame line, leader g l和leader g L分别调用snacks 的git log和git log(cwd),leader g s -> snacks git status, leader g S -> snacks git Stash
    keys = {
      -- buffer
      { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
      { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
      { "<leader>fR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
      -- Picker
      { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
      -- <leader>f: find files
      { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent Files" },
      { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
      { "<leader>fk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
      -- <leader>f: explorer / config
      { "<leader>fe",      function() Snacks.picker.explorer() end,                                desc = "Explorer (Root Dir)" },
      { "<leader>fE",      function() Snacks.picker.explorer({ cwd = vim.fn.getcwd() }) end,       desc = "Explorer (cwd)" },
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config Files (~/.config/nvim)" },
      { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
      -- <leader>f: find inside files
      { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep (Root Dir)" },
      { "<leader>f/",      function() Snacks.picker.grep() end,                                    desc = "Grep (Root Dir)" },
      { "<leader>fw",      function() Snacks.picker.grep_word() end,                               desc = "Grep Word / Selection",        mode = { "n", "x" } },
      -- <leader>s: search
      { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
      { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
      { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
      { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
      { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
      { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
      { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
      { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
      { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
      { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
      -- <leader>g: git
      { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
      { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
      { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
      { "<leader>gD",      function() Snacks.picker.git_diff({ base = "origin" }) end,             desc = "Git Diff (origin)" },
      { "<leader>gb",      function() Snacks.git.blame_line() end,                                 desc = "Git Blame Line" },
      { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
      { "<leader>gL",      function() Snacks.picker.git_log({ cwd = vim.fn.getcwd() }) end,        desc = "Git Log (cwd)" },
      { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
      { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
      -- Toggles
      { "<leader>uL",      function() Snacks.toggle.line_number():toggle() end,                    desc = "Toggle Line Numbers" },
      { "<leader>ur",      function() Snacks.toggle.option("relativenumber"):toggle() end,         desc = "Toggle Relative Line Numbers" },
      { "<leader>ud",      function() Snacks.toggle.diagnostics():toggle() end,                    desc = "Toggle Diagnostics" },
      -- { "<leader>ts",      function() Snacks.toggle.option("signcolumn", { off = "no" }):toggle() end, desc = "Toggle Sign Column" },
    },
  },
}
