local Input = {}

---@param context Context
---@param char string
function Input.kanaInput(context, char)
  local input = context.feed .. char
  local candidates = context.kanaTable:filter(input)
  if #candidates == 1 and candidates[1].input == input then
    -- 候補が一つかつ完全一致。確定
    context.fixed = context.fixed .. candidates[1].output
    context.feed = candidates[1].next
    context:updateTmpResult()
  elseif #candidates > 0 then
    -- 未確定
    context.feed = input
    context:updateTmpResult(candidates)
  elseif context.tmpResult then
    -- 新しい入力によりtmpResultで確定
    context.fixed = context.fixed .. context.tmpResult.output
    context.feed = context.tmpResult.next
    context:updateTmpResult()
    Input.kanaInput(context, char)
  else
    -- 入力ミス。context.tmpResultは既にnil
    context.feed = ""
    Input.kanaInput(context, char)
  end
end

return Input
