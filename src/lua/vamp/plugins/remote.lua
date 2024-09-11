return {
  'amitds1997/remote-nvim.nvim',
  version = '0.3.9',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim',
  },

  opts = {
    client_callback = function(port, _)
      local cmd = ('kitty --execute nvim --server localhost:%s --remote-ui'):format(
        port
      )

      vim.fn.jobstart(cmd, {
        detach = true,
        on_exit = function(job_id, exit_code, event_type)
          print(
            'Client',
            job_id,
            'exited with code',
            exit_code,
            'event type:',
            event_type
          )
        end,
      })
    end,
  },

  config = true,
}
