local M = {}

---@class SerpyLanguage
---@field name string Unique language identifier.
---@field available? fun(): boolean Whether the language dependencies are
---available.
---@field run fun(...): boolean?, string? Run the language-specific action.
---@field docs fun(...): boolean?, string? Show language-specific
---documentation.

---@type table<string, SerpyLanguage>
local langs = {}

---Register a language module.
---
---The language is stored using its `name` field as the registry key.
---
---@param lang SerpyLanguage Language module to register.
function M.register(lang)
	langs[lang.name] = lang
end

---Get a registered language module.
---
---@param name string Language identifier.
---@return SerpyLanguage? lang The registered language, or `nil` if
---unavailable.
function M.get(name)
	return langs[name]
end

---Get all registered language modules.
---
---@return table<string, SerpyLanguage> languages Registered language modules.
function M.all()
	return langs
end

---Load enabled language modules from the configuration.
---
---Only languages that are enabled and whose dependencies are available are
---registered.
---
---@param config SerpyConfig Serpy configuration.
function M.load(config)
	for name, opts in pairs(config.languages or {}) do
		if opts.enabled then
			local ok, mod = pcall(require, "serpy.lang." .. name)

			if ok and mod and (not mod.available or mod.available()) then
				M.register(mod)
			end
		end
	end
end

return M
