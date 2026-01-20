return {
  'sheharyarn/werewolf.nvim',
  lazy = false,
  config = function()
    require('werewolf').setup({
      system_theme = {
        on_change = function(theme)
          if theme == 'Dark' then
            vim.o.background = 'dark'
            vim.cmd.colorscheme 'tokyonight-night'
          else
            vim.o.background = 'light'
            vim.cmd.colorscheme 'tokyonight-day'
          end
        end,
      },
    })
  end,
}
