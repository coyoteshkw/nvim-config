return {
  {
    "echasnovski/mini.icons",
    version = "*",
    config = function()
      require("mini.icons").setup()
    end,
  },
  {
    "echasnovski/mini.files",
    version = "*",
    config = function()
      require("mini.files").setup({
        -- Custom customization can go here
        options = {
          -- Whether to use for substituted native file explorer
          use_as_default_explorer = true,
        },
        windows = {
          -- Maximum number of windows to show side by side
          max_number = math.huge,
          -- Whether to show preview of focused file
          preview = true,
          -- Width of focused window
          width_focus = 30,
          -- Width of non-focused window
          width_nofocus = 15,
          -- Width of preview window
          width_preview = 25,
        },
      })

      -- Create an autocommand to map 'q' to close in mini.files windows
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          vim.keymap.set("n", "q", require("mini.files").close, { buffer = args.data.buf_id })
        end,
      })
    end,
    keys = {
      {
        "<leader>e",
        function()
          local bufname = vim.api.nvim_buf_get_name(0)
          local path = vim.fn.filereadable(bufname) == 1 and bufname or vim.fn.getcwd()
          require("mini.files").open(path)
          require("mini.files").reveal_cwd()
        end,
        desc = "Files Explorer (mini.files)",
      },
    },
  },
}
