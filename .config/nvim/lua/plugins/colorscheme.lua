return {
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup {
                custom_highlights = function(colors)
                    return {
                        NormalMoody = { fg = colors.blue },
                        InsertMoody = { fg = colors.green },
                        VisualMoody = { fg = colors.pink },
                        CommandMoody = { fg = colors.maroon },
                        ReplaceMoody = { fg = colors.red },
                        SelectMoody = { fg = colors.pink },
                        TerminalMoody = { fg = colors.mauve },
                        TerminalNormalMoody = { fg = colors.mauve },
                    }
                end
            }
            -- load the colorscheme here
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
    }
}
