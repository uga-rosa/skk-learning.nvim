local Input = require("skk.input")
local Context = require("skk.context")

---@type Context
local context

---@param input string
---@param expect string
local function test(input, expect)
  for char in vim.gsplit(input, "") do
    Input.kanaInput(context, char)
  end
  assert.are.equals(expect, context.fixed)
end

describe("Tests for input.lua", function()
  before_each(function()
    context = Context.new()
  end)

  it("single char", function()
    test("ka", "か")
  end)

  it("multiple chars (don't use tmpResult)", function()
    test("ohayou", "おはよう")
  end)

  it("multiple chars (use tmpResult)", function()
    test("amenbo", "あめんぼ")
  end)

  it("multiple chars (use tmpResult and its next)", function()
    test("uwwwa", "うwっわ")
  end)

  it("mistaken input", function()
    test("rkakyra", "から")
  end)
end)
