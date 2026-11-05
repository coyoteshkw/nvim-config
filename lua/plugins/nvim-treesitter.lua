-- nvim-treesitter（main 分支）
--
-- 注意：main 分支是一次不兼容重写，旧接口已全部移除。nvim-treesitter.configs 的
-- highlight / indent / folding / ensure_installed / auto_install 等选项不再存在，
-- 写进 opts 会被静默忽略（不报错，也不生效）。
-- 现在只保留解析器安装 install()，高亮与折叠都由 Neovim 自带能力提供。
--
-- 官方最小写法（见 main 分支 README）：
--   vim.api.nvim_create_autocmd('FileType', { pattern = {'<ft>'}, callback = function() vim.treesitter.start() end })
--   vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
--   vim.wo[0][0].foldmethod = 'expr'
-- 本文件的差异只有一处：用 language.add 运行时判断替代 pattern 白名单，
-- 避免再维护一份「文件类型 → 解析器」列表（两者名字并不总一致，如 typescriptreact -> tsx）。

-- 需要安装的解析器；缺失时启动会自动下载编译（依赖 tree-sitter CLI 与 C 编译器）
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
    lazy = false, -- 官方明确不支持懒加载
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("TreeSitterStart", { clear = true }),
        callback = function(ev)
          -- 无解析器时跳过，保留 options.lua 里 foldmethod=indent 的兜底。
          -- language.add 对缺失的语言返回 nil（不报错）；get_parser 同样只返回 nil，
          -- 无法区分有无解析器，别用它做判断。
          local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
          if not lang or not vim.treesitter.language.add(lang) then
            return
          end

          vim.treesitter.start(ev.buf)
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
        end,
      })
    end,
  },
}
