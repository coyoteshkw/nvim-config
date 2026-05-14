return {
  { "tpope/vim-vinegar" },
  {
    "ctrlpvim/ctrlp.vim",
    init = function()
      vim.g.ctrlp_show_hidden = 0
      vim.g.ctrlp_map = '<C-p>'
    end,
    keys = {
      -- { "<leader>ff", ":CtrlPMRUFiles<CR>", desc = "CtrlP MRU" },
      { "<leader>b", ":CtrlPBuffer<cr>", desc = "CtrlP Buffer" },
    },
  },
  { "junegunn/fzf" },
  { 
	  "junegunn/fzf.vim",
	  dependencies = { "junegunn/fzf" },
	  keys = {
		  { "<leader>ff", ":Files<CR>", desc = "fzf search files"}
	  }
  },
  { "mileszs/ack.vim" },
  { "christoomey/vim-tmux-navigator" },
}
