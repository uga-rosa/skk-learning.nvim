local Input = require("skk.input")
local Context = require("skk.context")

---@type Context
local context

describe("Tests for input.lua", function()
  before_each(function()
    context = Context.new()
  end)

  it("single char", function()
    for char in vim.gsplit("ka", "") do
      Input.kanaInput(context, char)
    end
    assert.are.equals("か", context.fixed)
  end)

  it("multiple chars (don't use tmpResult)", function()
    for char in vim.gsplit("ohayou", "") do
      Input.kanaInput(context, char)
    end
    assert.are.equals("おはよう", context.fixed)
  end)

  it("multiple chars (use tmpResult)", function()
    for char in vim.gsplit("amenbo", "") do
      Input.kanaInput(context, char)
    end
    assert.are.equals("あめんぼ", context.fixed)
  end)

  it("multiple chars (use tmpResult and its next)", function()
    for char in vim.gsplit("uwwwa", "") do
      Input.kanaInput(context, char)
    end
    assert.are.equals("うwっわ", context.fixed)
  end)
end)
