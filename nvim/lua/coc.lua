----------------------
-- CoC config
-- https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
----------------------
vim.g.coc_global_extensions = {
  'coc-css',
  'coc-eslint',
  'coc-html',
  'coc-jest',
  'coc-json',
  'coc-lua',
  'coc-marketplace',
  'coc-prettier',
  'coc-snippets',
  'coc-stylelintplus',
  'coc-svg',
  'coc-tsserver',
  'coc-yaml',
  'coc-yank',
}

---------------------------------------------------
-- CoC mappings - Largely inspired by this example:
-- https://github.com/neoclide/coc.nvim#example-vim-configuration
---------------------------------------------------
-- Confirm completion by pressing enter.
vim.keymap.set('i', '<CR>', function()
  if vim.fn['coc#pum#visible']() == 1 then
    return vim.fn['coc#pum#confirm']()
  else
    return vim.api.nvim_replace_termcodes('<CR>', true, false, true)
  end
end, { expr = true, silent = true })

-- Shortcuts to next/previous diagnostic errors.
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })

-- Common goto code navigation.
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Use K to show documentation in preview window.
local function ShowDocumentation()
  if vim.fn.CocHasProvider('hover') then
    vim.fn.CocActionAsync('definitionHover')
  else
    vim.fn.feedkeys('K', 'in')
  end
end
vim.keymap.set('n', 'K', ShowDocumentation, { silent = true })

-- Symbol renaming.
vim.keymap.set('n', '<leader>rn', '<Plug>(coc-rename)')

-- Remap keys for applying codeAction to the current buffer.
vim.keymap.set('n', '<leader>ac', '<Plug>(coc-codeaction-cursor)')
-- Remap keys for apply code actions affect whole buffer
vim.keymap.set('n', '<leader>as', '<Plug>(coc-codeaction-source)')
-- Apply AutoFix to problem on the current line.
vim.keymap.set('n', '<leader>qf', '<Plug>(coc-fix-current)')

-- Remap <C-f> and <C-b> for scroll float windows/popups.
vim.keymap.set('n', '<C-f>', function()
  return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](1) or '<C-f>'
end, { expr = true, silent = true, nowait = true })

vim.keymap.set('n', '<C-b>', function()
  return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](0) or '<C-b>'
end, { expr = true, silent = true, nowait = true })

vim.keymap.set('i', '<C-f>', function()
  return vim.fn['coc#float#has_scroll']() == 1 and '<C-r>=coc#float#scroll(1)<CR>' or '<Right>'
end, { expr = true, silent = true, nowait = true })

vim.keymap.set('i', '<C-b>', function()
  return vim.fn['coc#float#has_scroll']() == 1 and '<C-r>=coc#float#scroll(0)<CR>' or '<Left>'
end, { expr = true, silent = true, nowait = true })

vim.keymap.set('v', '<C-f>', function()
  return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](1) or '<C-f>'
end, { expr = true, silent = true, nowait = true })

vim.keymap.set('v', '<C-b>', function()
  return vim.fn['coc#float#has_scroll']() == 1 and vim.fn['coc#float#scroll'](0) or '<C-b>'
end, { expr = true, silent = true, nowait = true })

-- Show all diagnostics.
vim.keymap.set('n', '<leader>d', '<Cmd>CocList diagnostics<CR>', { silent = true, nowait = true })
-- Manage extensions.
vim.keymap.set('n', '<leader>e', '<Cmd>CocList extensions<CR>', { silent = true, nowait = true })
-- Show commands.
vim.keymap.set('n', '<leader>c', '<Cmd>CocList commands<CR>', { silent = true, nowait = true, })
-- Find symbol of current document.
vim.keymap.set('n', '<leader>o', '<Cmd>CocList outline<CR>', { silent = true, nowait = true, })
-- Search workspace symbols
vim.keymap.set('n', '<leader>s', '<Cmd>CocList -I symbols<CR>', { silent = true })
