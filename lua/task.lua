local parser = require "parser"
local api = vim.api
local t = {}

function t.task_init()
  current_dir = api.nvim_call_function('getcwd', {})
  command_table = parser.parse_uni(current_dir.."/.task")
  return current_dir, command_table
end

function t.task_output(command, output, autoclose)
  -- create a window below and resize it
  if output == "terminal" then
    api.nvim_command('botright new')
    api.nvim_win_set_height(0, 15)

    local winID = api.nvim_call_function("winnr", {})
    local bufID = api.nvim_call_function("bufnr", {"%"})
    local jobid = api.nvim_call_function("tasknvim#toggle_term", {command, winID, bufID, autoclose})
    api.nvim_command('wincmd p')
  elseif output == "quickfix" then
    local jobid = api.nvim_call_function("tasknvim#toggle_quickfix", {command})
  end
end

function t.task_command(task)
  dir, command_table = t.task_init()
  -- set command
  local command = command_table[task]["command"]

  -- set output
  local output = "terminal"
  if command_table[task]["output"] ~= nil then
    output = command_table[task]["output"]
  end

  -- set autoclose
  local autoclose = "true"
  if command_table[task]["autoclose"] ~= nil then
    autoclose = command_table[task]["autoclose"]
  end

  t.task_output(command, output, autoclose)
end

t.task_command("run")

return t
