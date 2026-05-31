local M = {}

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

return M
