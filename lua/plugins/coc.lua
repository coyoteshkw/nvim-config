return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      -- 注意：backup / writebackup / updatetime / signcolumn 已在
      -- lua/config/options.lua 统一设置，这里不再重复。
      -- <C-f>/<C-b> 的浮窗滚动在 lua/config/keymaps.lua。

      local keyset = vim.keymap.set
      -- Autocomplete
      function _G.check_back_space()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
      end

      -- Use Tab for trigger completion with characters ahead and navigate
      local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
      keyset("i", "<TAB>",
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

      -- Use CTRL-S for selections ranges
      keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
      keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

      -- Add `:Format` command to format current buffer
      vim.api.nvim_create_user_command("Format", "call CocActionAsync('format')", {})

      -- Add `:Fold` command to fold current buffer
      vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

      -- Add `:OR` command for organize imports of the current buffer
      vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

      -- Add (Neo)Vim's native statusline support
      vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

      -- CoC 智能折叠 —— 已停用
      -- 原因：coc 的 foldingRange 折叠强制 foldmethod=manual，会覆盖
      -- treesitter 需要的 foldmethod=expr（见 lua/plugins/nvim-treesitter.lua），
      -- 两者互斥。现在统一由 treesitter 提供折叠，这里不再自动切换 foldmethod。
      -- 若将来想改回 LSP 折叠，把下面这段取消注释，并关闭 treesitter 的折叠设置。
      --
      -- function _G.AutoCocFold()
      --   if vim.fn["coc#rpc#ready"]() == 0 then return end
      --   local ok, has_provider = pcall(vim.fn.CocAction, "hasProvider", "foldingRange")
      --   if not (ok and has_provider) then return end
      --   if vim.wo.foldmethod ~= "manual" then vim.wo.foldmethod = "manual" end
      --   pcall(vim.fn.CocActionAsync, "fold", "", function() end)
      --   vim.b.coc_fold_applied = 1
      -- end
      --
      -- local fold_group = vim.api.nvim_create_augroup("CocAutoFold", { clear = true })
      -- vim.api.nvim_create_autocmd("BufWritePost", { group = fold_group, callback = _G.AutoCocFold })
      -- vim.api.nvim_create_autocmd("CursorHold", {
      --   group = fold_group,
      --   callback = function()
      --     if not vim.b.coc_fold_applied then _G.AutoCocFold() end
      --   end,
      -- })

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

      -- 覆盖默认<C-e>的表现(不显示补全面板)，放在config中确保它在coc.nvim插件加载完成后才执行
      -- 保证成功覆盖
      keyset("i", "<C-e>", "<End>", { silent = true, desc = "Emacs-style jump to end of line" })

      -- Autoformat on save setup
      vim.g.autoformat_enabled = false
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
