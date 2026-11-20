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
      -- classic or helix or modern
      preset = "helix",
      -- icons = { rules = false },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      wk.add({
        -- <leader><space>: smart find (snacks.picker.smart)
        { "<leader><space>", desc = "Smart Find Files" },

        { "<leader>a",       group = "Ask AI", icon = "󱚠" },
        { "<leader>aa",      desc = "Ask (pablopunk/pi.nvim)" },
        -- { "<leader>ac",      desc = "Ask (@this)" },
        -- { "<leader>ao",      desc = "Operator" },
        -- { "<leader>as",      desc = "Actions/Select" },
        -- { "<leader>at",      desc = "Toggle" },

        { "<leader>b",       group = "Buffer" },
        { "<leader>bd",      desc = "Delete Buffer" },

        -- <leader>c: code actions (all coc.nvim except cR)
        { "<leader>c",       group = "Code (CoC)" },
        { "<leader>ca",      desc = "Code Action (Visual/Select)" },
        { "<leader>cc",      desc = "Code Action (Cursor)" },
        { "<leader>cf",      desc = "Format" },
        { "<leader>cl",      desc = "CodeLens Action" },
        { "<leader>cr",      desc = "Rename Symbol" },
        { "<leader>cR",      desc = "Refactor (CoC)" },
        { "<leader>cS",      desc = "Source Action (Whole Buffer)" },
        { "<leader>cx",      desc = "Fix Current Diagnostic" },

        -- <leader>f: find files / find inside files
        { "<leader>f",       group = "Find" },
        { "<leader>ff",      desc = "Find Files" },
        { "<leader>fg",      desc = "Find Git Files" },
        { "<leader>fr",      desc = "Recent Files" },
        { "<leader>fb",      desc = "Buffers" },
        { "<leader>fk",      desc = "Keymaps" },
        { "<leader>fe",      desc = "Explorer (Root Dir)" },
        { "<leader>fE",      desc = "Explorer (cwd)" },
        { "<leader>fc",      desc = "Config Files" },
        { "<leader>fR",      desc = "Rename File" },
        { "<leader>f/",      desc = "Find Text (Grep)" },
        { "<leader>fw",      desc = "Find Word / Selection" },

        { "<leader>g",       group = "Git" },
        { "<leader>gb",      desc = "Blame Line" },
        { "<leader>gd",      desc = "Diff (Hunks)" },
        { "<leader>gD",      desc = "Diff (origin)" },
        { "<leader>gf",      desc = "Lazygit File Log" },
        { "<leader>gg",      desc = "Lazygit" },
        { "<leader>gl",      desc = "Git Log" },
        { "<leader>gL",      desc = "Git Log (cwd)" },
        { "<leader>gs",      desc = "Git Status" },
        { "<leader>gS",      desc = "Git Stash" },

        { "<leader>h",       group = "Hunk (Git)" },
        { "<leader>hD",      desc = "Diff This ~" },
        { "<leader>hb",      desc = "Blame Line" },
        { "<leader>hd",      desc = "Diff This" },
        { "<leader>hp",      desc = "Preview Hunk" },
        { "<leader>hi",      desc = "Preview Hunk Inline" },
        { "<leader>hR",      desc = "Reset Buffer" },
        { "<leader>hS",      desc = "Stage Buffer" },
        { "<leader>hr",      desc = "Reset Hunk" },
        { "<leader>hs",      desc = "Stage Hunk" },

        -- <leader>s: coc.nvim lists
        { "<leader>s",       group = "Search (CoC)" },
        { "<leader>sc",      desc = "Commands History" },
        { "<leader>sd",      desc = "Diagnostics" },
        { "<leader>se",      desc = "Extensions" },
        { "<leader>sj",      desc = "Next Item" },
        { "<leader>sk",      desc = "Prev Item" },
        { "<leader>so",      desc = "Outline" },
        { "<leader>sh",      desc = "Help Pages (Snacks)" },
        { "<leader>sp",      desc = "Search Plugin Spec (Snacks)" },
        { "<leader>ss",      desc = "Workspace Symbols" },

        { "<leader>t",       group = "Toggle/Options" },
        { "<leader>tf",      "<cmd>ToggleAutoFormat<cr>",          desc = "Autoformat on Save" },
        -- { "<leader>tL",      desc = "Line Numbers" },
        { "<leader>td",      desc = "Diagnostics" },
        -- { "<leader>tn",      desc = "Dismiss Notifications" },
        -- { "<leader>tr",      desc = "Relative Line Numbers" },
        -- { "<leader>ts",      desc = "Sign Column" },

        { "<leader>e",       desc = "File Explorer" },
        { "<leader>w",       desc = "Save File" },
        { "<leader>q",       desc = "Quit" },
        -- { "<leader>n", desc = "No Highlight" },

        -- <leader>m: md-render
        { "<leader>m",       group = "MD-Render", icon = '' },
        -- <leader>n: dotmd
        { "<leader>n",       group = "DotMd", icon = '' },
        -- UI
        { "<leader>u",       group = "UI", icon = '󱕷' },
        -- zenmode
        { "<leader>z",       group = "ZenMode", icon = '󰋱' },

      })
    end,
  },
}
