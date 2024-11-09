return {
    'nvimtools/none-ls.nvim',
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")

        -- register any number of sources simultaneously
        local sources = {
            null_ls.builtins.formatting.prettierd,
            require("none-ls.diagnostics.eslint_d").with({                                                -- js/ts linter
                condition = function(utils)
                    return utils.root_has_file({ ".eslintrc.json", ".eslintrc.js", ".eslintrc.cjs" })     -- only enable if root has .eslintrc.js or .eslintrc.cjs
                end,
            })
        }

        null_ls.setup({
            sources = sources,
        })
    end
}
