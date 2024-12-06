return {
  'elixir-tools/elixir-tools.nvim',
  -- enable = false,
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local elixir = require 'elixir'
    local elixirls = require 'elixir.elixirls'

    elixir.setup {
      nextls = {
        enable = true,
        tag = 'v0.20.1', -- defaults to nil, mutually exclusive with the `branch` option
      },
      elixirls = {

        enable = true,
        settings = elixirls.settings {
          dialyzerEnabled = false,
          enableTestLenses = false,
        },
        on_attach = function(client, bufnr)
          vim.keymap.set('n', '<space>fp', ':ElixirFromPipe<cr>', { buffer = true, noremap = true })
          vim.keymap.set('n', '<space>tp', ':ElixirToPipe<cr>', { buffer = true, noremap = true })
          vim.keymap.set('v', '<space>em', ':ElixirExpandMacro<cr>', { buffer = true, noremap = true })
        end,
      },
      projectionist = {
        enable = true,
      },
    }
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
