return {
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                on_attach                    = function(bufnr)
                    local gs = package.loaded.gitsigns

                    -- Actions
                    vim.keymap.set('n', '<leader>hp', gs.preview_hunk)
                    vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame)
                end
            }
        end
    },
    {
        'tpope/vim-fugitive',
        cmd = "Git",
        keys = {
            {
                "<leader>gm",
                "<cmd>Git checkout main<CR>",
                desc = "Checkout main"
            },

            {
                "<leader>gs",
                "<cmd>Git<CR>",
                desc = "Open fugitive"
            },
            { "<leader>gb", "<cmd>Telescope git_branches<CR>" },
            {
                "<leader>gB",
                "<cmd>Git blame<CR>",
                desc = "git blame"
            },
        },
        config = function()
            local my_fugitive_group = vim.api.nvim_create_augroup("my_fugitive_group", {})
            local autocmd = vim.api.nvim_create_autocmd
            autocmd("BufWinEnter", {
                group = my_fugitive_group,
                pattern = "*",
                callback = function()
                    if vim.bo.ft ~= "fugitive" then
                        return
                    end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local opts = { buffer = bufnr, remap = false }
                    vim.keymap.set("n", "<leader>p", function()
                        vim.cmd.Git('push')
                    end, opts, { desc = "push" })

                    -- rebase always
                    vim.keymap.set("n", "<leader>P", "<cmd>Git pull --rebase<CR>", opts)

                    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
                    -- needed if i did not set the branch up correctly
                    vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
                    vim.keymap.set("n", "<leader>b", ":Git checkout -b ", opts);
                end,
            })
            vim.keymap.set("n", "<leader>gh", "<cmd>diffget //2<CR>")
            vim.keymap.set("n", "<leader>gl", "<cmd>diffget //3<CR>")
        end
    },
    {
        'pwntester/octo.nvim',
        priority = 30,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            -- OR 'ibhagwan/fzf-lua',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require "octo".setup({
                suppress_missing_scope = {
                    projects_v2 = true,
                }
            })
        end,
        keys = {
            { "<leader>oc", "<cmd>Octo pr create<CR>", desc = "Octo create pull request" },
            { "<leader>op", "<cmd>Octo pr list<CR>", desc = "Octo list open pull requests" },
            { "<leader>oo", "<cmd>Octo pr reload<CR>", desc = "Octo reload pull request" },
            { "<leader>or", "<cmd>Octo review start<CR>", desc = "Octo start review" },
            { "<leader>os", "<cmd>Octo review submit<CR>", desc = "Octo submit review" },
        }
    },
    {
        "rbong/vim-flog",
        lazy = true,
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
        keys = {
            {
                "<leader>gg",
                "<cmd>Flog<CR>",
                desc = "Pretty git graph"
            }
        }
    },
}
