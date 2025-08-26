-- Leader shortcut keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Shortcut to sort all lines within the current curly block
-- nnoremap <leader>sor vi{:sor<cr><c-o>
vim.keymap.set('n', '<leader>sor', 'vi{:sor<cr><c-o>')

-- Shortcuts to edit or source my .vimrc file
vim.keymap.set('n', '<leader>vrc', ':edit $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>vrso', ':source $MYVIMRC<cr>')

-- Shortcuts to work with windows and buffers easier
vim.keymap.set('n', '<leader>bb', ':b#<cr>')
vim.keymap.set('n', '<leader>bd', ':ls<cr>:bd ')

-- Shortcut command to clear all buffers except the current one.
vim.api.nvim_create_user_command('BufOnly', 'silent! execute "%bd|e#|bd#"', {})
vim.cmd.cnoreabbrev('bo', 'BufOnly')

-- Turn off search highlighting
vim.keymap.set('n', '<leader>h', ':noh<cr>')

-- Shortcuts to netrw explorer
vim.keymap.set('n', '<leader>./', ':Ex<cr>')
vim.keymap.set('n', '<leader>../', ':Ex ../<cr>')

-- Resizing buffer splits
vim.keymap.set('n', '+', ':horizontal resize +2<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '_', ':horizontal resize -2<cr>', { noremap = true, silent = true })

-- fzf-vim command mappings
-- Entrypoints to open up new files, commits, buffers via filename/keywords
vim.keymap.set('n', '<leader>B', ':BCommits<cr>')
vim.keymap.set('n', '<leader>C', ':Commits<cr>')
vim.keymap.set('n', '<leader>H', ':History<cr>')
vim.keymap.set('n', '<leader>?', ':GFiles?<cr>')
vim.keymap.set('n', '<c-p>', ':Files<cr>')
vim.keymap.set('n', '<c-t>', ':Buffers<cr>')

-- Create shortcut command to perform a custom :Rg search based on input.
vim.api.nvim_create_user_command('RgSearch', function()
  local query = vim.fn.input('Enter Rg pattern: ')
  if query ~= "" then
    vim.cmd('Rg ' .. query)
  end
end, {
  desc = 'Perform a custom Rg search based on user input',
  nargs = 0,
})
vim.keymap.set('n', '<c-\\>', ':RgSearch<cr>')

-- Open up fuzzy search one directory above to fuzzy search in an adjacent path
vim.keymap.set('n', '<leader><c-p>', ':FZF ../')

-- Navigate split windows easily
vim.keymap.set('n', '<c-l>', '<c-w><c-l>')
vim.keymap.set('n', '<c-h>', '<c-w><c-h>')
vim.keymap.set('n', '<c-k>', '<c-w><c-k>')
vim.keymap.set('n', '<c-j>', '<c-w><c-j>')

-- Create shortcut command to toggle between relative number and line number
vim.api.nvim_create_user_command('ToggleNumber', function()
  if not vim.wo.relativenumber and not vim.wo.number then
    vim.wo.number = true
  elseif not vim.wo.relativenumber then
    vim.wo.relativenumber = true
  else
    vim.wo.relativenumber = false
  end
end, {
  desc = 'Toggle between relative number and line number',
  nargs = 0,
})
vim.keymap.set('n', '<c-n>', ':ToggleNumber<cr>', { noremap = true, silent = true })

-- Count number of matches for the word under the cursor
vim.keymap.set('n', ',*', '*<c-o>:%s///gn<cr>')


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

-- Formatting selected code.
-- vim.keymap.set('x', '<leader>f', '<Plug>(coc-format-selected)', { desc = 'Format selected' })
-- vim.keymap.set('n', '<leader>f', '<Plug>(coc-format-selected)', { desc = 'Format selected' })

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
-- nnoremap <silent><nowait> <space>d :<C-u>CocList diagnostics<cr>
vim.keymap.set('n', '<space>d', '<Cmd>CocList diagnostics<CR>', { silent = true, nowait = true })
-- Manage extensions.
vim.keymap.set('n', '<space>e', '<Cmd>CocList extensions<CR>', { silent = true, nowait = true })
-- Show commands.
vim.keymap.set('n', '<space>c', '<Cmd>CocList commands<CR>', { silent = true, nowait = true, })
-- Find symbol of current document.
vim.keymap.set('n', '<space>o', '<Cmd>CocList outline<CR>', { silent = true, nowait = true, })
-- Search workspace symbols
vim.keymap.set('n', '<space>s', '<Cmd>CocList -I symbols<CR>', { silent = true })

-----------------
-- CodeCompanion
-----------------
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
