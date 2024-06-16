return {
    { 'github/copilot.vim' },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        dependencies = {
            { "github/copilot.vim" },    -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        opts = {
            -- See Configuration section for rest
        },
        keys = {
            {
                "<leader>cc", "<cmd>CopilotChatToggle<CR>", desc = "Start Copilot Chat Toggle"
            },
            {
                "<leader>ce", "<cmd>CopilotChatExplain<CR>", desc = "Start Copilot Explain this"
            },
        }
    }
}
