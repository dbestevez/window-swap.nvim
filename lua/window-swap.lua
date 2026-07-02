local M = {}

local config = {
  mappings = {
    swap = "<leader>ww",
    cancel = "<leader>wc",
  },
}

local marked_win = nil

local function is_valid_win(win)
  return win and vim.api.nvim_win_is_valid(win)
end

function M.cancel()
  marked_win = nil
end

function M.swap()
  local current_win = vim.api.nvim_get_current_win()

  if not is_valid_win(marked_win) then
    marked_win = current_win
    return
  end

  if marked_win == current_win then
    M.cancel()
    return
  end

  local marked_buf = vim.api.nvim_win_get_buf(marked_win)
  local current_buf = vim.api.nvim_win_get_buf(current_win)

  vim.api.nvim_win_set_buf(marked_win, current_buf)
  vim.api.nvim_win_set_buf(current_win, marked_buf)

  M.cancel()
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  vim.api.nvim_create_user_command("WindowSwap", function()
    M.swap()
  end, {
    desc = "Mark current window or swap it with the marked window",
  })

  vim.api.nvim_create_user_command("WindowSwapCancel", function()
    M.cancel()
  end, {
    desc = "Cancel pending window swap",
  })

  if config.mappings then
    if config.mappings.swap then
      vim.keymap.set("n", config.mappings.swap, M.swap, {
        silent = true,
        desc = "Window swap",
      })
    end

    if config.mappings.cancel then
      vim.keymap.set("n", config.mappings.cancel, M.cancel, {
        silent = true,
        desc = "Cancel window swap",
      })
    end
  end
end

return M
