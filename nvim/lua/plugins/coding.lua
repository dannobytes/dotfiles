return {
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        lazy = false,
        opts = {
            terminal = {
                -- no UI actions; server + tools remain available
                provider = "none",
            },
        },
        keys = {
            -- { "<leader>a",  nil,                              desc = "AI/Claude Code" },
            -- { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
            -- { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
            -- { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
            -- { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        desc = "Send to Claude",     mode = "v", },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
            },
            -- Diff management
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
        },
    },

    {
        'olimorris/codecompanion.nvim',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-treesitter/nvim-treesitter' },
        },
        keys = {
            { "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
            -- { "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle CodeCompanion Chat" },
            -- { "ga",    "<cmd>CodeCompanionChat Add<cr>", mode = "v",          desc = "Add to CodeCompanion Chat" },
        },
        opts = {
            adapters = {
                http = {
                    anthropic = function()
                        return require("codecompanion.adapters").extend("anthropic", {
                            env = {
                                api_key = "cmd:op read 'op://Private/Anthropic/api key' --no-newline",
                            },
                            schema = {
                                extended_thinking = {
                                    default = true,
                                },
                                model = {
                                    default = "claude-sonnet-4-20250514",
                                },
                            },
                        })
                    end,
                }
            },
            display = {
                chat = {
                    start_in_insert_mode = false, -- Open the chat buffer in insert mode?
                },
            },
            strategies = {
                chat = {
                    adapter = "anthropic",
                    keymaps = {
                        send = {
                            modes = {
                                i = { "<C-cr>", "<C-s>" },
                            },
                        },
                        close = {
                            modes = { n = "<C-c>", i = "<C-c>" },
                            opts = {},
                        },
                    },
                    opts = {
                        completion_provider = "coc", -- blink|cmp|coc|default
                    },
                    slash_commands = {
                        ["buffer"] = {
                            keymaps = {
                                modes = {
                                    -- i = "<C-t>",
                                    n = { "<C-t>" },
                                },
                            },
                        },
                        ["file"] = {
                            keymaps = {
                                modes = {
                                    -- i = "<C-p>",
                                    n = { "<C-p>" },
                                },
                            },
                        },
                    },
                },
                inline = {
                    adapter = "anthropic",
                },
            },
        }
    },
}
