local M = {}

---@class SerpyLanguageConfig
---@field enabled boolean Wheter the language support is enabled.

---@class SerpyKeymapsConfig
---@field enabled boolean Wheter Serpy keymaps are enabled.
---@field pyrun_current? string Keymap for running the current Python file.
---@field pyrun_current_with_flags? string Keymap for running the current
---Python file with flags.
---@field pydoc? string Keymap for searching Python documentation.
---@field pydoc_current_word? string Keymap for searching the current word in
---Python documentation.
---@field luarun_current? string Keymap for running the current Lua file.
---@field zigbuildrun? string Keymap for building and running the current Zig
---project.

---@class SerpyConfig
---@field languages table<string, SerpyLanguageConfig> Language specific
---configuration.
---@field keymaps SerpyKeymapsConfig Keymap configuration.

---@type SerpyConfig
M.defaults = {
	languages = {
		python = { enabled = true },
		lua = { enabled = true },
		zig = { enabled = true },
	},

	keymaps = {
		enabled = false,
	},
}

---@type SerpyConfig
M.options = vim.deepcopy(M.defaults)

---Setup Serpy configuration.
---
---User provided options are deeply merged with the default configuration.
---
---@param opts? SerpyConfig User configuration.
---@return SerpyConfig options The resulting configuration.
function M.setup(opts)
	M.options = vim.tbl_deep_extend("force", M.defaults, opts or {})

	return M.options
end

return M
