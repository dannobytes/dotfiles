-- Shortcut to sort all lines within the current curly block
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
