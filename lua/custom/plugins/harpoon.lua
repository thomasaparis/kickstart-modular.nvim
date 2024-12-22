return {
  'ThePrimeagen/harpoon',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    vim.keymap.set('n', 'hx', require('harpoon.mark').add_file)
    vim.keymap.set('n', 'hn', require('harpoon.ui').nav_next)
    vim.keymap.set('n', 'hp', require('harpoon.ui').nav_prev)
    vim.keymap.set('n', '<leader>th', require('harpoon.ui').toggle_quick_menu, { desc = '[T]oggle [H]arpoon' })
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
