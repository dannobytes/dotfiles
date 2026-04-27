-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

----------------------
-- Settable options
----------------------
vim.opt.autoindent = true
vim.opt.autoread = true -- display file changes immediately
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.backspace = { 'indent', 'eol', 'start' } -- allow backspacing over everything
vim.opt.backup = false -- CoC: Some LSPs have issues with backups.
vim.opt.clipboard = 'unnamed'
vim.opt.colorcolumn = '80'
vim.opt.conceallevel = 0
vim.opt.copyindent = true
vim.opt.cursorline = true -- Enable cursor line highlight
vim.opt.diffopt = 'vertical' -- gdiff in vertical splits
vim.opt.encoding = 'utf-8'
vim.opt.expandtab = true
vim.opt.formatoptions:append('wj')
vim.opt.hidden = true -- Allow dirty buffers
vim.opt.history = 500
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.isfname:append('@-@') -- Always include `@` char in file names
vim.opt.laststatus = 2 -- Always show status line
vim.opt.list = true
vim.opt.listchars = { tab = '»·', trail = '·', nbsp = '·' }
vim.opt.mouse = 'a' -- Enable mouse support
vim.opt.number = true
vim.opt.relativenumber = true -- start with relative line numbers
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append('c') -- CoC: No messages to |ins-completion-menu|.
vim.opt.showcmd = true -- show the current command
vim.opt.showmode = false
vim.opt.signcolumn = 'auto'
vim.opt.smartcase = true
vim.opt.splitbelow = true -- put new split window below current
vim.opt.splitright = true -- put new split window to the right
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.textwidth = 80
vim.opt.title = true -- set the title to the value of 'titlestring'
vim.opt.undofile = true -- Persistent undo, even after closing vim
vim.opt.updatetime = 300
vim.opt.visualbell = true -- Set visual bell instead of a 'BEEP'
vim.opt.wrap = true -- wrap lines longer than the window width
vim.opt.writebackup = false -- CoC: Some LSPs have issues with backups.

-- Enables 24-bit RGB color in the TUI only when tmux is detected.
-- Otherwise, it is disabled since native mac terminal does not support it.
local term = os.getenv('TERM')
if term and string.find(term, 'tmux') then
  vim.opt.termguicolors = true
else
  vim.opt.termguicolors = false
end

-- Suppress LSP server crash prompts (e.g. vtsls)
local orig_show_message_request = vim.lsp.handlers['window/showMessageRequest']
vim.lsp.handlers['window/showMessageRequest'] = function(err, result, ctx, config)
  if result and result.message and result.message:match('crashed') then
    return vim.NIL
  end
  return orig_show_message_request(err, result, ctx, config)
end
