return {
    'nvim-lualine/lualine.nvim',
    lazy = false,

    dependencies = {
        "folke/noice.nvim",
    },
    config = function()
        local clients_lsp = function()
            local bufnr = vim.api.nvim_get_current_buf()

            local clients = vim.lsp.buf_get_clients(bufnr)
            if next(clients) == nil then
                return ''
            end

            local c = {}
            for _, client in pairs(clients) do
                table.insert(c, client.name)
            end
            return '\u{f085} ' .. table.concat(c, '|')
        end

        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename', function() return 'Bufnr: ' .. vim.fn.bufnr() end,

                    {
                        function()
                            local status = require("noice").api.statusline.mode.get()
                            if string.find(status, 'recording') then
                                return status
                            else
                                return ''
                            end
                        end,
                        cond = require("noice").api.statusline.mode.has,
                        color = { fg = "#ff9e64" },
                    }
                },
                lualine_x = { 'encoding', 'fileformat', 'filetype', clients_lsp },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }
    end
}
