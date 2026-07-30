local utils = require("serpy.utils")

local M = {}

M.name = "lua"

function M.available()
	return true
end

function M.cmd()
	return "luafile"
end

function M.validate()
	local path = utils.getOpenFilePath()

	if path == "" then
		return nil, "No file saved"
	end

	if not path:match("%.lua$") then
		return nil, "Not a Lua file"
	end

	return path
end

function M.run()
	local path, err = M.validate()

	if not path then
		return false, err
	end

	local cmd = M.cmd() .. " %"

	vim.cmd(cmd)

	return true
end

function M.docs() end

return M
