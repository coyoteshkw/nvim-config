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
  -- { "easymotion/vim-easymotion" },
  {
    "rhysd/clever-f.vim",
    init = function()
      vim.g.clever_f_chars_match_any_signs = ";"
      vim.g.clever_f_smart_case = 1
    end,
  },
  { "tpope/vim-surround",   lazy = false },
  { "tpope/vim-unimpaired", lazy = false },
  -- 注释插件，可以用mini.comment代替，但我发现其实这个也挺好用的，而且gc{真的很不错啊
  {
    "tpope/vim-commentary",
    keys = {
      { "<C-/>", ":Commentary<CR>", desc = "Toggle Comment" },
    },
  },
  -- { "michaeljsmith/vim-indent-object" },
  { "terryma/vim-expand-region", lazy = false },
  { "godlygeek/tabular",         cmd = { "Tabularize" } },
  -- 更美观的折叠态展示插件
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    opts = {
      foldtext = {
        padding = { width = 3 },
        lineCount = { template = "󰘖 %d", hlgroup = "Comment" },
        diagnosticsCount = true,
        gitsignsCount = true,
      },
      foldKeymaps = {
        setup = true,               -- modifies `h`, `l`, `^`, and `$`
        closeOnlyOnFirstColumn = false, -- `h` and `^` only fold in the 1st column
        scrollLeftOnCaret = false,  -- `^` should scroll left (basically mapped to `0^`)
      },
    },                              -- required even when using default config

    -- recommended: disable vim's auto-folding
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },
  { "tpope/vim-repeat" }
}
