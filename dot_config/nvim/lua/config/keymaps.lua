-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set({ "i", "n", "s" }, "<esc>", function()
  -- clear the register
  vim.fn.setreg("/", "")
  vim.cmd("noh")
  local ok, cmp_actions = pcall(function() return LazyVim.cmp.actions end)
  if ok and cmp_actions and cmp_actions.snippet_stop then
    cmp_actions.snippet_stop()
  end
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

local function search_move(expr)
  return function()
    if vim.fn.getreg("/") == "" then
      LazyVim.warn("No search pattern")
      return ""
    end
    return vim.api.nvim_eval(expr)
  end
end

vim.keymap.set("n", "n", search_move("'Nn'[v:searchforward].'zv'"), { expr = true, desc = "Next search result" })
vim.keymap.set({ "o", "x" }, "n", search_move("'Nn'[v:searchforward]"), { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", search_move("'nN'[v:searchforward].'zv'"), { expr = true, desc = "Prev search result" })
vim.keymap.set({ "o", "x" }, "N", search_move("'nN'[v:searchforward]"), { expr = true, desc = "Prev search result" })
