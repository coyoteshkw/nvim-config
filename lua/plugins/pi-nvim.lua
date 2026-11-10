return {
  -- 极简pi.dev插件
  {
    "pablopunk/pi.nvim",
    cmd = { "PiAsk", "PiAskSelection", "PiCancel", "PiToggleSession", "PiLog" },
    keys = {
      { "<leader>aa", mode = "n", desc = "Pi: Ask" },
      { "<leader>aa", mode = "v", desc = "Pi: Ask Selection" },
    },
    config = function()
      vim.keymap.set("n", "<leader>aa", "<Cmd>PiAsk<CR>", {
        buffer = false,
        desc = "Pi: 启动",
      })
      vim.keymap.set("v", "<leader>aa", "<Cmd>PiAskSelection<CR>", {
        buffer = false,
        desc = "Pi: 对选中内容提问",
      })
    end,
  },
}
