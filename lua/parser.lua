local toml = {}

--- trim trailing white spaces
---
--@param s(string) string to be trimmed
---
--@returns trimmed_string(string)
function trim(s)
   return s:match( "^%s*(.-)%s*$" )
end

--- parse uni file and return table
---
--@param file_name(string) File to be parsed
---
--@returns parsed_data(table) Table consist of parsed data
function toml.parse_uni(file_name)
  local parsed_data = {}

  file = io.open(file_name, 'r')
  io.input(file)

  key = ""
  for line in io.lines() do
    trimmed_line = trim(line)
    local start, finish = string.find(trimmed_line, "%[(.*)%]")
    if  #trimmed_line == 0 then
      -- do nothing
    elseif  start ~= nil then
      local new_table = {}
      key = string.sub(trimmed_line, start+1, finish-1)
      -- print(key)
      parsed_data[key] = new_table
    else
      local index = string.find(trimmed_line, "=")
      -- print(index)
      local sub_key = string.sub(trimmed_line, 1, index-1)
      sub_key = trim(sub_key)
      -- print(sub_key)
      start, finish = string.find(trimmed_line, "%\"(.*)%\"")
      local value = string.sub(trimmed_line, start+1, finish-1)
      -- print(value)
      parsed_data[key][sub_key] = value
    end
  end

  io.close(file)

  return parsed_data
end

return toml
