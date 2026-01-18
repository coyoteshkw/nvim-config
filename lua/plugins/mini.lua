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
    lazy = false,
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
          local close_action = function()
            require("mini.files").close()
            -- If we are in an empty, nameless buffer with no other listed buffers, quit
            if vim.fn.expand("%") == "" and vim.bo.filetype == "" and vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
              -- Check if there are other listed buffers (files open)
              local listed_buffers = vim.tbl_filter(function(b)
                return vim.fn.buflisted(b) == 1
              end, vim.api.nvim_list_bufs())
              
              if #listed_buffers <= 1 then
                vim.cmd("quit")
              end
            end
          end
          
          vim.keymap.set("n", "q", close_action, { buffer = args.data.buf_id })
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
