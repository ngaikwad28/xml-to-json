# JSON to XML Converter Plugin for Kong Gateway
## Description

json payload to xml converter


This plugin converts JSON requests to XML format before forwarding them to the upstream server.
   
   ## Installation
1. **Clone the repository:**

   ```bash
   git clone https://github.com/ngaikwad28/xml-to-json.git
   cd xml-to-json
==========================================================================================


  ###  Install and Enable the Plugin

1. **Install the Plugin**

   If you have LuaRocks installed, navigate to the plugin directory and run:

   ```bash
   luarocks make xml-to-json-0.1.0-1.rockspec

2. **Enable plugin to service  
curl -X POST http://localhost:8001/services/{service}/plugins \
  --data "name=xml-to-json" \
  

