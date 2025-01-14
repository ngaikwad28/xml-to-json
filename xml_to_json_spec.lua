local PLUGIN_NAME = "xml-to-json"
local cjson = require "cjson"
local xml2lua = require "xml2lua"

describe(PLUGIN_NAME, function()
  it("should convert XML response to JSON and remove root tag", function()
    local handler = require("kong.plugins." .. PLUGIN_NAME .. ".handler")

    -- Mock ngx context
    _G.ngx = {
      arg = { "", false },
      ctx = { buffer = "<root><key>value</key></root>" },
      log = function() end,
      ERR = "error",
      header = {},
    }

    handler:body_filter()

    -- Simulate end of response
    ngx.arg[2] = true
    handler:body_filter()

    -- Expected output
    local expected_json = cjson.encode({ key = "value" })
    assert.equal(expected_json, ngx.arg[1])
  end)
end)
