package = "xml-to-json"
version = "1.0.0-1"

source = {
  url = "git://github.com/ngaikwad28/xml-to-json.git"
}

description = {
  summary = "A Kong plugin to convert XML to JSON",
  detailed = "This plugin converts XML request bodies to JSON format."
}

dependencies = {
  "lua-cjson",
  "xml2lua"
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.xml-to-json.handler"] = "handler.lua",
    ["kong.plugins.xml-to-json.schema"] = "schema.lua"
  }
}
