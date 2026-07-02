# window-swap.nvim

A lightweight Neovim plugin to swap the buffers of two windows without changing your layout.

Run `:WindowSwap` once to mark the current window, then run it again from another window to swap both buffers.

## Features

* Swap buffers between any two windows.
* Preserve the current window layout.
* Configurable key mappings.
* Lightweight and dependency-free.

## Installation

### Using `vim.pack` (Neovim 0.12+)

```lua
vim.pack.add({
    "https://github.com/<your-user>/window-swap.nvim",
})

require("window-swap").setup()
```

### Using lazy.nvim

```lua
{
    "<your-user>/window-swap.nvim",
    config = function()
        require("window-swap").setup()
    end,
}
```

## Configuration

Default configuration:

```lua
require("window-swap").setup({
    mappings = {
        swap = "<leader>ww",
        cancel = "<leader>wc",
    },
})
```

### Configuration options

| Option            | Type     | Default      | Description                                                  |
| ----------------- | -------- | ------------ | ------------------------------------------------------------ |
| `mappings.swap`   | `string` | `<leader>ww` | Marks the current window or swaps it with the marked window. |
| `mappings.cancel` | `string` | `<leader>wc` | Cancels a pending swap.                                      |

Disable the default mappings:

```lua
require("window-swap").setup({
    mappings = false,
})
```

Use custom mappings:

```lua
require("window-swap").setup({
    mappings = {
        swap = "<leader>ws",
        cancel = "<leader>wc",
    },
})
```

## Usage

Mark the current window:

```vim
:WindowSwap
```

Move to another window and run the command again:

```vim
:WindowSwap
```

The buffers in both windows will be swapped.

Cancel a pending swap:

```vim
:WindowSwapCancel
```

## API

### `setup(opts)`

Initializes the plugin.

### `swap()`

Marks the current window if none is marked. Otherwise, swaps the buffers of the marked window and the current window.

```lua
require("window-swap").swap()
```

### `cancel()`

Cancels the current pending swap.

```lua
require("window-swap").cancel()
```

## License

MIT
