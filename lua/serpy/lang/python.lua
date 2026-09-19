local utils = require("serpy.utils")

local M = {}

---@type string
M.name = "python"

---Check whether a Python executable is available.
---
---Checks for `python3`, `python`, and `py` in that order.
---
---@return boolean available Whether a supported Python executable is
---available.
function M.available()
	return vim.fn.executable("python3") == 1 or vim.fn.executable("python") == 1 or vim.fn.executable("py") == 1
end

---Get the available Python executable.
---
---Executables are checked in the order `python3`, `python`, then `py`.
---
---@return string command Python executable to use.
function M.cmd()
	if vim.fn.executable("python3") == 1 then
		return "python3"
	elseif vim.fn.executable("python") == 1 then
		return "python"
	else
		return "py"
	end
end

---Validate the current buffer for Python execution.
---
---@return string? path Path to the current Python file.
---@return string? error Error message when validation fails.
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

---Run the current Python file.
---
---The file is executed in a terminal split. Optional flags are appended to
---the Python command.
---
---@param flags? string Command-line flags to pass to Python.
---@return boolean? success Whether execution was started successfully.
---@return string? error Error message when validation fails.
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

	return true
end

---Open Python documentation for a term.
---
---Uses Python's built-in `pydoc` module and displays the result in a terminal
---split.
---
---@param term string Documentation term to search for.
---@return boolean success Whether the documentation command was started.
function M.docs(term)
	local cmd = M.cmd() .. " -m pydoc " .. term

	utils.runTerm(cmd)

	return true
end

return M
