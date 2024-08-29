return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft['cue'] = { 'cue' }
      lint.linters_by_ft['gitcommit'] = { 'gitlint', 'vale' }
      lint.linters_by_ft['go'] = { 'golangcilint' }
      lint.linters_by_ft['markdown'] = { 'markdownlint-cli2', 'vale' }
      lint.linters_by_ft['ruby'] = { 'ruby', 'rubocop' }
      lint.linters_by_ft['rego'] = { 'opa_check' }
      lint.linters_by_ft['sh'] = { 'shellcheck' }
      lint.linters_by_ft['sql'] = { 'sqlfluff' }
      lint.linters_by_ft['yaml'] = { 'yamllint' }

      --
      -- This effectively also enables a set of default linters:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }
      --
      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
