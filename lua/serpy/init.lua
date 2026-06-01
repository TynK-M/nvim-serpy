local config = require("serpy.config")
local utils = require("serpy.utils")
local logger = require("serpy.logger")

local M = {}

M.options = {}

function M.setup(opts)
	M.options = config.setup(opts)

	require("serpy.keymaps").setup(M.options)
end

local function _runPython(path, py, flags)
	flags = flags or ""

	vim.cmd("write")

	vim.cmd("botright 15split")
	vim.cmd("terminal " .. py .. " " .. vim.fn.shellescape(path) .. " " .. flags)
	vim.cmd("startinsert")
end

function M.runPyFile()
	local py, path_or_err = utils.validatePythonFile()
	if not py then
		logger.error(path_or_err)
		return
	end

	_runPython(path_or_err, py)
end

function M.runPyFileWithFlags()
	local py, path_or_err = utils.validatePythonFile()
	if not py then
		logger.error(path_or_err)
		return
	end

	local flags = ""
	vim.ui.input({ prompt = "Flags: " }, function(input)
		if input then
			flags = input
		end
	end)

	_runPython(path_or_err, py, flags)
end

return M
