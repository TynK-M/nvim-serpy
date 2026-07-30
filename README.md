# nvim-serpy

A minimal Neovim plugin for running and interacting with code from multiple programming languages via a pluggable execution system.

______________________________________________________________________

## Languages

serpy supports the following languages with the relative features:

- `python`: run current file with or without flags, pydoc search and pydoc current word
- `lua`: run current file
- `zig`: build run current folder

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
    zig = { enabled = true },
  },

  keymaps = {
    enabled = true,

    pyrun_current = "<leader>pc", -- Change to the preffered key
    pyrun_current_with_flags = "<leader>pf", -- Change to the preffered key
    pydoc = "<leader>pd", -- Change to the preffered key
    pydoc_current_word = "<leader>pw", -- Change to the preffered key

    luarun_current = "<leader>lc", -- Change to the preffered key

    zigbuildrun = "<leader>zbr", -- Change to the preferred key
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
