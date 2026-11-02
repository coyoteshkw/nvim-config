return {
  {
    "NickvanDyke/opencode.nvim",
    -- The plugin relies on snacks.nvim for the best experience (picker, input, terminal)
    dependencies = { "folke/snacks.nvim" },
    lazy = false, -- Force load to ensure checkhealth works and keymaps are active
    config = function()
      -- Configuration
      vim.g.opencode_opts = {
        provider = {
          enabled = "snacks", -- Use snacks.terminal
        },
      }

      -- Required for opts.events.reload (auto-reloading buffers modified by AI)
      vim.o.autoread = true

      -- Keymaps
      local opencode = require("opencode")

      -- Ask AI (General)
      vim.keymap.set({ "n", "x" }, "<leader>aa", function() opencode.ask() end, { desc = "Ask Opencode" })

      -- Ask AI with Context (@this)
      vim.keymap.set({ "n", "x" }, "<leader>ac", function() opencode.ask("@this: ") end, { desc = "Ask Opencode (@this)" })

      -- Select / Actions Picker
      vim.keymap.set({ "n", "x" }, "<leader>as", function() opencode.select() end, { desc = "Opencode Actions" })

      -- Toggle AI Terminal
      vim.keymap.set({ "n", "t" }, "<leader>at", function() opencode.toggle() end, { desc = "Toggle Opencode" })

      -- Operator (go)
      vim.keymap.set({ "n", "x" }, "<leader>ao", function() return opencode.operator("@this ") end, { desc = "Opencode Operator", expr = true })
    end,
  },
}
