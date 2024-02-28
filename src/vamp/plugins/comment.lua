return {
  'numToStr/Comment.nvim',

  keys = {
    {
      '<leader>;',
      '<plug>(comment_toggle_linewise)',
      desc = 'Comment linewise w/operator',
    },

    {
      '<leader>;',
      '<plug>(comment_toggle_linewise_visual)',
      desc = 'Comment selection linewise',
      mode = 'x',
    },
  },
}
