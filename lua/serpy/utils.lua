local M = {}

---Get the word under the cursor.
---
---@return string word The word under the cursor, or an empty string.
function M.getCurrentWord()
	return vim.fn.expand("<cword>") or ""
end

---Get the directory of the currently opened file.
---
---@return string path Directory containing the current file.
function M.getOpenDirPath()
	return vim.fn.expand("%:h")
end

---Get the path of the currently opened file.
---
---@return string path Path of the current buffer's file.
function M.getOpenFilePath()
	return vim.fn.expand("%")
end

---Check whether the current buffer has an associated file.
---
---@return boolean exists Whether the current buffer has a file path.
function M.fileExists()
	local path = M.getOpenFilePath()
	return path ~= ""
end

---Open a terminal split and run a command.
---
---The terminal is opened in a 15-line bottom splits and enters insert mode
---automatically.
---
---@param cmd string Command to execute in the terminal.
function M.runTerm(cmd)
	vim.cmd("botright 15split")
	vim.cmd("terminal " .. cmd)
	vim.cmd("startinsert")
end

return M
