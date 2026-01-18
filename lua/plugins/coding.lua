return {
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        { path = '~/Documents/vimwiki', path_html = '~/Documents/vimwiki_public_html/' }
      }
    end,
  },
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
      -- Coc configuration from config/plugin/coc.vim
      vim.cmd([[
        set encoding=utf-8
        set nobackup
        set nowritebackup
        set updatetime=300
        set signcolumn=yes

        inoremap <silent><expr> <TAB>
              \ coc#pum#visible() ? coc#pum#next(1) :
              \ CheckBackspace() ? "\<Tab>" :
              \ coc#refresh()
        inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

        function! CheckBackspace() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        if has('nvim')
          inoremap <silent><expr> <c-space> coc#refresh()
        else
          inoremap <silent><expr> <c-@> coc#refresh()
        endif

        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        nnoremap <silent> gk :call ShowDocumentation()<CR>

        function! ShowDocumentation()
          if CocAction('hasProvider', 'hover')
            call CocActionAsync('doHover')
          else
            call feedkeys('gk', 'in')
          endif
        endfunction

        autocmd CursorHold * silent call CocActionAsync('highlight')

        nmap <leader>cr <Plug>(coc-rename)

        xmap <leader>cf  <Plug>(coc-format-selected)
        nmap <leader>cf  :Format<CR>

        augroup mygroup
          autocmd!
          autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
          autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end

        xmap <leader>ca  <Plug>(coc-codeaction-selected)
        nmap <leader>ca  <Plug>(coc-codeaction-selected)

        nmap <leader>cc  <Plug>(coc-codeaction-cursor)
        nmap <leader>cS  <Plug>(coc-codeaction-source)
        nmap <leader>cx  <Plug>(coc-fix-current)

        nmap <silent> <leader>cR <Plug>(coc-codeaction-refactor)
        xmap <silent> <leader>cR  <Plug>(coc-codeaction-refactor-selected)
        nmap <silent> <leader>cR  <Plug>(coc-codeaction-refactor-selected)

        nmap <leader>cl  <Plug>(coc-codelens-action)

        xmap if <Plug>(coc-funcobj-i)
        omap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap af <Plug>(coc-funcobj-a)
        xmap ic <Plug>(coc-classobj-i)
        omap ic <Plug>(coc-classobj-i)
        xmap ac <Plug>(coc-classobj-a)
        omap ac <Plug>(coc-classobj-a)

        if has('nvim-0.4.0') || has('patch-8.2.0750')
          nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
          nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
          inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
          inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
          vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
          vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
        endif

        nmap <silent> <C-s> <Plug>(coc-range-select)
        xmap <silent> <C-s> <Plug>(coc-range-select)

        command! -nargs=0 Format :call CocActionAsync('format')
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)
        command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

        set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

        nnoremap <silent><nowait> <space>sd  :<C-u>CocList diagnostics<cr>
        nnoremap <silent><nowait> <space>se  :<C-u>CocList extensions<cr>
        nnoremap <silent><nowait> <space>sc  :<C-u>CocList commands<cr>
        nnoremap <silent><nowait> <space>so  :<C-u>CocList outline<cr>
        nnoremap <silent><nowait> <space>ss  :<C-u>CocList -I symbols<cr>
        nnoremap <silent><nowait> <space>sj  :<C-u>CocNext<CR>
        nnoremap <silent><nowait> <space>sk  :<C-u>CocPrev<CR>
        nnoremap <silent><nowait> <space>sp  :<C-u>CocListResume<CR>
      ]])

      -- Autoformat on save setup
      vim.g.autoformat_enabled = true
      
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("CocAutoFormat", { clear = true }),
        pattern = "*",
        callback = function()
          if vim.g.autoformat_enabled then
            -- We use pcall to avoid errors if CoC isn't attached or fails
            -- Use synchronous 'format' to ensure it finishes before save
            pcall(vim.fn.CocAction, 'format')
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
