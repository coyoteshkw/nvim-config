-- ======================================
--
--              Colorscheme
--
-- ======================================
-- 由 config/appearance.vim 迁移而来
--
-- 说明：everforest 的 g: 选项统一在 lua/plugins/themes.lua 的 init 中设置
-- （那里是唯一来源，且必须在插件加载前生效），本文件只负责启用主题与
-- 主题相关的高亮微调。

local function coc_highlights()
  -- coc 的选中词高亮与诊断下划线（跟随配色方案重新应用）
  vim.api.nvim_set_hl(0, "CocHighlightText", { bg = "#45475a", ctermbg = 238 })
  vim.api.nvim_set_hl(0, "CocErrorHighlight", { underline = true, sp = "Red" })
  vim.api.nvim_set_hl(0, "CocWarningHighlight", { underline = true, sp = "Orange" })
  vim.api.nvim_set_hl(0, "CocInfoHighlight", { underline = true })
  vim.api.nvim_set_hl(0, "CocHintHighlight", { underline = true })
end

local function apply_colorscheme(name)
  if not pcall(vim.cmd.colorscheme, name) then
    vim.notify("Colorscheme not found: " .. name, vim.log.levels.WARN)
    return
  end
  coc_highlights()
end

-- 切换配色方案时重新套用 coc 高亮
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("CocHighlightOverride", { clear = true }),
  callback = coc_highlights,
})

-- 深色背景（原 appearance.vim 中的 set background=dark）
vim.opt.background = "dark"

apply_colorscheme("everforest")

-- === 透明背景开关 ===
-- 修复原 vimscript 版本的 bug：变量名拼写错误（t:is_tranparent）导致状态
-- 无法回退，透明背景只能开不能关。
local transparent = false

local function toggle_transparent()
  transparent = not transparent
  if transparent then
    for _, group in ipairs({ "Normal", "NormalNC", "SignColumn", "EndOfBuffer", "MsgArea" }) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  else
    -- 重新应用配色方案即可完整恢复背景
    apply_colorscheme(vim.g.colors_name or "everforest")
  end
  vim.notify("Transparent background: " .. (transparent and "ON" or "OFF"), vim.log.levels.INFO)
end

vim.keymap.set("n", "gl", toggle_transparent, { silent = true, desc = "Toggle transparent background" })
