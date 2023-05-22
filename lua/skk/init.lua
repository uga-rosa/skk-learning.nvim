local Context = require("skk.context")
local Keymap = require("skk.keymap")

local context = Context.new()

local M = {}

---@param key string
---@return string
function M.handle(key)
  Keymap.handleKey(context, key)
  local output = context.preEdit:output(context:toString())
  return output
end

local keys = vim.split("abcdefghijklmnopqrstuvwxyz", "")

---@return string
function M.enable()
  if vim.bo.iminsert ~= 1 then
    for _, lhs in ipairs(keys) do
      vim.keymap.set("l", lhs, function()
        return M.handle(lhs)
      end, { buffer = true, silent = true, expr = true })
    end
    return "<C-^>"
  else
    return ""
  end
end

---@return string
function M.disable()
  if vim.bo.iminsert == 1 then
    for _, lhs in ipairs(keys) do
      vim.keymap.del("l", lhs, { buffer = true })
    end
    return "<C-^>"
  else
    return ""
  end
end

---@return string
function M.toggle()
  if vim.bo.iminsert == 1 then
    return M.disable()
  else
    return M.enable()
  end
end

return M
