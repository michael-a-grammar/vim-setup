return {
  'mrcjkb/rustaceanvim',
  ft = 'rust',
  version = '^4',

  config = function(_, _)
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set({ 'n', 'x' }, '<leader>ma', function()
            vim.cmd.RustLsp('codeAction')
          end, {
            desc = 'Code actions',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set('n', '<leader>mh', function()
            vim.cmd.RustLsp({ 'hover', 'actions' })
          end, {
            desc = 'Hover actions',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set('x', '<leader>mh', function()
            vim.cmd.RustLsp({ 'hover', 'range' })
          end, {
            desc = 'Hover range',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mdd', function()
            vim.cmd.RustLsp('renderDiagnostic')
          end, {
            desc = 'Render diagnostic',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mde', function()
            vim.cmd.RustLsp('explainError')
          end, {
            desc = 'Explain error',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mif', function()
            vim.cmd.RustLsp({ 'moveItem', 'up' })
          end, {
            desc = 'Move item up',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mii', function()
            vim.cmd.RustLsp('joinLines')
          end, {
            desc = 'Join lines',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mip', function()
            vim.cmd.RustLsp({ 'moveItem', 'down' })
          end, {
            desc = 'Move item down',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mmm', function()
            vim.cmd.RustLsp('expandMacro')
          end, {
            desc = 'Expand macro',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mmp', function()
            vim.cmd.RustLsp('rebuildProMacros')
          end, {
            desc = 'Rebuild pro macros',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mrp', function()
            vim.cmd.RustLsp({ 'runnables', bang = true })
          end, {
            desc = 'Rerun previous runnable',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mrr', function()
            vim.cmd.RustLsp('runnables')
          end, {
            desc = 'Runnables',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>msc', function()
            vim.cmd.RustLsp('openCargo')
          end, {
            desc = 'Open cargo',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>msp', function()
            vim.cmd.RustLsp('parentModule')
          end, {
            desc = 'Parent module',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mss', function()
            vim.cmd.RustLsp('workspaceSymbol')
          end, {
            desc = 'Workspace symbol search',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mss', function()
            vim.cmd.RustLsp({ 'workspaceSymbol', 'onlyTypes' })
          end, {
            desc = 'Workspace type symbol search',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mtp', function()
            vim.cmd.RustLsp({ 'testables', bang = true })
          end, {
            desc = 'Rerun previous testable',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          vim.keymap.set({ 'n', 'x' }, '<leader>mtt', function()
            vim.cmd.RustLsp('testables')
          end, {
            desc = 'Testables',
            buffer = bufnr,
            noremap = true,
            silent = true,
          })

          local to_register = {
            ['<leader>'] = {
              m = {
                name = ' ' .. '',

                d = {
                  name = 'Diagnostics',
                },

                i = {
                  name = 'Move item',
                },

                m = {
                  name = 'Macros',
                },

                r = {
                  name = 'Runnables',
                },

                s = {
                  name = 'Find',
                },

                t = {
                  name = 'Testables',
                },
              },
            },
          }
          local which_key = require('which-key')

          which_key.register(to_register, { mode = 'n' })
          which_key.register(to_register, { mode = 'x' })
        end,
      },

      tools = {
        test_executor = 'background',
      },
    }
  end,
}
