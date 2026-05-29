local M = {}

function M.setup(opts)
	if not opts.keymaps.enabled then
		return
	end

	local map = vim.keymap.set
	local km = opts.keymaps

	map("n", km.pyrun_current, function()
		require("serpy").runPyFile()
	end, { desc = "serpy: run current file" })
end

return M
