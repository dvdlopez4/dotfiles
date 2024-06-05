return {
    {
        "tpope/vim-dadbod",
    },
    {
        "kristijanhusak/vim-dadbod-ui",
        dependencies = { "tpope/vim-dadbod" },
        config = function()
            vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
        end,
        keys = {
            { "<leader>db", ":tabe DBUIToggle<CR>", desc = "Open database UI" },
        }
    },
    {
        "kristijanhusak/vim-dadbod-completion",
        dependencies = { "tpope/vim-dadbod" },
        ft = { "sql", "mysql", "plsql" },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("kide_vim_dadbod_completion", { clear = true }),
                pattern = { "sql", "mysql", "plsql" },
                callback = function(_)
                    require("cmp").setup.buffer({
                        sources = {
                            { name = "vim-dadbod-completion" }
                        }
                    })
                end,
            })
        end
    }
}
