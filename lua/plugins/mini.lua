return {
  -- nerd icons support
  {
    "nvim-mini/mini.icons",
    version = "*",
    config = function()
      require("mini.icons").setup()
    end,
  },
  -- a = around i = inner
  {
    "nvim-mini/mini.ai",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup()
    end,
  },
  -- 内容的可视化移动，因alt键太热门而放弃
  -- cmdline：补全弹窗 + 范围预览
  {
    "nvim-mini/mini.cmdline",
    version = false,
    config = function()
      require("mini.cmdline").setup({
        -- 输入时自动弹出候选列表（只展示候选，是否插入文本由 'wildmode' 决定）
        autocomplete = {
          enable = true,
          delay = 80,
        },
        -- 关闭「自动纠错」：默认行为会把打错的命令/选项名
        -- 直接替换成最接近的合法项（如 :set relativenuber -> relativenumber）
        autocorrect = { enable = false },
      })
    end,
  },
  {
    "nvim-mini/mini.files",
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
  -- 行号栏：符号列留在行号右侧（模块默认 =lfs），但去掉 ▏ 分隔符
  -- 背景：默认 spec 是 { format = '=lfs', sep = '▏' }，多出来的 ▏ 是
  -- statuscolumn 自带的第 6 格竖线，与 snacks.indent 的缩进线不共列
  -- （缩进线在正文第 0/2/4… 列，▏ 在正文左边界再往左一格），
  -- 看起来像多了一条错位的缩进线，且整条 gutter 比内置多占 1 列。
  -- 去掉 sep 后宽度回到 1(符号) + 4(行号) = 5 列，与安装插件前一致。
  {
    "nvim-mini/mini.statuscolumn",
    version = false,
    config = function()
      local statuscolumn = require("mini.statuscolumn")
      statuscolumn.setup({
        content = statuscolumn.gen_content.main({
          { format = "=lfs", sep = "" }, -- 行号 → 折叠 → 符号，不留分隔符
          { ltype = "virt", lnum = "•" }, -- 虚拟行
          { ltype = "wrap", lnum = "↳" }, -- 软换行的续行
        }),
      })
    end,
  },
}
