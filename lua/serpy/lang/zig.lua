local utils = require("serpy.utils")

local M = {}

M.name = "zig"

function M.available()
	return vim.fn.executable("zig") == 1
end

function M.cmd()
	if vim.fn.executable("zig") == 1 then
		return "zig"
	end
end

function M.validate()
	local path = utils.getOpenDirPath()
	local folder = vim.fn.fnamemodify(path, ":p:h")
	local build_zig = folder .. "/build.zig"

	if vim.fn.filereadable(build_zig) == 0 then
		return nil, "Not a Zig project, consider doing `zig init`"
	end

	return folder
end

function M.run(flags)
	local path, err = M.validate()
	if not path then
		return false, err
	end

	local cmd = M.cmd() .. " build run"

	if flags and flags ~= "" then
		cmd = cmd .. " " .. flags
	end

	utils.runTerm(cmd)
end

function M.docs() end

return M
