-- Lua config for lazy.nvim to install GitHub Copilot

return {
	{
		"github/copilot.vim",
		config = function()
			-- Enable Copilot
			vim.cmd("Copilot enable")

			-- Disable default Tab mapping
			vim.g.copilot_no_tab_map = true

			-- Custom key mapping to accept Copilot suggestion
			vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { expr = true, silent = true })

			-- Disable Copilot for specific filetypes
			vim.g.copilot_filetypes = {
				markdown = false,
				text = false,
			}
		end,
	},
}
