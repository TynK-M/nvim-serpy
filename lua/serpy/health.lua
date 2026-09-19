local start = vim.health.start or vim.health.report_start
local ok = vim.health.ok or vim.health.report_ok
local warn = vim.health.warn or vim.health.report_warn
local error = vim.health.error or vim.health.report_error

local registry = require("serpy.registry")

local M = {}

---Check whether the running Neovim version is supported.
---
---@return boolean supported Wheter the current Neovim version is supported.
local function check_neovim_version()
	if vim.fn.has("nvim-0.12.0") ~= 1 then
		error("serpy requires Neovim >= 0.12.0")
		return false
	end

	ok("Neovim >= 0.12.0")
	return true
end

---Check whether the main Serpy module can be loaded.
---
---@return boolean loadable Wheter the Serpy module loaded successfully.
local function check_serpy_module()
	local ok_load, serpy = pcall(require, "serpy")

	if ok_load then
		ok("serpy module is loadable")
		return true
	end

	error("serpy module failed to load: " .. serpy)
	return false
end

---Check whether registered languages are available.
---
---Each registered language may optionally provide an `available` function
---that checks whether its dependencies are installed.
---
---@return boolean available Whether at least one language is registered.
local function check_languages()
	local langs = registry.all()

	if vim.tbl_isempty(langs) then
		warn("No languages loaded (check config)")
		return false
	end

	for name, lang in pairs(langs) do
		if lang.available then
			local ok_lang, err = pcall(lang.available)

			if ok_lang and err then
				ok(name .. "available")
			else
				warn(name .. " not available (missing dependency)")
			end
		else
			ok(name .. " loaded")
		end
	end

	return true
end

---Run Serpy health checks.
---
---This function is called by `:checkhealth serpy`.
function M.check()
	start("serpy")

	if not check_neovim_version() then
		return
	end

	if not check_serpy_module() then
		return
	end

	check_languages()

	ok("serpy is ready to use")
end

return M
