return {
  -- {
  --   "vimwiki/vimwiki",
  --   init = function()
  --     vim.g.vimwiki_list = {
  --       { path = "~/Documents/vimwiki", path_html = "~/Documents/vimwiki_public_html/" },
  --     }
  --   end,
  -- },
  {
    "preservim/vim-markdown",
    ft = "markdown",
    init = function()
      vim.g.vim_markdown_borderless_table = 1
    end,
  },
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- 注意：backup / writebackup / updatetime / signcolumn 已在
      -- lua/config/options.lua 统一设置，这里不再重复。

      local keyset = vim.keymap.set
      -- Autocomplete
      function _G.check_back_space()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
      end

      -- Use Tab for trigger completion with characters ahead and navigate
      -- local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
      -- keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
      local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
      vim.keymap.set("i", "<TAB>",
        [[coc#pum#visible() ? coc#pum#select_confirm() : v:lua.check_back_space() ? "<TAB>" : coc#refresh()]], opts)
      keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

      -- Make <CR> to accept selected completion item or notify coc.nvim to format
      -- 这样enter就不会补全而是直接下一行
      keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

      -- Use <c-j> to trigger snippets c-j可以换到下一个跳转点
      keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
      -- Use <c-space> to trigger completion
      keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

      -- Use `[g` and `]g` to navigate diagnostics
      keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
      keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

      -- GoTo code navigation
      keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
      keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
      keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
      keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

      -- Use gk to show documentation in preview window
      function _G.show_docs()
        local cw = vim.fn.expand("<cword>")
        if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command("h " .. cw)
        elseif vim.api.nvim_eval("coc#rpc#ready()") then
          vim.fn.CocActionAsync("doHover")
        else
          vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
        end
      end

      keyset("n", "gk", "<CMD>lua _G.show_docs()<CR>", { silent = true })

      -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
      local coc_group = vim.api.nvim_create_augroup("CocGroup", { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", {
        group = coc_group,
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold",
      })

      -- Symbol renaming
      keyset("n", "<leader>cr", "<Plug>(coc-rename)", { silent = true })

      -- Formatting selected code
      keyset("x", "<leader>cf", "<Plug>(coc-format-selected)", { silent = true })
      keyset("n", "<leader>cf", ":Format<CR>", { silent = true })

      -- Setup formatexpr specified filetype(s)
      vim.api.nvim_create_autocmd("FileType", {
        group = coc_group,
        pattern = "typescript,json",
        command = "setl formatexpr=CocAction('formatSelected')",
        desc = "Setup formatexpr specified filetype(s).",
      })

      -- CocJumpPlaceholder
      vim.api.nvim_create_autocmd("User", {
        group = coc_group,
        pattern = "CocJumpPlaceholder",
        command = "call CocActionAsync('showSignatureHelp')",
        desc = "Update signature help on jump placeholder",
      })

      -- Apply codeAction to the selected region
      local codeaction_opts = { silent = true, nowait = true }
      keyset("x", "<leader>ca", "<Plug>(coc-codeaction-selected)", codeaction_opts)
      keyset("n", "<leader>ca", "<Plug>(coc-codeaction-selected)", codeaction_opts)

      -- Remap keys for apply code actions at the cursor position.
      keyset("n", "<leader>cc", "<Plug>(coc-codeaction-cursor)", codeaction_opts)
      -- Remap keys for apply source code actions for current file.
      keyset("n", "<leader>cS", "<Plug>(coc-codeaction-source)", codeaction_opts)
      -- Apply the most preferred quickfix action on the current line.
      keyset("n", "<leader>cx", "<Plug>(coc-fix-current)", codeaction_opts)

      -- Remap keys for apply refactor code actions.
      keyset("n", "<leader>cR", "<Plug>(coc-codeaction-refactor)", { silent = true })
      keyset("x", "<leader>cR", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
      keyset("n", "<leader>cR", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

      -- Run the Code Lens actions on the current line
      keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", codeaction_opts)

      -- Map function and class text objects
      keyset("x", "if", "<Plug>(coc-funcobj-i)", codeaction_opts)
      keyset("o", "if", "<Plug>(coc-funcobj-i)", codeaction_opts)
      keyset("x", "af", "<Plug>(coc-funcobj-a)", codeaction_opts)
      keyset("o", "af", "<Plug>(coc-funcobj-a)", codeaction_opts)
      keyset("x", "ic", "<Plug>(coc-classobj-i)", codeaction_opts)
      keyset("o", "ic", "<Plug>(coc-classobj-i)", codeaction_opts)
      keyset("x", "ac", "<Plug>(coc-classobj-a)", codeaction_opts)
      keyset("o", "ac", "<Plug>(coc-classobj-a)", codeaction_opts)

      -- <C-f>/<C-b>：浮窗打开时滚动浮窗，否则按键照常工作
      -- （插入模式落到 <Right>/<Left>，即 Emacs 的前后一个字符）
      --
      -- 必须用 Lua 函数做 expr 映射。写成 vimscript 表达式字符串时，返回的
      -- "<Right>" 会被 replace_keycodes 换成内部键码 \x80kr，而这串字节会被
      -- 当作文本插入缓冲区（表现为输入 <80>kr），而不是执行按键。
      local function float_or(direction, fallback)
        local has_float = vim.fn.exists("*coc#float#has_scroll") == 1
          and vim.fn["coc#float#has_scroll"]() == 1
        if has_float then
          vim.fn["coc#float#scroll"](direction)
          return ""
        end
        return fallback
      end

      local float_opts = { silent = true, nowait = true, expr = true, replace_keycodes = true }
      keyset({ "n", "v" }, "<C-f>", function() return float_or(1, "<C-f>") end, float_opts)
      keyset({ "n", "v" }, "<C-b>", function() return float_or(0, "<C-b>") end, float_opts)
      keyset("i", "<C-f>", function() return float_or(1, "<Right>") end, float_opts)
      keyset("i", "<C-b>", function() return float_or(0, "<Left>") end, float_opts)

      -- Use CTRL-S for selections ranges
      keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
      keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

      -- Add `:Format` command to format current buffer
      vim.api.nvim_create_user_command("Format", "call CocActionAsync('format')", {})

      -- " Add `:Fold` command to fold current buffer
      vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

      -- Add `:OR` command for organize imports of the current buffer
      vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

      -- Add (Neo)Vim's native statusline support
      vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

      -- CoC 智能折叠
      -- 修复：coc 的 foldingRange 折叠依赖 foldmethod=manual，而全局默认是
      -- indent（见 lua/config/options.lua），此前两者互相失效。现在只有在
      -- 当前缓冲区确实有 LSP 折叠范围时，才把它切换成 manual。
      function _G.AutoCocFold()
        if vim.fn["coc#rpc#ready"]() == 0 then
          return
        end
        local ok, has_provider = pcall(vim.fn.CocAction, "hasProvider", "foldingRange")
        if not (ok and has_provider) then
          return
        end
        if vim.wo.foldmethod ~= "manual" then
          vim.wo.foldmethod = "manual"
        end
        pcall(vim.fn.CocActionAsync, "fold", "", function() end)
        vim.b.coc_fold_applied = 1
      end

      local fold_group = vim.api.nvim_create_augroup("CocAutoFold", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = fold_group,
        callback = _G.AutoCocFold,
      })
      vim.api.nvim_create_autocmd("CursorHold", {
        group = fold_group,
        callback = function()
          if not vim.b.coc_fold_applied then
            _G.AutoCocFold()
          end
        end,
      })

      -- Mappings for CoCList
      local list_opts = { silent = true, nowait = true }
      keyset("n", "<space>sd", ":<C-u>CocList diagnostics<cr>", list_opts)
      keyset("n", "<space>se", ":<C-u>CocList extensions<cr>", list_opts)
      keyset("n", "<space>sc", ":<C-u>CocList commands<cr>", list_opts)
      keyset("n", "<space>so", ":<C-u>CocList outline<cr>", list_opts)
      keyset("n", "<space>ss", ":<C-u>CocList -I symbols<cr>", list_opts)
      keyset("n", "<space>sj", ":<C-u>CocNext<cr>", list_opts)
      keyset("n", "<space>sk", ":<C-u>CocPrev<cr>", list_opts)
      keyset("n", "<space>sp", ":<C-u>CocListResume<cr>", list_opts)

      -- Autoformat on save setup
      vim.g.autoformat_enabled = true
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("CocAutoFormat", { clear = true }),
        pattern = "*",
        callback = function()
          if vim.g.autoformat_enabled then
            pcall(vim.fn.CocAction, "format")
          end
        end,
      })

      vim.api.nvim_create_user_command("ToggleAutoFormat", function()
        vim.g.autoformat_enabled = not vim.g.autoformat_enabled
        vim.notify("Autoformat on save: " .. (vim.g.autoformat_enabled and "ON" or "OFF"), vim.log.levels.INFO)
      end, {})
    end,
  },
}
