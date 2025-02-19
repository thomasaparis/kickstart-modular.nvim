return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    vim.keymap.set('n', '<leader>hx', require('harpoon.mark').add_file)
    vim.keymap.set('n', '<leader>hn', require('harpoon.ui').nav_next)
    vim.keymap.set('n', '<leader>hp', require('harpoon.ui').nav_prev)
    vim.keymap.set('n', '<leader>thp', require('harpoon.ui').toggle_quick_menu, { desc = '[T]oggle [H]ar[p]oon' })
    require('harpoon').setup {
      global_settings = {
        mark_branch = true,
      },
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
    }
  end,
}
