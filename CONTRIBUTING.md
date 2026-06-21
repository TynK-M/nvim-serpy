# Contributing

Thank you for your interest in contributing to serpy!

The goal of serpy is to remain small, modular, and easy to extend. Contributions are welcome, whether they are bug fixes, documentation improvements, new language modules, or quality-of-life enhancements.

______________________________________________________________________

## What Contributions Are Most Helpful?

- New language modules
- Documentation improvements
- Bug fixes
- Health check improvements
- Better error messages

______________________________________________________________________

## Getting Started

1. Fork the repository
1. Create a feature branch
1. Make your changes
1. Test your changes in Neovim
1. Open a Pull Request

______________________________________________________________________

## Project structure

```text
.
└─── lua
    └── serpy
        ├── config.lua
        ├── health.lua
        ├── init.lua
        ├── keymaps.lua
        ├── lang
        │   ├── *.lua
        │   └── *.lua
        ├── logger.lua
        ├── registry.lua
        └── utils.lua
```

The project structure is generated using the `tree` command.

______________________________________________________________________

### Core Components

- `registry.lua` loads and manages language modules
- `lang/*.lua` contains language-specific implementations

______________________________________________________________________

## Adding a New Language

Language support is implemented through modules located in:

lua/serpy/lang

Each language should be self-contained and responsible for:

- Validating required executables
- Running the current file
- Providing language-specific functionality

Example structure:

```lua
local utils = require("serpy.utils")

local M = {}

M.name = "<lang_name>"

function M.available()
	-- Logic to validate if the user has the exec
end

function M.cmd()
	-- Logic to return the string name of the exec
end

function M.validate()
	local path = utils.getOpenFilePath()

	if path == "" then
		return nil, "No file saved"
	end

	if not path:match("%.<lang_extension>$") then
		return nil, "Not a <lang> file"
	end

	return path
end

function M.run(flags)
	local path, err = M.validate()
	if not path then
		return false, err
	end

	local cmd = M.cmd() .. " " .. vim.fn.shellescape(path)

	if flags and flags ~= "" then
		cmd = cmd .. " " .. flags
	end

	utils.runTerm(cmd)
end

function M.docs(term)
	local cmd = -- Command to search in the docs
	utils.runTerm(cmd)
end

return M
```

______________________________________________________________________

## Coding Guidelines

### Keep Modules Independent

Language modules should avoid depending on implementation details of other language modules.

______________________________________________________________________

### Prefer Small Functions

Keep logic focused and easy to follow.

______________________________________________________________________

### Follow Existing Style

When possible, match the formatting and structure already used throughout the project.

______________________________________________________________________

### Avoid Unnecessary Dependencies

serpy aims to remain lightweight and rely only on Neovim and language runtimes.

______________________________________________________________________

### Documentation

If your contribution changes behavior, configuration, or user-facing features, please update the README accordingly.

Documentaton improvements are always welcome.

______________________________________________________________________

### Pull Requests

Before opening a pull request:

- Ensure the plugin loads correctly
- Ensure existing functionality still works
- Update documentation if needed
- Keep changes focused on a single feature or fix

______________________________________________________________________

## Questions

If you're unsure about a change, feel free to open an issue to discuss it before implementing it.

Thanks for helping improve serpy!
