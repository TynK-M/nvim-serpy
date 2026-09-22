local utils = require("serpy.utils")

local M = {}

---@type string
M.name = "zig"

---Check whether the Zig executable is available.
---
---@return boolean available Whether the `zig` executable is available.
function M.available()
	return vim.fn.executable("zig") == 1
end

---Get the Zig executable.
---
---@return string? command The Zig executable, or `nil` if unavailable.
function M.cmd()
	if vim.fn.executable("zig") == 1 then
		return "zig"
	end
end

---Validate the current buffer's directory as a Zig project.
---
---A directory is considered a Zig project when it contains a `build.zig` file.
---
---@return string? path Path to the Zig project directory.
---@return string? error Error message when validation fails.
function M.validate()
	local path = utils.getOpenDirPath()
	local folder = vim.fn.fnamemodify(path, ":p:h")
	local build_zig = folder .. "/build.zig"

	if vim.fn.filereadable(build_zig) == 0 then
		return nil, "Not a Zig project, consider doing `zig init`"
	end

	return folder
end

---Build and run the current Zig project.
---
---The command is executed in a terminal split. Optional flags are appended to
---the Zig command.
---
---@param flags? string Command-line flags to pass to `zig build run`.
---@return boolean? success Whether execution was started successfully.
---@return string? error Error message when validation fails.
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

	return true
end

---Show Zig documentation.
---
---TODO: implement Zig documentation lookup.
---
---For now this can't be done as Zig doesn't expose a command to look in
---the documentation.
function M.docs() end

return M
