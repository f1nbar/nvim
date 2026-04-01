local file_glob_function = {
  file_glob = {
    group = 'copilot',
    uri = 'files://glob_contents/{pattern}',
    description = 'Includes the full contents of every file matching a specified glob pattern.',
    schema = {
      type = 'object',
      required = { 'pattern' },
      properties = {
        pattern = {
          type = 'string',
          description = 'Glob pattern to match files.',
          default = '**/*',
        },
      },
    },
    resolve = function(input, source)
      local files = require('CopilotChat.utils.files').glob(source.cwd(), {
        pattern = input.pattern,
      })

      local resources = {}
      for _, file_path in ipairs(files) do
        local data, mimetype = require('CopilotChat.resources').get_file(file_path)
        if data then
          table.insert(resources, {
            uri = 'file://' .. file_path,
            name = file_path,
            mimetype = mimetype,
            data = data,
          })
        end
      end

      return resources
    end,
  },
}
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})
require("CopilotChat").setup {
  debug = false, -- Enable debugging
  functions = vim.tbl_deep_extend('force', require("CopilotChat.config.functions"), file_glob_function),
  -- See Configuration section for rest
}
