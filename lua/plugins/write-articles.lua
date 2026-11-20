-- ZenMode 下行尾 ">" 标记的隐藏状态
--
-- 背景：'wrap' 开启时，若文本区可用列数为奇数，双宽字符（中文）放不进最后 1 列，
-- Neovim 会在该列绘制 ">" 表示本行在下一视觉行继续。该字符使用 NonText 高亮，
-- 不受 list / listchars / fillchars 控制（:h hl-NonText 有明确说明）。
-- goyo.vim 之所以"没有"这个符号，是它的 s:tranquilize() 把 NonText 的前景色
-- 设成了 Normal 的背景色，属于"隐形"而非"移除"。
-- 这里复刻同样效果，并在退出 ZenMode 时还原，避免影响其他窗口。
local zen_saved_nontext
local zen_saved_colorscheme
local zen_saved_snacks_indent

return {
  -- 已移除：它通过 ftdetect/markdown.vim 里的 `*.mdx setfiletype markdown`
  -- 把 .mdx 强制当成 markdown，从而让 render-markdown 生效。
  -- 现在改为在 config/options.lua 里用 vim.filetype.add 统一把 .mdx 映射为 markdown。
  -- {
  --   "preservim/vim-markdown",
  --   ft = "markdown",
  --   init = function()
  --     vim.g.vim_markdown_borderless_table = 1
  --   end,
  -- },
  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown", -- or 'event = "VeryLazy"'
    opts = {
      -- configuration here or empty for defaults
      on_attach = function(bufnr)
        local map = vim.keymap.set
        local opts = { buffer = bufnr }
        map("i", "<C-CR>", "<Cmd>MDListItemBelow<CR>", opts)
      end,

    },
  },
  -- mkdnflow.nvim
  -- {
  --   'jakewvincent/mkdnflow.nvim',
  --   config = function()
  --     require('mkdnflow').setup({})
  --   end
  -- },
  -- mdx support
  -- 只为它的 after/queries/markdown/*.scm（JSX 注入 / 高亮）而保留。
  -- 它注册的 extension = { mdx = "mdx" } 会被 config/options.lua 里的 pattern
  -- 映射覆盖，所以 .mdx 最终仍是 filetype=markdown，不影响其余 markdown 插件。
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  },
  {
    "xheisenbugx/org.nvim",
    main = "org",
    lazy = false, -- startup cost is small: heavy modules load on first use
    opts = {
      org_directory = "~/Documents/org",
      agenda_files = { "~/Documents/org/**/*.org" },
      default_notes_file = "~/Documents/org/refile.org",
    },
  },
  -- markdown语法渲染
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    -- .mdx 已在 config/options.lua 里统一映射为 filetype=markdown，
    -- 因此这里保持默认 file_types = { 'markdown' } 即可覆盖 .md 与 .mdx。
    opts = {
      -- code block
      code = {
        -- 改为false会关闭代码块小图标，但可能也改了其他东西
        sign = true,
        language_icon = false, --关闭小图标，可以直接通过statuscolumn来查看
        -- width = 'block',
        -- min_width = 80,
      },
      heading = {
        -- border = true,
        -- render_modes = true, -- keep rendering in insert mode
      },
      link = {
        wiki = { icon = " ", highlight = "RenderMarkdownWikiLink", scope_highlight = "RenderMarkdownWikiLink" },
        image = " ",
        custom = {
          github = { pattern = "github", icon = " " },
          gitlab = { pattern = "gitlab", icon = "󰮠 " },
          youtube = { pattern = "youtube", icon = " " },
          cern = { pattern = "cern.ch", icon = " " },
        },
        hyperlink = " ",
      },
      pipe_table = {
        alignment_indicator = "─",
        border = { "╭", "┬", "╮", "├", "┼", "┤", "╰", "┴", "╯", "│", "─" },
      },
      anti_conceal = {
        -- disabled_modes = { "n" },
        ignore = {
          -- bullet = true, -- render bullet in insert mode
          head_border = true,
          head_background = true,
        },
      },

    },
  },
  -- dotmd.nvim - 悬浮快速笔记
  {
    "y3owk1n/dotmd.nvim",
    cmd = {
      "DotMdCreateNote",
      "DotMdCreateTodoToday",
      "DotMdCreateJournal",
      "DotMdInbox",
      "DotMdNavigate",
      "DotMdPick",
      "DotMdOpen",
    },
    event = "VeryLazy",
    ---@type DotMd.Config
    opts = {
      root_dir = "~/Documents/dotmd", -- set it to your desired directory or remain at it is
      default_split = "float",        -- or "vertical" or "horizontal" or "none" based on your preference
      rollover_todo = {
        enabled = true,               -- enable rollover
      },
      picker = "snacks"               -- or "fzf" or "telescope" or "mini" based on your preference
    },
    keys = {
      {
        "<leader>nc",
        function()
          require("dotmd").create_note()
        end,
        desc = "[DotMd] Create new note",
      },
      {
        "<leader>nt",
        function()
          require("dotmd").create_todo_today()
        end,
        desc = "[DotMd] Create todo for today",
      },
      {
        "<leader>ni",
        function()
          require("dotmd").inbox()
        end,
        desc = "[DotMd] Inbox",
      },
      {
        "<leader>nj",
        function()
          require("dotmd").create_journal()
        end,
        desc = "[DotMd] Create journal",
      },
      {
        "<leader>np",
        function()
          require("dotmd").navigate("previous")
        end,
        desc = "[DotMd] Navigate to previous todo",
      },
      {
        "<leader>nn",
        function()
          require("dotmd").navigate("next")
        end,
        desc = "[DotMd] Navigate to next todo",
      },
      {
        "<leader>no",
        function()
          require("dotmd").open({
            pluralise_query = true, -- recommended
          })
        end,
        desc = "[DotMd] Open",
      },
      {
        "<leader>sna",
        function()
          require("dotmd").pick()
        end,
        desc = "[DotMd] Everything",
      },
      {
        "<leader>snA",
        function()
          require("dotmd").pick({
            grep = true,
          })
        end,
        desc = "[DotMd] Search everything grep",
      },
      {
        "<leader>snn",
        function()
          require("dotmd").pick({
            type = "notes",
          })
        end,
        desc = "[DotMd] Search notes",
      },
      {
        "<leader>snN",
        function()
          require("dotmd").pick({
            type = "notes",
            grep = true,
          })
        end,
        desc = "[DotMd] Search notes grep",
      },
      {
        "<leader>snt",
        function()
          require("dotmd").pick({
            type = "todos",
          })
        end,
        desc = "[DotMd] Search todos",
      },
      {
        "<leader>snT",
        function()
          require("dotmd").pick({
            type = "todos",
            grep = true,
          })
        end,
        desc = "[DotMd] Search todos grep",
      },
      {
        "<leader>snj",
        function()
          require("dotmd").pick({
            type = "journals",
          })
        end,
        desc = "[DotMd] Search journal",
      },
      {
        "<leader>snJ",
        function()
          require("dotmd").pick({
            type = "journals",
            grep = true,
          })
        end,
        desc = "[DotMd] Search journal grep",
      },
    },
  },
  -- zen-mode
  {
    "folke/zen-mode.nvim",
    keys = {
      { "<leader>zz", ":ZenMode<CR>", desc = "Toggle ZenMode" },
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      window = {
        backdrop = 1,
        width = 80,
        options = {
          -- signcolumn = "no", -- disable signcolumn
          number = false,         -- disable number column
          relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      -- 进入 ZenMode 时把 NonText 的前景色设为背景色，使行尾的 ">" 标记不可见
      -- （与 goyo.vim 的 s:tranquilize() 行为一致）；退出时原样还原。
      on_open = function(win)
        zen_saved_nontext = vim.api.nvim_get_hl(0, { name = "NonText" })
        zen_saved_colorscheme = vim.g.colors_name
        local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
        if normal.bg then
          vim.api.nvim_set_hl(0, "NonText", {
            fg = normal.bg,
            bg = normal.bg,
            ctermfg = normal.ctermbg,
            ctermbg = normal.ctermbg,
          })
        end

        -- ZenMode 内关闭 statuscolumn。
        --
        -- 原因：'wrap' 开启且行内含双宽字符（中文）时，若续行（v:virtnum > 0）的
        -- statuscolumn 内容与首行不同，Neovim 的增量重绘会把该行部分单元格清空成
        -- 空白——文字仍在缓冲区里，只是屏幕格子被写空，继续输入时空白还会沿行
        -- 移动，退出插入模式触发整屏重绘后恢复。mini.statuscolumn 的「↳」软换行
        -- 标记正是"续行与首行内容不同"的情形，实测在 ZenMode 下必然出现。
        --
        -- 全局保留「↳」（见 lua/plugins/mini.lua），只在这里把整条 statuscolumn
        -- 置空：配合上面 window.options 的 number/relativenumber = false，写作时
        -- 即为纯文本视图。zen 窗口是临时浮窗，关闭时该窗口级选项随窗口一起丢弃，
        -- 父窗口的 statuscolumn 不受影响，故 on_close 无需还原。
        -- 人类注：置空而不是关闭signcolumn的原因是这样可以保留Git提示符
        vim.wo[win].statuscolumn = ""

        -- 关闭缩进线（含作用域高亮）。
        -- snacks.indent 的 decoration provider 每次重绘都会检查 config.filter，
        -- 而 filter 读取 vim.b.snacks_indent，置为 false 后该 buffer 的
        -- 缩进线不再绘制（buffer 级，ZenMode 覆盖整屏，视觉上等价于当前窗口）。
        zen_saved_snacks_indent = vim.b.snacks_indent
        vim.b.snacks_indent = false
        vim.cmd("redraw!")
      end,
      on_close = function()
        -- 若 ZenMode 期间切换过配色方案，新方案已经写好了 NonText，
        -- 此时还原会把旧配色写回去，故跳过。
        if zen_saved_nontext and zen_saved_colorscheme == vim.g.colors_name then
          vim.api.nvim_set_hl(0, "NonText", zen_saved_nontext)
        end
        zen_saved_nontext, zen_saved_colorscheme = nil, nil

        -- 还原缩进线设置（原值为 nil 时等同于删除该变量，恢复默认开启）
        vim.b.snacks_indent = zen_saved_snacks_indent
        zen_saved_snacks_indent = nil
        vim.cmd("redraw!")
      end,
    }
  },
  -- twilight.nvim
  {
    "folke/twilight.nvim",
    keys = {
      { "<leader>uD", "<cmd>Twilight<CR>", desc = "Toggle Dim" },
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  -- goyo.vim
  {
    "junegunn/goyo.vim",
    keys = {
      { "<leader>zg", ":Goyo 80<CR>", desc = "Toggle Goyo" },
    },
    init = function()
      -- 修复 goyo 下 render-markdown 代码块"糊成背景色"的问题
      --
      -- 原因：goyo 的 s:tranquilize() 会把 ColorColumn 的 fg 和 bg 一起刷成
      -- Normal 的背景色；而 render-markdown 的代码块高亮 RenderMarkdownCode
      -- 是 link 到 ColorColumn 的（RenderMarkdownCodeBorder 再链到它）。于是：
      --   * bg 被刷掉 → 代码块背景与页面背景无法区分
      --   * fg 被设成背景色 → 该 extmark 的 priority 是 140，高于 treesitter(90)
      --     和 syntax(50)，于是代码正文被整体涂成背景色
      -- 这里在进入 Goyo 后把 ColorColumn 还原成配色方案里的原值，只保留 bg、不设 fg。
      -- User GoyoEnter 在 s:tranquilize() 之后触发，所以能覆盖它的修改；
      -- 退出时 goyo 会重新加载配色方案（autoload/goyo.vim:394），无需额外还原。
      local pristine
      local in_goyo = false
      local group = vim.api.nvim_create_augroup("GoyoFixColorColumn", { clear = true })

      local function apply_pristine()
        if pristine and pristine.bg then
          vim.api.nvim_set_hl(0, "ColorColumn", { bg = pristine.bg, ctermbg = pristine.ctermbg })
        end
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        group = group,
        callback = function()
          pristine = vim.api.nvim_get_hl(0, { name = "ColorColumn" })
          -- goyo 自己也挂了 ColorScheme -> s:tranquilize()，且注册顺序在本回调之后，
          -- 因此延后一拍再还原，保证最终生效的是配色方案里的原值。
          if in_goyo then
            vim.schedule(apply_pristine)
          end
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "GoyoEnter",
        callback = function()
          in_goyo = true
          apply_pristine()
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "GoyoLeave",
        callback = function()
          in_goyo = false
        end,
      })
    end,
  },
  {
    -- "preservim/vim-pencil"
  },
  -- md-render.nvim md渲染预览(包括图片)
  {
    "delphinus/md-render.nvim",
    version = "*",
    dependencies = {
      -- { "nvim-tree/nvim-web-devicons", version = "*" }, -- optional: file type icons in code blocks
      { "delphinus/budoux.lua", version = "*" }, -- optional: CJK phrase-level line breaking
    },
    keys = {
      { "<leader>mp", "<Plug>(md-render-preview)",     desc = "Markdown preview (toggle)" },
      { "<leader>mt", "<Plug>(md-render-preview-tab)", desc = "Markdown preview in tab (toggle)" },
    },
  },
  -- neowiki(vim-wiki替代)
  {
    "echaya/neowiki.nvim",
    opts = {
      wiki_dirs = {
        -- neowiki.nvim supports both absolute and tilde-expanded paths
        { name = "Work",     path = "~/Documents/blog/neowiki" },
        { name = "Personal", path = "personal/wiki" },
      },
    },
    keys = {
      { "<leader>ww", "<cmd>lua require('neowiki').open_wiki()<cr>",          desc = "Open Wiki" },
      { "<leader>wW", "<cmd>lua require('neowiki').open_wiki_floating()<cr>", desc = "Open Wiki in Floating Window" },
      { "<leader>wT", "<cmd>lua require('neowiki').open_wiki_new_tab()<cr>",  desc = "Open Wiki in Tab" },
    },
  },
  -- zenmode替代品
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    opts = {
      width = 80,
      -- buffers = {
      --   wo = { fillchars = "eob: " },
      --   scratchPad = { enabled = true },
      --   bo = { filetype = "markdown" },
      --   left = { scratchPad = { pathToFile = "~/todo.md" } },
      --   right = { scratchPad = { pathToFile = "~/scratch.md" } },
      -- },
    },
    keys = {
      { "<leader>zn", "<cmd>NoNeckPain<cr>", desc = "Toggle NoNeckPain" },
    },
  },
  -- 有序列表无序列表等自动补全
  {
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "text",
      "tex",
      "plaintex",
      "norg",
    },
    config = function()
      require("autolist").setup()

      vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      -- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
      vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
      -- 回车还可以切换todolist状态
      vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
      vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")

      -- cycle list types with dot-repeat
      vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
      vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })

      -- if you don't want dot-repeat
      -- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
      -- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")

      -- functions to recalculate list on edit
      vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
  },
}
