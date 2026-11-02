return {
  {
    -- <C-p> (g:ctrlp_map) is not a lazy.nvim trigger, so load eagerly
    "ctrlpvim/ctrlp.vim",
    lazy = false,
    init = function()
      vim.g.ctrlp_show_hidden = 0
      vim.g.ctrlp_map = '<C-p>'
    end,
  },
  { "junegunn/fzf", lazy = false },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
    -- <leader>ff is owned by snacks.nvim picker; keep fzf on its own commands
  },
  { "mileszs/ack.vim", cmd = { "Ack", "AckAdd", "AckFromSearch", "LAck" } },
  { "christoomey/vim-tmux-navigator", lazy = false },
}
