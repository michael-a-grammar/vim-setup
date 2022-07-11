return function(opts)
  if opts.use.elixir_nvim and opts.use.cmp then
    local elixir = require('elixir')

    elixir.setup({
      settings           = elixir.settings({
        dialyzerEnabled  = false,
        enableTestLenses = false,
        fetchDeps        = false,
        suggestSpecs     = false
      }),

      on_attach = function(client, buffer_number)
        local map_opts = {
          buffer  = true,
          noremap = true
        }

        local keymap_set = function(mode, mnemonic, command)
          vim.keymap.set(
            mode,
            mnemonic,
            '<cmd>' .. command .. '<cr>',
            map_opts)
        end

        local keymap_set_n = function(mnemonic, command)
          keymap_set('n', mnemonic, command)
        end

        local keymap_set_v = function(mnemonic, command)
          keymap_set('v', mnemonic, command)
        end

        local keymap_set_x = function(mnemonic, command)
          keymap_set('x', mnemonic, command)
        end

        keymap_set_n('<localleader>f', '%!mix format -')
        keymap_set_n('<localleader>i', [[call Slime('iex', 'exs')]])
        keymap_set_n('<localleader>pf', 'ElixirFromPipe')
        keymap_set_n('<localleader>pt', 'ElixirToPipe')
        keymap_set_v('<localleader>em', 'ElixirExpandMacro')
        keymap_set_x('<localleader>i', [[call Slime('iex', 'exs')]])

        vim.cmd([[imap <expr> <c-l> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<c-l>']])
        vim.cmd([[smap <expr> <c-l> vsnip#available(1) ? '<plug>(vsnip-expand-or-jump)' : '<c-l>']])


        require('cmp_nvim_lsp').update_capabilities(capabilities)
      end
    })

    local elixir_find_files = function()
      require('telescope.builtin').find_files({
        prompt_title = 'Find Files (Elixir)',
        find_command = { 'rg', '--type', 'elixir', '--files' }
      })
    end

    vim.keymap.set('n', '<localleader>sf', elixir_find_files)
  end
end
