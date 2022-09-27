return function()
  local comment = require'Comment'
  local map     = require'milque.cartographer'.map

  comment.setup()

  map(function()
    n_leader {
      ';', plug 'comment_toggle_linewise', 'Comment linewise w/ operator'
    }

    x_leader {
      ';', plug 'comment_toggle_linewise_visual', 'Comment selection linewise'
    }
  end)
end
