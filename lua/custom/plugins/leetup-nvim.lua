return {
  {
    'dragfire/leetup.nvim',
    dependencies = { 'm00qek/baleia.nvim' },
    opts = {
      language = 'python3',
    },
    config = function(_, opts)
      require('leetup').setup(opts)
    end,
  },
}
