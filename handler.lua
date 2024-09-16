local cjson = require "cjson"
local xml2lua = require "xml2lua" -- Make sure xml2lua is available in your Lua path
local handler = require "xml2lua.handler"

-- Define the plugin
local XmlToJsonHandler = {}

-- Constructor
function XmlToJsonHandler:new()
  local instance = {}
  setmetatable(instance, self)
  self.__index = self
  return instance
end

-- Access phase hook
function XmlToJsonHandler:access(conf)
  -- Ensure the request has a body
  local request_body = ngx.req.get_body_data()
  if request_body then
    local xml_handler = handler:new()
    local parser = xml2lua.parser(xml_handler)

    -- Parse the XML data
    parser:
