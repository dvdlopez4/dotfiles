return {
    'zane-/cder.nvim',
    config = function()
        require('telescope').setup({
            extensions = {
                cder = {
                    previewer_command =
                        'exa ' ..
                        '-a ' ..
                        '--color=always ' ..
                        '-T ' ..
                        '--level=3 ' ..
                        '--icons ' ..
                        '--long ' ..
                        '--no-permissions ' ..
                        '--no-user ' ..
                        '--no-filesize ' ..
                        '--ignore-glob=\".git|node_modules|cdk.out\"',
                    dir_command = {
                        'fdfind',
                        '--type=d',
                        '-E',
                        '{node_modules,GAIT}',
                        '.',
                        os.getenv('PROJ_DIR')
                    },
                    pager_command = 'batcat --plain --paging=always --pager="less -RS"',
                    mappings = {
                        default = function(directory)
                            vim.cmd.cd(directory)
                        end,
                        ['<CR>'] = function(directory)
                            vim.cmd.lcd(directory)
                            vim.cmd("e " .. directory)
                        end,
                    },
                },
            },
        })
    end,
    keys = {
        { "<leader>pp", "<cmd>Telescope cder<CR>", desc = "Open projects" }
    }
}
