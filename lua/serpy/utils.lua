local M = {}

function M.getCurrentWord()
	return vim.fn.expand("<cword>") or ""
end

function M.getOpenFilePath()
	return vim.fn.expand("%")
end

function M.fileExists()
	local path = M.getOpenFilePath()
	return path ~= ""
end

function M.runTerm(cmd)
	vim.cmd("botright 15split")
	vim.cmd("terminal " .. cmd)
	vim.cmd("startinsert")
end

return M
