local M = {}

local prefix = "serpy: "

function M.error(msg)
	vim.notify(prefix .. msg, vim.log.levels.ERROR)
end

return M
