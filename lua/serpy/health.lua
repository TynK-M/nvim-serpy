local start = vim.health.start or vim.health.report_start
local ok = vim.health.ok or vim.health.report_ok
local warn = vim.health.warn or vim.health.report_warn
local error = vim.health.error or vim.health.report_error

local registry = require("serpy.registry")

local M = {}

local function check_neovim_version()
	if vim.fn.has("nvim-0.12.0") ~= 1 then
		error("serpy requires Neovim >= 0.12.0")
		return false
	end

	ok("Neovim >= 0.12.0")
	return true
end

local function check_serpy_module()
	local ok_load, serpy = pcall(require, "serpy")

	if ok_load then
		ok("serpy module is loadable")
		return true
	end

	error("serpy module failed to load: " .. serpy)
	return false
end

local function check_languages()
	local langs = registry.all()

	if vim.tbl_isempty(langs) then
		warn("No languages laoded (check config)")
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
