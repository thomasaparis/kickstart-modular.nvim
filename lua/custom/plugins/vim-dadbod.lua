return {
  'tpope/vim-dadbod',
  lazy = true,
  dependencies = {
    'kristijanhusak/vim-dadbod-ui',
    'kristijanhusak/vim-dadbod-completion',
  },
  cmd = { 'DB', 'DBUI', 'DBUIAddConnection', 'DBUIFindBuffer' }, -- Load on command
  config = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
