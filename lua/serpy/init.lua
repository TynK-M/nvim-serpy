local config = require("serpy.config")
local registry = require("serpy.registry")
local logger = require("serpy.logger")

local M = {}

---@type SerpyConfig
M.options = {}

---Setup Serpy.
---
---Applies the provided configuration, loads the configured languages and
---initializes Serpy keymaps.
---
---@param opts? SerpyConfig User configuration.
function M.setup(opts)
	M.options = config.setup(opts)
	registry.load(M.options)

	require("serpy.keymaps").setup(M.options)
end

---Run a language-specific Serpy action.
---
---@param lang string Language identifier registered with Serpy.
---@param ... any Arguments passed to the language module's `run` function.
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

---Show documentation for a language.
---
---@param lang string Language identifier registered with Serpy.
---@param ... any Arguments passed to the language module's `docs` function.
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
