local utils = require("serpy.utils")

local M = {}

M.name = "python"

function M.available()
	return vim.fn.executable("python3") == 1 or vim.fn.executable("python") == 1 or vim.fn.executable("py") == 1
end

function M.cmd()
	if vim.fn.executable("python3") == 1 then
		return "python3"
	elseif vim.fn.executable("python") == 1 then
		return "python"
	else
		return "py"
	end
end

function M.validate()
	local path = utils.getOpenFilePath()

	if path == "" then
		return nil, "No file saved"
	end

	if not path:match("%.py$") then
		return nil, "Not a Python file"
	end

	return path
end

function M.run(flags)
	local path, err = M.validate()
	if not path then
		return false, err
	end

	local cmd = M.cmd() .. " " .. vim.fn.shellescape(path)

	if flags and flags ~= "" then
		cmd = cmd .. " " .. flags
	end

	utils.runTerm(cmd)
end

function M.docs(term)
	local cmd = M.cmd() .. " -m pydoc " .. term
	utils.runTerm(cmd)
end

return M
