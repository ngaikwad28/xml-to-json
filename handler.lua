local BasePlugin = require "kong.plugins.base_plugin"
local cjson = require "cjson"
local xml2lua = require "xml2lua" -- Make sure xml2lua is available in your Lua path
local handler = require "xml2lua.handler"

local XmlToJsonHandler = BasePlugin:extend()

function XmlToJsonHandler:new()
  XmlToJsonHandler.super.new(self, "xml-to-json")
end

function XmlToJsonHandler:access(conf)
  XmlToJsonHandler.super.access(self)

  local request_body = ngx.req.get_body_data()
  if request_body then
    local xml_handler = handler:new()
    local parser = xml2lua.parser(xml_handler)

    -- Parse the XML data
    parser:parse(request_body)

    -- Convert parsed XML (table) to JSON
    local json_data = cjson.encode(xml_handler.root)

    -- Replace request body with JSON
    ngx.req.set_body_data(json_data)
  end
end

return XmlToJsonHandler
