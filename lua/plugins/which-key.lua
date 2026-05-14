return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.add({
        { "<leader>b", group = "Buffer" },
        { "<leader>bd", desc = "Delete Buffer" },

        { "<leader>a", group = "Opencode AI" },
        { "<leader>aa", desc = "Ask" },
        { "<leader>ac", desc = "Ask (@this)" },
        { "<leader>ao", desc = "Operator" },
        { "<leader>as", desc = "Actions/Select" },
        { "<leader>at", desc = "Toggle" },
        
        { "<leader>c", group = "Code" },
        { "<leader>ca", desc = "Action (Selected)" },
        { "<leader>cc", desc = "Action (Cursor)" },
        { "<leader>cf", desc = "Format" },
        { "<leader>cL", desc = "CodeLens" },
        { "<leader>cr", desc = "Rename" },
        { "<leader>cR", desc = "Refactor / Rename File" },
        { "<leader>cS", desc = "Source Action" },
        { "<leader>cx", desc = "Fix Current" },

        { "<leader>f", group = "Find/File" },
        { "<leader>ff", desc = "Search Recent Files" },

        { "<leader>g", group = "Git" },
        { "<leader>gb", desc = "Blame Line" },
        { "<leader>gf", desc = "Lazygit File Log" },
        { "<leader>gg", desc = "Lazygit" },
        { "<leader>gl", desc = "Lazygit Log" },

        { "<leader>h", group = "Hunk (Git)" },
        { "<leader>hD", desc = "Diff This ~" },
        { "<leader>hb", desc = "Blame Line" },
        { "<leader>hd", desc = "Diff This" },
        { "<leader>hp", desc = "Preview Hunk" },
        { "<leader>hi", desc = "Preview Hunk Inline" },
        { "<leader>hR", desc = "Reset Buffer" },
        { "<leader>hS", desc = "Stage Buffer" },
        { "<leader>hr", desc = "Reset Hunk" },
        { "<leader>hs", desc = "Stage Hunk" },
        
        { "<leader>s", group = "Search (CoC)" },
        { "<leader>sc", desc = "Commands" },
        { "<leader>sd", desc = "Diagnostics" },
        { "<leader>se", desc = "Extensions" },
        { "<leader>sj", desc = "Next Item" },
        { "<leader>sk", desc = "Prev Item" },
        { "<leader>so", desc = "Outline" },
        { "<leader>sp", desc = "Resume List" },
        { "<leader>ss", desc = "Symbols" },

        { "<leader>w", desc = "Save File" },
        { "<leader>q", desc = "Quit" },
        { "<leader>n", desc = "No Highlight" },

        { "<leader>t", group = "Toggle/Options" },
        { "<leader>tf", "<cmd>ToggleAutoFormat<cr>", desc = "Autoformat on Save" },
        { "<leader>tL", desc = "Line Numbers" },
        { "<leader>td", desc = "Diagnostics" },
        { "<leader>tr", desc = "Relative Line Numbers" },
        { "<leader>ts", desc = "Sign Column" },
      })
    end,
  },
}
