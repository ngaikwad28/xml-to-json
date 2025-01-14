local cjson = require "cjson"
local xml2lua = require "xml2lua"
local xml_handler = require "xmlhandler.tree"

local ngx = ngx
local kong = kong

local XmlToJsonPlugin = {}

-- Constructor
function XmlToJsonPlugin:new()
  local obj = {}
  setmetatable(obj, self)
  self.__index = self
  return obj
end

-- Header filter phase
function XmlToJsonPlugin:header_filter()
  -- Change the Content-Type header to "application/json"
  ngx.header["Content-Type"] = "application/json"
  -- Remove Content-Length header to support body modification
  ngx.header["Content-Length"] = nil
end

-- Body filter phase
function XmlToJsonPlugin:body_filter()
  local chunk = ngx.arg[1]
  local eof = ngx.arg[2]

  -- Initialize buffer in the request context if not already present
  if not ngx.ctx.buffer then
    ngx.ctx.buffer = ""
  end

  -- Append the current chunk to the buffer
  if chunk then
    ngx.ctx.buffer = ngx.ctx.buffer .. chunk
    ngx.arg[1] = nil  -- Clear chunk to prevent outputting raw data prematurely
  end

  -- If it's the end of the body, process the complete response
  if eof then
    local handler_instance = xml_handler:new()
    local parser = xml2lua.parser(handler_instance)

    -- Parse the XML content
    local success, err = pcall(function()
      parser:parse(ngx.ctx.buffer)
    end)

    if success then
      -- Extract the root content (removing the root tag)
      local json_content = handler_instance.root
      local root_key = next(json_content)
      local root_data = json_content[root_key]

      -- Encode as JSON
      ngx.arg[1] = cjson.encode(root_data)
    else
      ngx.log(ngx.ERR, "Failed to parse XML response: ", err)
      ngx.arg[1] = ngx.ctx.buffer -- Fallback to original XML if parsing fails
    end
  end
end

-- Define the plugin priority (mandatory)
XmlToJsonPlugin.PRIORITY = 10

-- Define the plugin version (mandatory)
XmlToJsonPlugin.VERSION = "1.0.0"

return XmlToJsonPlugin
