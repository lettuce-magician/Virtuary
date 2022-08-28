local embed = require 'embed'.zip
local ui = require 'ui'
local ini = {}

ini.parseFile = function(filename)
  filename = filename or ''
  local file = sys.File(filename)
  if not file.exists then
    file = embed:extract('config.ini'):open()
  else
    file = file:open()
  end
  
  local ans,u,k,v,temp = {}
  if not file.exists then return ans end
  for line in file.lines do
    temp = line:match('^%[(.+)%]$')
    if temp ~= nil and u ~= temp then u = temp end
    k,v = line:match('^([^=]+)=(.+)$')
    if u ~= nil then
      ans[u] = ans[u] or {}
      if k ~= nil then
        ans[u][k] = v
      end
    end
  end
  return ans
end

ini.saveFile = function (fileName, data)
	local file = sys.File(fileName)
  if not file.exists then
    file = embed:extract('config.ini'):open('write')
  else
    file = file:open("write")
  end
  
	local contents = '';
	for section, param in pairs(data) do
		contents = contents .. ('[%s]\n'):format(section);
		for key, value in pairs(param) do
			contents = contents .. ('%s=%s\n'):format(key, tostring(value));
		end
		contents = contents .. '\n';
	end
	file:write(contents);
	file:close();
end

return ini