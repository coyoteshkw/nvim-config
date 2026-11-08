return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- signs = {
      --   add = { text = " ▎" },
      --   change = { text = " ▎" },
      --   delete = { text = " " },
      --   topdelete = { text = " " },
      --   changedelete = { text = " ▎" },
      --   untracked = { text = " ▎" },
      -- },
      -- 已暂存（staged）的符号在 gitsigns 里是另一张独立的表 signs_staged，
      -- 不会继承上面 signs 的自定义；它的默认值仍是 1 字符的 ┃ / ▁ / ▔ / ~。
      -- 单字符符号落在 %s 的第 1 格，而 " ▎" 落在第 2 格 —— 这就是暂存态与
      -- 未暂存态错开整整一列的原因。这里让 staged 用同样的 2 字符写法，
      -- 位置才对齐；两者的区别仍由 GitSignsStaged* 高亮（更暗）来体现。
      -- 注意：没有 untracked 项，未跟踪文件不存在「已暂存」状态。
      -- signs_staged = {
      --   add = { text = " ▎" },
      --   change = { text = " ▎" },
      --   delete = { text = " " },
      --   topdelete = { text = " " },
      --   changedelete = { text = " ▎" },
      -- },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Next Hunk" })

        map("n", "[h", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Prev Hunk" })

        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage Hunk" })
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>hi", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
        map("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff This ~" })
      end,
    },
  },
}
