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
        { "<leader>b", desc = "Find Buffer" },
        
        { "<leader>c", group = "Code" },
        { "<leader>ca", desc = "Action (Selected)" },
        { "<leader>cc", desc = "Action (Cursor)" },
        { "<leader>cf", desc = "Format" },
        { "<leader>cL", desc = "CodeLens" },
        { "<leader>cr", desc = "Rename" },
        { "<leader>cR", desc = "Refactor" },
        { "<leader>cS", desc = "Source Action" },
        { "<leader>cx", desc = "Fix Current" },

        { "<leader>f", group = "Find/File" },
        { "<leader>ff", desc = "Recent Files (MRU)" },
        
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
      })
    end,
  },
}