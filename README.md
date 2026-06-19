# nvim-serpy

A minimal Neovim plugin for running and interacting with code from multiple programming languages via a pluggable execution system.

______________________________________________________________________

## Languages

serpy supports the following languages:

- `python`
- `lua`

______________________________________________________________________

## Features

- Run the current file based on detected/selected language
- Extensible module system for adding new languages
- Automatically saves buffer before execution
- Opens terminal split for program output
- Fully customizable keymaps and languages

______________________________________________________________________

## Requirements

- Neovim >= 0.12.0
- Desired language runtime(s) (`python`, `lua`, etc.)

______________________________________________________________________

## Installation

### lazy.nvim

```lua
{
  "TynK-M/nvim-serpy",

  config = function()
    require("serpy").setup({
      languages = {
        python = { enabled = true },
      },
    })
  end,
}
```

______________________________________________________________________

## Usage

By default serpy adds:

| Keymap | Action |
| ------------ | ----------------------- |
| `<leader>pc` | Run current Python file |
| `<leader>pf` | Run current Python file with flags |
| `<leader>ph` | Search a term in pydoc |
| `<leader>pw` | Search current word in pydoc |
|`<leader>lc`| Run current Lua file|

______________________________________________________________________

## How it works

serpy uses a language registry system:

1. Detects enabled languages from config
1. Loads matching language modules (e.g. `lang/python.lua`)
1. Validates required executables are available in PATH
1. Delegates execution to the selected language module

______________________________________________________________________

## Configuration

```lua
require("serpy").setup({
  languages = {
    python = { enabled = true },
    lua = { enabled = true },
  },

  keymaps = {
    enabled = true,

    pyrun_current = "<leader>pc",
    pyrun_current_with_flags = "<leader>pf"
    pydoc = "<leader>pd",
    pydoc_current_word = "<leader>pw",

    luarun_current = "<leader>lc",
  },
})
```

______________________________________________________________________

## Architecture

serpy is build around a modular system:

- `registry.lua`: loads and manages language modules
- `lang/*.lua`: language-specific implementations

This design allows new languages to be added by simply dropping a module into the lang folder

______________________________________________________________________

## License

serpy is licensed under [MIT License](LICENSE)
