---@alias State InputState

---@alias InputMode "direct"

---@class InputState
---@field type "input"
---@field mode InputMode
---@field feed string
local InputState = {}

function InputState.new()
  return setmetatable({
    type = "input",
    mode = "direct",
    feed = "",
  }, { __index = InputState })
end

---@return string
function InputState:toString()
  return self.feed
end

return {
  InputState = InputState,
}
