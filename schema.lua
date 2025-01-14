local typedefs = require "kong.db.schema.typedefs"

return {
  name = "xml-to-json",
  fields = {
    {
      config = {
        type = "record",
        fields = {
          -- No configuration options for now
        },
      },
    },
  },
}
