local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = 'eslint_d' },
  { name = 'prettierd' },
  -- { name = "eslint" },
  -- { name = "prettier" }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = 'eslint_d' }
  -- { name = "eslint" }
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  { name = "refactoring" },
  { name = 'eslint_d' },
  -- { name = "eslint" }
}

require 'lspconfig'.graphql.setup {
  filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" }
}

-- require 'lspconfig'.eslint.setup {
--   format = true
-- }

require 'lspconfig'.graphql.setup {
  filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" },
  cmd = {
    "/Users/jonatanwitoszek/git-clone/graphiql/packages/graphql-language-service-cli/bin/graphql.js", "server", "-m",
    "stream"
  }
}

-- require 'lspconfig'.tailwindcss.setup {}
