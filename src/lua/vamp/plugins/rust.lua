return {
  'mrcjkb/rustaceanvim',
  ft = 'rust',
  version = '^4',

  config = function(_, _)
    vim.g.rustaceanvim = {
      tools = {
        test_executor = 'background',
      },
    }
  end,
}
