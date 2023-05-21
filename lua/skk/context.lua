local KanaTable = require("skk.kana.kana_table")
local PreEdit = require("skk.preedit")
local InputState = require("skk.state").InputState

---@class Context
---@field kanaTable KanaTable 全ての変換ルール
---@field preEdit PreEdit
---@field state State
---@field tmpResult? KanaRule feedに完全一致する変換ルール
local Context = {}

function Context.new()
  local self = setmetatable({}, { __index = Context })
  self.kanaTable = KanaTable.new()
  self.preEdit = PreEdit.new()
  self.state = InputState.new()
  return self
end

---@param candidates? KanaRule[]
function Context:updateTmpResult(candidates)
  candidates = candidates or self.kanaTable:filter(self.state.feed)
  self.tmpResult = nil
  for _, candidate in ipairs(candidates) do
    if candidate.input == self.state.feed then
      self.tmpResult = candidate
      break
    end
  end
end

---@return string
function Context:toString()
  return self.state:toString()
end

return Context
