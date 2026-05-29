local M = {}
local utils = require("serpy.utils")

function M.runPyFile()
	local py = utils.getPythonCmd()
	local path = utils.getOpenFilePath()

	local cmd = string.format("split | terminal %s %q", py, path)

	vim.cmd(cmd)
end

return M
