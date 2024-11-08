return {
  {
    'rcarriga/nvim-notify',
    lazy = false,
    config = function()
      local notify = require 'notify'
      -- Set up notify
      notify.setup()

      -- Set notify as the default notify function
      vim.notify = notify
    end,
  },
}
