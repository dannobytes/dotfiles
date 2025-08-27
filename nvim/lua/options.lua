----------------------
-- Settable options
----------------------
vim.opt.autoindent = true
vim.opt.autoread = true -- display file changes immediately
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.backspace = { 'indent', 'eol', 'start' } -- allow backspacing over everything
vim.opt.clipboard = 'unnamed'
vim.opt.colorcolumn = '80'
vim.opt.conceallevel = 0
vim.opt.copyindent = true
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
vim.opt.laststatus = 2        -- Always show status line
vim.opt.lazyredraw = true     -- Disable redraw during actions
vim.opt.list = true
vim.opt.listchars = { tab = '»·', trail = '·', nbsp = '·' }
vim.opt.mouse = 'a'         -- Enable mouse support
vim.opt.backup = false      -- CoC: Some LSPs have issues with backups.
vim.opt.writebackup = false -- CoC: Some LSPs have issues with backups.
vim.opt.cursorline = false  -- Prevent cursor line highlight
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true -- start with relative line numbers
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append('c') -- CoC: No messages to |ins-completion-menu|.
vim.opt.showcmd = true        -- show the current command
vim.opt.signcolumn = 'auto'
vim.opt.smartcase = true
vim.opt.splitbelow = true -- put new split window below current
vim.opt.splitright = true -- put new split window to the right
vim.opt.tabstop = 2
vim.opt.textwidth = 80
vim.opt.title = true      -- set the title to the value of 'titlestring'
vim.opt.undofile = true   -- Persistent undo, even after closing vim
vim.opt.updatetime = 300
vim.opt.visualbell = true -- Set visual bell instead of a 'BEEP'
vim.opt.wrap = true       -- wrap lines longer than the window width
