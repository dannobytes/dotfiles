return {
    {
        'ibhagwan/fzf-lua',
        -- keys = {
        --     { "<leader>ff",    "<cmd>FzfLua<cr>",                       desc = "Commands" },
        --     { "<leader>fk",    "<cmd>FzfLua keymaps<cr>",               desc = "Keymaps" },
        --     { "<leader>fh",    "<cmd>FzfLua history<cr>",               desc = "History" },
        --     { "<leader>fm",    "<cmd>FzfLua marks<cr>",                 desc = "Marks" },
        --
        --     { "<c-p>",         "<cmd>FzfLua files<cr>",                 desc = "Find files" },
        --     { "<leader><c-p>", "<cmd>FzfLua oldfiles<cr>",              desc = "Recent files" },
        --     { "<c-t>",         "<cmd>FzfLua buffers<cr>",               desc = "Find buffers" },
        --
        --     { "<c-\\>",        "<cmd>FzfLua live_grep resume=true<cr>", desc = "Live grep" },
        --     { "\\\\",          "<cmd>FzfLua grep_cword<cr>",            desc = "Grep word under cursor" },
        --     { "<leader>fs",    "<cmd>FzfLua grep_string<cr>",           desc = "Grep string under cursor" },
        --     { "<leader>f/",    "<cmd>FzfLua search_history<cr>",        desc = "Search history" },
        --
        --     { "<leader>gb",    "<cmd>FzfLua git_bcommits<cr>",          desc = "Git buffer commits" },
        --     { "<leader>gc",    "<cmd>FzfLua git_commits<cr>",           desc = "Git commits" },
        --     { "<leader>gl",    "<cmd>FzfLua git_blame<cr>",             desc = "Git blame" },
        --     { "<leader>gs",    "<cmd>FzfLua git_status<cr>",            desc = "Git status" },
        -- },
        config = function()
            local FzfLua = require("fzf-lua").setup({
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
                    height     = 0.85, -- window height
                    width      = 0.90, -- window width
                    row        = 0.40, -- window row position (0=top, 1=bottom)
                    col        = 0.50, -- window col position (0=left, 1=right)
                    -- border argument passthrough to nvim_open_win()
                    border     = "rounded",
                    -- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
                    backdrop   = 60,
                    fullscreen = false, -- start fullscreen?
                    -- enable treesitter highlighting for the main fzf window will only have
                    -- effect where grep like results are present, i.e. "file:line:col:text"
                    -- due to highlight color collisions will also override `fzf_colors`
                    -- set `fzf_colors=false` or `fzf_colors.hl=...` to override
                    treesitter = {
                        enabled = true,
                    },
                    preview    = {
                        -- default      = 'bat',     -- override the default previewer?
                        border       = "rounded", -- preview border: accepts both `nvim_open_win`
                        -- and fzf values (e.g. "border-top", "none")
                        -- native fzf previewers (bat/cat/git/etc)
                        -- can also be set to `fun(winopts, metadata)`
                        wrap         = false,       -- preview line wrap (fzf's 'wrap|nowrap')
                        hidden       = false,       -- start preview hidden
                        vertical     = "down:45%",  -- up|down:size
                        horizontal   = "right:55%", -- right|left:size
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
                        true, -- uncomment to inherit all the below in your custom config
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
                -- Set to `true` to automatically generate an fzf's colorscheme from
                -- Neovim's current colorscheme:
                fzf_colors = true,
                actions = {
                    -- Below are the default actions, setting any value in these tables will override
                    -- the defaults, to inherit from the defaults change [1] from `false` to `true`
                    files = {
                        true, -- uncomment to inherit all the below in your custom config
                        -- Pickers inheriting these actions:
                        --   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
                        --   tags, btags, args, buffers, tabs, lines, blines
                        -- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
                        -- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
                        -- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
                        ["enter"] = FzfLua.actions.file_edit,
                        -- ["ctrl-s"] = FzfLua.actions.file_split,
                        -- ["ctrl-v"] = FzfLua.actions.file_vsplit,
                        -- ["ctrl-t"] = FzfLua.actions.file_tabedit,
                        -- ["alt-q"]  = FzfLua.actions.file_sel_to_qf,
                        -- ["alt-Q"]  = FzfLua.actions.file_sel_to_ll,
                        -- ["alt-i"]  = FzfLua.actions.toggle_ignore,
                        -- ["alt-h"]  = FzfLua.actions.toggle_hidden,
                        -- ["alt-f"]  = FzfLua.actions.toggle_follow,
                    },
                },
            })
        end,
    },

    {
        'junegunn/fzf',
        dependencies = {
            'junegunn/fzf.vim',
        },
        keys = {
            { "<leader>gc", "<cmd>Commits<cr>",  desc = "Git commits" },
            { "<leader>gb", "<cmd>BCommits<cr>", desc = "Git buffer commits" },
        },
    }
}
