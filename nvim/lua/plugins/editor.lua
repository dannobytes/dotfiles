return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs_staged_enable = true,
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`

      -- Extend LazyVim's on_attach to add [c/]c as aliases for [h/]h
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        vim.keymap.set("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, { buffer = buffer, desc = "Prev Hunk" })
        vim.keymap.set("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, { buffer = buffer, desc = "Next Hunk" })
      end,
    },
  },
}
