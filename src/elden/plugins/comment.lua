return {
  'numToStr/Comment.nvim',

  config = function()
    local map = require'elden.cartographer'.map

    require'Comment'.setup()

    map(function()
      n_leader {
        ';', plug 'comment_toggle_linewise', 'Comment linewise w/operator'
      }

      x_leader {
        ';', plug 'comment_toggle_linewise_visual', 'Comment selection linewise'
      }
    end)
  end,
}