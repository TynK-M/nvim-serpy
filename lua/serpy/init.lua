local config = require("serpy.config")
local registry = require("serpy.registry")
local logger = require("serpy.logger")

local M = {}

M.options = {}

function M.setup(opts)
	M.options = config.setup(opts)
	registry.load(M.options)

	require("serpy.keymaps").setup(M.options)
end

function M.run(lang, ...)
	local mod = registry.get(lang)
	if not mod then
		logger.error("Language not available: " .. lang)
		return
	end

	local ok, err = mod.run(...)

	if ok == false and err then
		logger.error(err)
	end
end

function M.docs(lang, ...)
	local mod = registry.get(lang)
	if not mod then
		logger.error("Language not available: " .. lang)
		return
	end

	local ok, err = mod.docs(...)

	if ok == false and err then
		logger.error(err)
	end
end

return M
