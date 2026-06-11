local M = {}

function M.getCurrentWord()
	return vim.fn.expand("<cword>") or ""
end

function M.getPythonCmd()
	if vim.fn.executable("python3") == 1 then
		return "python3"
	elseif vim.fn.executable("python") == 1 then
		return "python"
	elseif vim.fn.executable("py") == 1 then
		return "py"
	else
		return "python3"
	end
end

function M.getOpenFilePath()
	return vim.fn.expand("%")
end

function M.isPythonFile(path)
	return path:match("%.py") ~= nil
end

function M.validatePythonFile()
	local py = M.getPythonCmd()
	local path = M.getOpenFilePath()

	if not path or path == "" then
		return nil, "Current buffer has no file name. Please save it first"
	end

	if not M.isPythonFile(path) then
		return nil, "The current file is not a Python file"
	end

	return py, path
end

return M
