return {
    "tpope/vim-dadbod",
    dependencies = {
        "kristijanhusak/vim-dadbod-ui",
        "kristijanhusak/vim-dadbod-completion"
    },
    config = function()
        vim.keymap.set("n", "<leader>db", function()
            vim.cmd('DBUIToggle')
        end, { desc = "Open database UI" })

        vim.g.db_ui_save_location = "~/.config/nvim/db_ui"
    end
}
