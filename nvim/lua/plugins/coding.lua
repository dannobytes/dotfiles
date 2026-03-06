return {
    'olimorris/codecompanion.nvim',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-treesitter/nvim-treesitter' },
    },
    keys = {
        { "<C-a>",          "<cmd>CodeCompanionActions<cr>",     mode = { "n", "v" }, desc = "CodeCompanion Actions" },
        { "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle CodeCompanion Chat" },
        { "ga",             "<cmd>CodeCompanionChat Add<cr>",    mode = "v",          desc = "Add to CodeCompanion Chat" },
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
    ,
}
