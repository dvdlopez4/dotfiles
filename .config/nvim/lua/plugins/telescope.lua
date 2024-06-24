return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'rbong/vim-flog',
        { "isak102/telescope-git-file-history.nvim", dependencies = { "tpope/vim-fugitive" } }
    },

    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>gH', '<cmd>Telescope git_file_history<CR>', { desc = 'Git file history' })

        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        vim.opt.foldenable = false

        local actions = require('telescope.actions')
        require("telescope").setup({
            pickers = {
                git_branches = {
                    previewer = require("telescope.previewers").new_termopen_previewer({
                        get_command = function(entry)
                            return {
                                "git",
                                "log",
                                "--graph", -- can be waaayy too expensive
                                "--pretty=format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset",
                                "--abbrev-commit",
                                "--date=relative",
                                entry.value,
                            }
                        end,
                    }),
                    mappings = {
                        i = { ["<cr>"] = actions.git_switch_branch },
                    }
                },
            },
        })
        require('telescope').load_extension('cder')
        require("telescope").load_extension("git_file_history")
    end
}
