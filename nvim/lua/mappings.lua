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

-----------------
-- CodeCompanion
-----------------
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
