return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
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
      -- You can enable other snacks modules here
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = {
        enabled = true,
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
          open = false, -- show open folds icons
          git_hl = false, -- use Git Signs hl for fold icons
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
    },
    keys = {
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File Log" },
      { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      -- Toggles
      { "<leader>tL", function() Snacks.toggle.line_number():toggle() end, desc = "Toggle Line Numbers" },
      { "<leader>tr", function() Snacks.toggle.option("relativenumber"):toggle() end, desc = "Toggle Relative Line Numbers" },
      { "<leader>td", function() Snacks.toggle.diagnostics():toggle() end, desc = "Toggle Diagnostics" },
      { "<leader>ts", function() Snacks.toggle.option("signcolumn", { off = "no" }):toggle() end, desc = "Toggle Sign Column" },
    },
  },
}
