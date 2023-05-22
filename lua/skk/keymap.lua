local Input = require("skk.input")

local Keymap = {}

local keyMaps = {
  input = setmetatable({}, {
    __index = function()
      return Input.kanaInput
    end,
  }),
  henkan = {},
}

---@param context Context
---@param key string
function Keymap.handleKey(context, key)
  keyMaps[context.state.type][key](context, key)
end

return Keymap
