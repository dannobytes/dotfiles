require("fzf-lua").setup {
  -- MISC GLOBAL SETUP OPTIONS, SEE BELOW
  -- fzf_bin = ...,
  -- each of these options can also be passed as function that return options table
  -- e.g. winopts = function() return { ... } end
  winopts = { -- UI Options
    -- split = "belowright new",-- open in a split instead?
    -- "belowright new"  : split below
    -- "aboveleft new"   : split above
    -- "belowright vnew" : split right
    -- "aboveleft vnew   : split left
    -- Only valid when using a float window
    -- (i.e. when 'split' is not defined, default)
    height     = 0.9,  -- window height
    width      = 0.9,  -- window width
    row        = 0.35, -- window row position (0=top, 1=bottom)
    col        = 0.50, -- window col position (0=left, 1=right)
    -- border argument passthrough to nvim_open_win()
    border     = "rounded",
    -- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
    backdrop   = 60,
    -- title         = "Title",
    -- title_pos     = "center",        -- 'left', 'center' or 'right'
    -- title_flags   = false,           -- uncomment to disable title flags
    fullscreen = false, -- start fullscreen?
    -- enable treesitter highlighting for the main fzf window will only have
    -- effect where grep like results are present, i.e. "file:line:col:text"
    -- due to highlight color collisions will also override `fzf_colors`
    -- set `fzf_colors=false` or `fzf_colors.hl=...` to override
    treesitter = {
      enabled    = true,
      fzf_colors = { ["hl"] = "-1:reverse", ["hl+"] = "-1:reverse" }
    },
    preview    = {
      -- default     = 'bat',           -- override the default previewer?
      -- default uses the 'builtin' previewer
      border       = "rounded", -- preview border: accepts both `nvim_open_win`
      -- and fzf values (e.g. "border-top", "none")
      -- native fzf previewers (bat/cat/git/etc)
      -- can also be set to `fun(winopts, metadata)`
      wrap         = false,       -- preview line wrap (fzf's 'wrap|nowrap')
      hidden       = false,       -- start preview hidden
      vertical     = "down:45%",  -- up|down:size
      horizontal   = "right:60%", -- right|left:size
      layout       = "flex",      -- horizontal|vertical|flex
      flip_columns = 100,         -- #cols to switch to horizontal on flex
      -- Only used with the builtin previewer:
      title        = true,        -- preview border title (file/buf)?
      title_pos    = "center",    -- left|center|right, title alignment
      scrollbar    = "float",     -- `false` or string:'float|border'
      -- float:  in-window floating border
      -- border: in-border "block" marker
      scrolloff    = -1, -- float scrollbar offset from right
      -- applies only when scrollbar = 'float'
      delay        = 20, -- delay(ms) displaying the preview
      -- prevents lag on fast scrolling
      winopts      = {   -- builtin previewer window options
        number         = true,
        relativenumber = false,
        cursorline     = true,
        cursorlineopt  = "both",
        cursorcolumn   = false,
        signcolumn     = "no",
        list           = false,
        foldenable     = false,
        foldmethod     = "manual",
      },
    },
    on_create  = function()
      -- called once upon creation of the fzf main window
      -- can be used to add custom fzf-lua mappings, e.g:
      --   vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
    end,
    -- called once _after_ the fzf interface is closed
    -- on_close = function() ... end
  },
  keymap = { -- Neovim keymaps / fzf binds
    -- Below are the default binds, setting any value in these tables will override
    -- the defaults, to inherit from the defaults change [1] from `false` to `true`
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      true,                    -- uncomment to inherit all the below in your custom config
      ["<M-Esc>"]    = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
      ["<F1>"]       = "toggle-help",
      ["<F2>"]       = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"]       = "toggle-preview-wrap",
      ["ctrl-\\"]    = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"]       = "toggle-preview-ccw",
      ["<F6>"]       = "toggle-preview-cw",
      -- `ts-ctx` binds require `nvim-treesitter-context`
      ["<F7>"]       = "toggle-preview-ts-ctx",
      ["<F8>"]       = "preview-ts-ctx-dec",
      ["<F9>"]       = "preview-ts-ctx-inc",
      ["<S-Left>"]   = "preview-reset",
      ["<S-down>"]   = "preview-page-down",
      ["<S-up>"]     = "preview-page-up",
      ["<M-S-down>"] = "preview-down",
      ["<M-S-up>"]   = "preview-up",
    },
    fzf = {
      -- fzf '--bind=' options
      -- true,        -- uncomment to inherit all the below in your custom config
      ["ctrl-z"]     = "abort",
      ["ctrl-u"]     = "unix-line-discard",
      ["ctrl-f"]     = "half-page-down",
      ["ctrl-b"]     = "half-page-up",
      ["ctrl-a"]     = "beginning-of-line",
      ["ctrl-e"]     = "end-of-line",
      ["alt-a"]      = "toggle-all",
      ["alt-g"]      = "first",
      ["alt-G"]      = "last",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"]         = "toggle-preview-wrap",
      ["ctrl-\\"]    = "toggle-preview",
      ["shift-down"] = "preview-page-down",
      ["shift-up"]   = "preview-page-up",
    },
  },
  -- actions = { ... },  -- Fzf "accept" binds
  -- fzf_opts = { ... }, -- Fzf CLI flags
  -- fzf_colors = { ...  },  -- Fzf `--color` specification
  -- hls = { ...  },         -- Highlights
  -- previewers = { ...  },  -- Previewers options
  -- SPECIFIC COMMAND/PICKER OPTIONS, SEE BELOW
  -- files = { ... },
}

-----------------
-- Key mappings
-----------------
vim.keymap.set('n', '<c-p>', ':FzfLua files<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<c-t>', ':FzfLua buffers<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gb', ':FzfLua git_bcommits<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gl', ':FzfLua git_blame<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gc', ':FzfLua git_commits<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gh', ':FzfLua oldfiles<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gs', ':FzfLua git_status<cr>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>@', ':FzfLua<cr>', { noremap = true, silent = true })

-- Create shortcut command to perform a custom :Rg search based on input.
vim.api.nvim_create_user_command('RgSearch', function()
  local query = vim.fn.input('Enter Rg pattern: ')
  if query ~= "" then
    vim.cmd('FzfLua grep ' .. query)
  end
end, {
  desc = 'Perform a custom Rg search based on user input',
  nargs = 0,
})
vim.keymap.set('n', '<c-\\>', ':FzfLua live_grep<cr>', { noremap = true, silent = true })

-- Open up fuzzy search one directory above to fuzzy search in an adjacent path
vim.keymap.set('n', '<leader><c-p>', ':FZF ../')
