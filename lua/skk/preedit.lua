local utf8 = require("skk.utf8")

---バッファの変化から差分を生成する
---@class PreEdit
---@field current string
---@field kakutei string
local PreEdit = {}

---@return PreEdit
function PreEdit.new()
  return setmetatable({
    current = "",
    kakutei = "",
  }, { __index = PreEdit })
end

---@param str string
function PreEdit:doKakutei(str)
  self.kakutei = self.kakutei .. str
end

---@param next string
---@return string
function PreEdit:output(next)
  local ret
  if self.kakutei == "" and vim.startswith(next, self.current) then
    ret = next:sub(#self.current)
  else
    local current_len = utf8.len(self.current) --[[@as integer]]
    ret = string.rep("\b", current_len) .. self.kakutei .. next
  end
  self.current = next
  self.kakutei = ""
  return ret
end

return PreEdit
