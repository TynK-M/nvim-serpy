local M = {}

M.defaults = {
	keymaps = {
		enabled = true,

		pyrun_current = "<leader>pc",
	},
}

M.options = {}

function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})

	return M.options
end

return M
