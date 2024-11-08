return {
  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      -- {
      --   '<leader>f',
      --   function()
      --     require('conform').format { async = true, lsp_fallback = true }
      --   end,
      --   mode = '',
      --   desc = '[F]ormat buffer',
      -- },
      {
        '<leader>ft',
        function()
          local conform = require 'conform'
          if vim.g.disable_autoformat then
            vim.g.disable_autoformat = false
            vim.notify('Autoformat enabled', vim.log.levels.INFO)
          else
            vim.g.disable_autoformat = true
            vim.notify('Autoformat disabled', vim.log.levels.INFO)
          end
        end,
        mode = 'n',
        desc = 'Toggle format on save',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Check if autoformat is disabled globally
        if vim.g.disable_autoformat then
          return
        end
        -- Check if autoformat is disabled for this buffer
        if vim.b[bufnr].disable_autoformat then
          return
        end
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true, javascript = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        python = { 'isort', 'black' },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        typescript = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
        -- javascript = { { 'prettierd', 'prettier' } },
      },
    },
    config = function(_, opts)
      local conform = require 'conform'

      conform.setup(opts)

      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
          vim.notify('Autoformat disabled for this buffer', vim.log.levels.INFO)
        else
          vim.g.disable_autoformat = true
          vim.notify('Autoformat disabled globally', vim.log.levels.INFO)
        end
      end, {
        desc = 'Disable autoformat-on-save',
        bang = true,
      })

      vim.api.nvim_create_user_command('FormatEnable', function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
        vim.notify('Autoformat enabled', vim.log.levels.INFO)
      end, {
        desc = 'Re-enable autoformat-on-save',
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
