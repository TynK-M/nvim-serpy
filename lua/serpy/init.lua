local config = require("serpy.config")
local utils = require("serpy.utils")

local M = {}

M.options = {}

function M.setup(opts)
	M.options = config.setup(opts)

	require("serpy.keymaps").setup(M.options)
end

function M.runPyFile()
	vim.cmd("write")

	local py = utils.getPythonCmd()
	local path = utils.getOpenFilePath()

	vim.cmd("botright 15split")
	vim.cmd("terminal " .. py .. " " .. vim.fn.shellescape(path))
	vim.cmd("startinsert")
end

return M
