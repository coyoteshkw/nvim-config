# my vim config

我的 Neovim 配置（NVIM v0.12+），补全使用 coc.nvim，已全部迁移到 Lua。

## 目录结构

```
init.lua                  -- 入口：leader、禁用 netrw、按序加载下列模块
lua/config/options.lua    -- 基础选项：缩进、UI、折叠、光标形状、colorcolumn
lua/config/keymaps.lua    -- 原生键位映射
lua/config/lazy.lua       -- lazy.nvim 引导
lua/config/colorscheme.lua-- 配色方案、coc 高亮、透明背景开关
lua/plugins/*.lua         -- 插件清单（按主题拆分）
coc-settings.json         -- coc.nvim 配置
```

## 约定

- leader 键为空格，`jk` 退出插入模式，`;` 等价于 `:`
- 缩进统一 2 空格
- 插件通过 `lua/plugins/` 下按主题拆分的文件声明，由 lazy.nvim 管理
- 主题相关选项只写在 `lua/plugins/themes.lua`（单一来源）
- 文件浏览用 mini.files，查找用 snacks.picker

## 键位分组

| 前缀 | 功能 |
| --- | --- |
| `<leader>f` | 查找（文件 / grep / 最近 / buffer） |
| `<leader>c` | 代码操作（coc：重命名、格式化、code action） |
| `<leader>g` | git（lazygit、blame、log） |
| `<leader>h` | hunk（gitsigns） |
| `<leader>s` | coc 列表（诊断、大纲、符号） |
| `<leader>t` | 开关（自动格式化、行号、诊断） |
| `<leader>a` | opencode AI |
| `<leader>e` | 文件浏览器（mini.files） |

完整菜单见 `:WhichKey`。
