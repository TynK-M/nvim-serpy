local M = {}

local prefix = "serpy: "

---Display an error notification.
---
---@param msg string Error message to display.
function M.error(msg)
	vim.notify(prefix .. msg, vim.log.levels.ERROR)
end

return M
