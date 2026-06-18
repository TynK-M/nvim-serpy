local M = {}

local langs = {}

function M.register(lang)
	langs[lang.name] = lang
end

function M.get(name)
	return langs[name]
end

function M.all()
	return langs
end

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
