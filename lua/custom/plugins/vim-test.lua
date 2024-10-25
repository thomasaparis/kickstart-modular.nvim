local current_dir = debug.getinfo(1).source:match '@?(.*/)'
package.path = package.path .. ';' .. current_dir .. '../terms/?.lua'
local custom_term = require 'custom_term'

return {
  'vim-test/vim-test',
  -- enable = false,
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    -- Set the test strategy to use your custom function
    vim.g['test#custom_strategies'] = {
      custom_term = function(cmd)
        -- The '2' here assumes you want to return to the second window
        -- Adjust as needed for your workflow
        custom_term.open(cmd, '2', function(command, exit_code)
          if exit_code == 0 then
            vim.notify('Tests passed!', vim.log.levels.INFO)
          else
            vim.notify('Tests failed!', vim.log.levels.ERROR)
          end
        end)
      end,
    }

    -- Set the default strategy to your custom one
    vim.g['test#strategy'] = 'custom_term'

    vim.cmd [[
      function! ElixirUmbrellaTransform(cmd) abort
        if match(a:cmd, 'apps/') != -1
          return substitute(a:cmd, 'mix test apps/\([^/]*\)/', 'doppler run -- mix cmd --app \1 mix test --color ', '')
        else
          return a:cmd
        end
      endfunction

      let g:test#custom_transformations = {'elixir_umbrella': function('ElixirUmbrellaTransform')}
      let g:test#transformation = 'elixir_umbrella'
    ]]

    vim.keymap.set('n', '<leader>tn', vim.cmd.TestNearest, { desc = '[T]est [N]earest' })
    vim.keymap.set('n', '<leader>tf', vim.cmd.TestFile, { desc = '[T]est [F]ile' })
    vim.keymap.set('n', '<leader>ts', vim.cmd.TestSuite, { desc = '[T]est [S]uite' })
    vim.keymap.set('n', '<leader>tl', vim.cmd.TestLast, { desc = '[Test] [L]ast' })
  end,

  ft = { 'elixir' }, -- Load for Elixir files
}
