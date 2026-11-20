-- markdown 专属的缓冲区 / 窗口局部设置。
--
-- 为什么放在 after/ftplugin：
--   * 本文件在 runtime 的 ftplugin/markdown.lua 之后加载（after 目录位于整个
--     runtimepath 末尾），所以能覆盖 Neovim 0.12 自带 ftplugin 的默认行为。
--   * 只处理「filetype 已经是 markdown」时的局部设置；filetype 的判定本身
--     （包括 .mdx -> markdown 的映射）仍留在 lua/config/options.lua，
--     那是本文件得以加载的前置条件，不能放进来。
--
-- 注意：这里是 ftplugin，只在 FileType 时执行一次，不负责跨窗口 / 跨缓冲区
-- 的重复校正。需要 WinEnter / BufWinEnter 兜底的东西（如 scrolloff）不要放这里。

-- 长行软换行显示
vim.opt_local.wrap = true
-- vim.opt_local.linebreak = true
-- vim.opt_local.showbreak = " "  -- 清空软换行后的行首标记
-- vim.opt_local.list = false     -- 关键：在 Markdown 中强制关闭 list
-- vim.opt_local.listchars:remove({ "extends", "precedes" })

-- 开启 wrap 后，j/k 默认按缓冲区行移动，会一次跳过多个屏幕行；
-- 改为视觉行移动，手感与屏幕上看到的一致。
vim.keymap.set("n", "j", "gj", { buffer = true, desc = "Move down visual line" })
vim.keymap.set("n", "k", "gk", { buffer = true, desc = "Move up visual line" })
