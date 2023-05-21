local Input = {}

---@param context Context
---@param result KanaRule
local function acceptResult(context, result)
  local preEdit = context.preEdit
  local state = context.state
  local kana, feed = result.output, result.next

  preEdit:doKakutei(kana)
  state.feed = feed
end

---@param context Context
---@param char string
function Input.kanaInput(context, char)
  local state = context.state
  local input = state.feed .. char
  local candidates = context.kanaTable:filter(input)
  if #candidates == 1 and candidates[1].input == input then
    -- 候補が一つかつ完全一致。確定
    acceptResult(context, candidates[1])
    context:updateTmpResult()
  elseif #candidates > 0 then
    -- 未確定
    state.feed = input
    context:updateTmpResult(candidates)
  elseif context.tmpResult then
    -- 新しい入力によりtmpResultで確定
    acceptResult(context, context.tmpResult)
    context:updateTmpResult()
    Input.kanaInput(context, char)
  else
    -- 入力ミス。context.tmpResultは既にnil
    state.feed = ""
    Input.kanaInput(context, char)
  end
end

return Input
