return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>.', '<cmd>Neotree filesystem reveal float<CR>', { desc = 'Reveal File [.]' })
    vim.keymap.set('n', '<leader>gs', '<cmd>Neotree git_status reveal float<CR>', { desc = 'Reveal [G]it [S]tatus' })

    require('neo-tree').setup {
      default_component_configs = {
        icon = {
          -- folder_closed = '+',
          -- folder_open = '−',
          -- folder_empty = '',
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = '*',
          highlight = 'NeoTreeFileIcon',
        },
        git_status = {
          symbols = {
            -- Change type
            added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = '×', -- this can only be used in the git_status source
            renamed = 'r', -- this can only be used in the git_status source
            -- Status type
            untracked = '??',
            ignored = '',
            unstaged = 'M',
            staged = 'A',
            conflict = '⁉︎',
          },
        },
      },
      window = {
        position = 'float',
        mappings = {
          ['a'] = {
            'add',
            config = {
              show_path = 'absolute',
            },
          },

          ['m'] = {
            'move',
            config = {
              show_path = 'absolute',
            },
          },

          ['c'] = {
            'copy',
            config = {
              show_path = 'absolute',
            },
          },
          ['Y'] = function(state)
            -- NeoTree is based on [NuiTree](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree)
            -- The node is based on [NuiNode](https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/tree#nuitreenode)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local filename = node.name
            local modify = vim.fn.fnamemodify

            local results = {
              filepath,
              modify(filepath, ':.'),
              modify(filepath, ':~'),
              filename,
              modify(filename, ':r'),
              modify(filename, ':e'),
            }

            -- absolute path to clipboard
            local i = vim.fn.inputlist {
              'Choose to copy to clipboard:',
              '1. Absolute path: ' .. results[1],
              '2. Path relative to CWD: ' .. results[2],
              '3. Path relative to HOME: ' .. results[3],
              '4. Filename: ' .. results[4],
              '5. Filename without extension: ' .. results[5],
              '6. Extension of the filename: ' .. results[6],
            }

            if i > 0 then
              local result = results[i]
              if not result then
                return print('Invalid choice: ' .. i)
              end
              vim.fn.setreg('+', result)
              vim.notify('Copied: ' .. result)
            end
          end,
        },
      },
      filesystem = {
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        },
      },
    }
  end,
}
