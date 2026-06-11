# nvim-serpy

A minimal Neovim plugin to quickly run the current Python file in a terminal split.

______________________________________________________________________

## Features

- Run the current Python buffer instantly
- Automatically saves file before execution
- Opens a terminal split in Neovim
- Lightweight and dependency-free
- Fully customizable keymaps

______________________________________________________________________

## Requirements

- Neovim >= 0.12.0
- Python installed (`python3`, `python` or `py` available in PATH)

______________________________________________________________________

## Installation

### lazy.nvim

```lua
{
  "TynK-M/nvim-serpy",

  config = function()
    require("serpy").setup()
  end,
}
```

______________________________________________________________________

## Usage

By default serpy adds:

| Keymap | Action |
| ------------ | ----------------------- |
| `<leader>pc` | Run current Python file |
| <leader>pf | Run current Python file with flags |
| <leader>ph | Search a term in pydoc |
| <leader>pw | Search current word in pydoc |

When triggering a run current file, serpy will:

1. Save the current buffer
1. Open a bottom terminal split
1. Execute the file using your configured Python command

______________________________________________________________________

## Configuration

```lua
require("serpy").setup({
  keymaps = {
    enabled = true,
    pyrun_current = "<leader>pc",
  }
})
```

______________________________________________________________________

## How it works

serpy:

- Detects the current file path
- Builds a command like:
  ```bash
  python3 file.py
  ```
- Opens a terminal split:
  ```vim
  botright 15split | terminal ...
  ```

______________________________________________________________________

## License

serpy is licensed under [MIT License](LICENSE)
