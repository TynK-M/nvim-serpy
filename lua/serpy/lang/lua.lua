local utils = require("serpy.utils")

local M = {}

---@type string
M.name = "lua"

---Check whether Lua support is available.
---
---@return boolean available Always returns `true` because Lua support is
---provided by Neovim itself.
function M.available()
	return true
end

---Get the command used to execute a Lua file.
---
---@return string command Vim command used to run the current Lua file.
function M.cmd()
	return "luafile"
end

---Validate the current buffer for Lua execution.
---
---@return string? path Path to the current Lua file.
---@return string? error Error message when validation fails.
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

---Run the current Lua file.
---
---@return boolean success Whether the file was successfully executed.
---@return string? error Error message when validation fails.
function M.run()
	local path, err = M.validate()

	if not path then
		return false, err
	end

	local cmd = M.cmd() .. " %"

	vim.cmd(cmd)

	return true
end

---Open Lua documentation for a term.
---
---Uses Lua's Vim LSP command to display the documentation.
---
---@return boolean success Whether the documentation command was started.
function M.docs()
	vim.lsp.buf.hover()

	return true
end

return M
