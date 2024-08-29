return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        ['*'] = { 'trim_whitespace' },

        -- Run on files which don't have formatters
        -- ["_"] = { 'trim_whitespace' },

        cue = { 'cue_fmt' },
        go = { 'gci' },
        lua = { 'stylua' },
        jsonnet = { 'jsonnetfmt' },
        just = { 'just' },
        markdown = { 'markdownlint-cli2', 'trim_whitespace' },
        terraform = { 'terraform_fmt' },
        tofu = { 'tofu_fmt' },
        sql = { 'sqlfluff' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },

        -- Use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
