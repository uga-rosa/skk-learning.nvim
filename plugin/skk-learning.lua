if vim.g.loaded_skk_learning then
  return
end
vim.g.loaded_skk_learning = true

vim.keymap.set("i", "<C-j>", require("skk").toggle, { expr = true })
