local kanaTable = require("skk.kana.kana_table")

---@class Context
---@field kanaTable KanaTable 全ての変換ルール
---@field fixed string もう確定したひらがな
---@field feed string 未確定のローマ字
---@field tmpResult? KanaRule feedに完全一致する変換ルール
local Context = {}

function Context.new()
  local self = setmetatable({}, { __index = Context })
  self.kanaTable = kanaTable.new()
  self.fixed = ""
  self.feed = ""
  return self
end

function Context:updateTmpResult()
  self.tmpResult = nil
  for _, candidate in ipairs(self.kanaTable:filter(self.feed)) do
    if candidate.input == self.feed then
      self.tmpResult = candidate
      break
    end
  end
end

return Context
