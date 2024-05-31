return {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        vim.keymap.set("n", "<leader>pv", "<cmd>Oil<CR>", { desc = "Open Explorer" })
        require("oil").setup()
    end
}
