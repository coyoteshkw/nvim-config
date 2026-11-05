-- nvim-treesitter（main 分支）
--
-- 重要：main 分支是一次重写，旧接口已全部移除：
--   * nvim-treesitter.configs 的 highlight / indent / folding / ensure_installed /
--     auto_install 等选项不再存在，写进 opts 会被静默忽略（不报错，也不生效）。
--   * 现在只保留：解析器安装 install()/update()/uninstall()，
--     高亮由 vim.treesitter.start() 负责，
--     折叠由 vim.treesitter.foldexpr() + foldmethod=expr 负责。
--
-- 本文件据此重写，效果等价于旧版的 highlight.enable + folding。

-- 需要安装的解析器；首次启动会自动下载编译（依赖 tree-sitter CLI 与 C 编译器）
local parsers = {
  "lua",
  "vim",
  "vimdoc",
  "query",
  "python",
  "javascript",
  "typescript",
  "tsx",
  "json",
  "yaml",
  "toml",
  "bash",
  "markdown",
  "markdown_inline",
  "html",
  "css",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- 必须立即加载：FileType 自动命令要在打开文件前就位
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(parsers)

      -- 高亮与折叠。官方写法只有三行，这里多两条防护，原因见行内注释。
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreeSitterStart", { clear = true }),
        callback = function(ev)
          -- 防护 1：没有解析器时直接跳过，保留 options.lua 里 foldmethod=indent 的兜底。
          -- 必须用 language.add 判断：它对缺失的语言返回 nil；而 get_parser 只是返回
          -- nil 而不报错，pcall 恒为 true，无法区分「有解析器」和「没有」。
          -- 注意：FileType 事件里 filetype 在 ev.match 上，ev.filetype 为 nil
          local ft = vim.bo[ev.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft) or ft
          local ok, loaded = pcall(vim.treesitter.language.add, lang)
          if not (ok and loaded) then
            return
          end

          -- 重复调用是幂等的（不会替换已有 highlighter），无需额外判断
          pcall(vim.treesitter.start, ev.buf)

          -- 防护 2：foldmethod/foldexpr 是窗口本地选项，缓冲区不在当前窗口时不要改，
          -- 否则会改到别的窗口上。
          if vim.api.nvim_get_current_buf() ~= ev.buf then
            return
          end
          vim.opt_local.foldmethod = "expr"
          vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          -- foldlevel 沿用 options.lua 的全局值（99，即默认全部展开）
        end,
      })
    end,
  },
}
