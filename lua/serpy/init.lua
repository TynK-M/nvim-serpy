local config = require("serpy.config")
local utils = require("serpy.utils")
local logger = require("serpy.logger")

local M = {}

M.options = {}

function M.setup(opts)
	M.options = config.setup(opts)

	require("serpy.keymaps").setup(M.options)
end

function M.runPyFile()
	local py = utils.getPythonCmd()
	local path = utils.getOpenFilePath()

	if not path or path == "" then
		logger.error("Current buffer has no file name. Please save it first")
		return
	end

	if not utils.isPythonFile(path) then
		logger.error("The current file is not a Python file")
		return
	end

	vim.cmd("write")

	vim.cmd("botright 15split")
	vim.cmd("terminal " .. py .. " " .. vim.fn.shellescape(path))
	vim.cmd("startinsert")
end

return M
