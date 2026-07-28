local M = {}

M.defaults = {
	languages = {
		python = { enabled = true },
		lua = { enabled = true },
	},

	keymaps = {
		enabled = false,
	},
}

M.options = {}

function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})

	return M.options
end

return M
