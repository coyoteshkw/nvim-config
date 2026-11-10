return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
      --   add = { text = " ▎" },
      --   change = { text = " ▎" },
        delete = { text = " " },
        topdelete = { text = " " },
      --   changedelete = { text = " ▎" },
      --   untracked = { text = " ▎" },
      },
      -- 已暂存（staged）的符号在 gitsigns 里是另一张独立的表 signs_staged，
      -- 不会继承上面 signs 的自定义；它的默认值仍是 1 字符的 ┃ / ▁ / ▔ / ~。
      -- 单字符符号落在 %s 的第 1 格，而 " ▎" 落在第 2 格 —— 这就是暂存态与
      -- 未暂存态错开整整一列的原因。这里让 staged 用同样的 2 字符写法，
      -- 位置才对齐；两者的区别仍由 GitSignsStaged* 高亮（更暗）来体现。
      -- 注意：没有 untracked 项，未跟踪文件不存在「已暂存」状态。
      signs_staged = {
      --   add = { text = " ▎" },
      --   change = { text = " ▎" },
        delete = { text = " " },
        topdelete = { text = " " },
      --   changedelete = { text = " ▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- ===== 跳转（Navigation）=====
        -- ]h：跳到下一个改动块（hunk）；diff 模式下自动改用 ]c
        map("n", "]h", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Next Hunk" })

        -- [h：跳到上一个改动块（hunk）；diff 模式下自动改用 [c
        map("n", "[h", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Prev Hunk" })
        -- test for hunk
        -- test for hunk
        -- test for hunk
        -- test for hunk

        -- test for hunk
        -- test for hunk
        -- test for hunk
        -- test for hunk
        -- test for hunk
        -- test for hunk
        -- ===== 操作（Actions）=====
        -- 暂存光标所在的 hunk（把该处改动加入暂存区）
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
        -- 丢弃工作区中未暂存的改动 hunk（当前hunk恢复到上一次暂存时的状态）
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
        -- 丢弃buffer 中未暂存的改动（整个buffer都恢复到上一次暂存前的状态）
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
        -- 暂存选区内的 hunk 级改动
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage Hunk" })
        -- 丢弃选区内的 hunk 级改动
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Hunk" })
        -- 暂存buffer 的所有改动
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
        -- 预览光标下hunk 差异
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
        -- 预览光标下hunk 差异(inline模式，和前者效果都不错)
        map("n", "<leader>hi", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })
        -- git blame（含完整提交信息）
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
        -- diff 模式对比当前 buffer 与索引（HEAD）的差异(会打开另一个垂直面板)
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
        -- diff 模式对比当前 buffer 与上一次提交（~）的差异
        map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff This ~" })
        -- 取消暂存（Unstage），把光标处 hunk 从暂存区撤回工作区
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        -- 取消整个 buffer 的暂存 | 把暂存区内容撤回工作区，代码不会丢失
        map("n", "<leader>hU", gs.reset_buffer_index, { desc = "Unstage Buffer" })
      end,
    },
  },
}
