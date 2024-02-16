local M = {}

M.env_file_to_table = function(file)
  local f = io.open(file, "r")
  assert(f, "file not found")
  local env = {}
  for line in io.lines(file) do
    if line and not string.match(line, "^#") then
      local index = string.find(line, "=")
      if index then
        local key = string.sub(line, 1, index - 1)
        local value = string.sub(line, index + 1)
        env[key] = value
      end
    end
  end
  f:close()
  return env
end

return M
