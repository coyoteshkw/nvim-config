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
}
