return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>o',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'F[o]rmat buffer',
      },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        -- TODO: painful when ediitng a file
        -- format_after_save = function(bufnr)

        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }

        -- Disable autoformat on certain filetypes
        local ignore_filetypes = {
          -- ruby can be quite annoying
          'ruby',
        }

        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        return {
          timeout_ms = 10000, -- to support goimports, with a big module cache
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        ['*'] = { 'trim_whitespace' },

        -- Run on files which don't have formatters
        -- ["_"] = { 'trim_whitespace' },

        cue = { 'cue_fmt' },
        -- TODO: install automatically
        go = { 'gofmt', 'goimports' },
        -- go = { 'gofmt', 'goimports', 'gci' },
        lua = { 'stylua' },
        jsonnet = { 'jsonnetfmt' },
        just = { 'just' },
        markdown = { 'markdownlint-cli2', 'trim_whitespace' },
        terraform = { 'terraform_fmt' },
        ['terraform-vars'] = { 'terraform_fmt' },
        tofu = { 'tofu_fmt' },
        sql = { 'sqlfluff' },
        ruby = { 'rubocop' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },

        -- Use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
    init = function()
      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          -- FormatDisable! will disable formatting for all buffers
          vim.g.disable_autoformat = true
        else
          vim.b.disable_autoformat = true
        end
      end, {
        desc = 'Disable autoformat-on-save',
        bang = true,
      })

      vim.api.nvim_create_user_command('FormatEnable', function(args)
        if args.bang then
          -- FormatDisable! will disable formatting for all buffers
          vim.g.disable_autoformat = false
        else
          vim.b.disable_autoformat = false
        end
      end, {
        desc = 'Re-enable autoformat-on-save',
        bang = true,
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
