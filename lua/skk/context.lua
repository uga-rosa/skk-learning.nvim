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

return Context
