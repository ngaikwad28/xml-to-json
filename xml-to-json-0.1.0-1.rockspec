package = "kong-plugin-xml-to-json"
version = "0.1.0-1"
rockspec_format = "1.0"
description = {
  summary = "Kong plugin to convert XML responses to JSON and remove the root tag",
  detailed = "This plugin converts XML responses from the backend into JSON, removing the root tag from the XML structure.",
  homepage = "https://example.com",
  license = "MIT",
}
dependencies = {
  "lua >= 5.1",
  "kong >= 3.0",
  "xml2lua >= 1.5",
  "lua-cjson >= 2.1.0",
}
source = {
  url = "/home/kong/Desktop/kong-plugin-master",
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.xml-to-json.handler"] = "handler.lua",
    ["kong.plugins.xml-to-json.schema"] = "schema.lua",
  },
}
