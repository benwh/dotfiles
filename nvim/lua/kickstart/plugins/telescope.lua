return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      {
        -- search specific subdirectories with sdg/sdf
        'princejoogie/dir-telescope.nvim',
        config = function()
          require('dir-telescope').setup {
            -- Defaults
            hidden = true,
            no_ignore = true,
            show_preview = true,
            follow_symlinks = false,
          }

          vim.keymap.set('n', '<leader>sdg', '<cmd>Telescope dir live_grep<cr>', { desc = '[S]earch [D]irectory with [G]rep' })
          vim.keymap.set('n', '<leader>sdf', '<cmd>Telescope dir find_files<cr>', { desc = '[S]earch [D]irectory [F]iles' })
        end,
      },
    },
    config = function()
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          layout_strategy = 'flex',
          layout_config = {
            flex = {
              height = 0.95,
              width = 0.95,
            },
            center = {
              width = 0.5,
            },
            horizontal = {
              width = 0.95,
            },
          },
          mappings = {
            i = {
              -- Ctrl-f to refine, e.g. in live grep mode
              ['<c-f>'] = 'to_fuzzy_refine',
              -- Allow Ctrl-u to clear current input
              ['<c-u>'] = false,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
          },
          live_grep = {
            vimgrep_arguments = {
              -- Defaults
              'rg',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case',
              -- Extras
              '--hidden',
              '--no-ignore-vcs', -- NOTE: check the performance impact - is it worth it?
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'dir')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>f', builtin.buffers, { desc = 'Search [f]ile buffers' })

      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      -- Another old habit
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Search files' })

      -- fzf style "fuzzy live grep"
      -- https://github.com/nvim-telescope/telescope.nvim/issues/564
      vim.keymap.set('n', '<leader>su', function()
        builtin.grep_string { shorten_path = true, word_match = '-w', only_sort_text = true, search = '' }
      end, { desc = '[S]earch F[u]zzy all files' })

      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sq', builtin.diagnostics, { desc = '[S]earch [Q] Diagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

      vim.keymap.set('n', '<leader>slr', builtin.lsp_incoming_calls, { desc = '[S]earch [L]SP [R]eferences' })
      vim.keymap.set('n', '<leader>sli', builtin.lsp_incoming_calls, { desc = '[S]earch [L]SP [I]ncoming calls' })
      vim.keymap.set('n', '<leader>slo', builtin.lsp_outgoing_calls, { desc = '[S]earch [L]SP [O]utgoing calls' })
      vim.keymap.set('n', '<leader>sld', builtin.lsp_incoming_calls, { desc = '[S]earch [L]SP [D]efinition' })
      vim.keymap.set('n', '<leader>slm', builtin.lsp_incoming_calls, { desc = '[S]earch [L]SP I[m]plementations' })
      vim.keymap.set('n', '<leader>sls', builtin.lsp_incoming_calls, { desc = '[S]earch [L]SP Doc [S]ymbols' })

      -- Allow specifying a custom directory
      vim.keymap.set('n', '<leader>sodf', ':Telescope find_files cwd=', { desc = '[S]earch [O]ther [D]irectory [F]iles' })
      vim.keymap.set('n', '<leader>sodg', ':Telescope find_files cwd=', { desc = '[S]earch [O]ther [D]irectory [G]rep' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          -- winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
