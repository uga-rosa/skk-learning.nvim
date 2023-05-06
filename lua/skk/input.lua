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
    context.tmpResult = nil
  elseif #candidates > 0 then
    -- 未確定
    context.feed = input
    context.tmpResult = nil
    for _, candidate in ipairs(candidates) do
      if candidate.input == input then
        context.tmpResult = candidate
        break
      end
    end
  elseif context.tmpResult then
    -- 新しい入力によりtmpResultで確定
    context.fixed = context.fixed .. context.tmpResult.output
    context.feed = context.tmpResult.next .. char
    context.tmpResult = nil
  else
    -- 入力ミス
    context.feed = ""
  end
end

return Input
