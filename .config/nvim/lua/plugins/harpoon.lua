return {
    'theprimeagen/harpoon',
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file)
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

        vim.keymap.set("n", "<leader><C-j>", function() ui.nav_file(1) end, { desc = "Harpoon file 1" })
        vim.keymap.set("n", "<leader><C-k>", function() ui.nav_file(2) end, { desc = "Harpoon file 2" })
        vim.keymap.set("n", "<leader><C-l>", function() ui.nav_file(3) end, { desc = "Harpoon file 3" })
        vim.keymap.set("n", "<leader><C-;>", function() ui.nav_file(4) end, { desc = "Harpoon file 4" })
    end
}
