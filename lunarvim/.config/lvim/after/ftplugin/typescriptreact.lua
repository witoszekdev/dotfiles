local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- { name = 'eslint_d' },
  { name = 'prettierd' },
  -- { name = "eslint" },
  -- { name = "prettier" }
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { name = 'eslint_d' }
  -- { name = "eslint" }
}

-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   { name = "refactoring" },
--   -- { name = 'eslint_d' },
--   -- { name = "eslint" }
-- }

require 'lspconfig'.graphql.setup {
  filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" }
}

-- require 'lspconfig'.denols.setup {}

local util = require 'lspconfig.util'
require 'lspconfig'.tsserver.setup {
  -- root_dir = function(fname)
  --   return util.root_pattern 'tsconfig.json' (fname)
  --       or util.root_pattern('package.json', 'jsconfig.json')(fname)
  -- end,
}

require 'lspconfig'.eslint.setup {}
-- require 'lspconfig'.eslint.setup {
--   format = true,
--   settings = {
--     codeActionOnSave = {
--       enable = true,
--       mode = "all"
--     },
--     format = true
--   },
--   conifg = {
--     codeActionOnSave = {
--       enable = true,
--       mode = "all"
--     },
--     format = true
--   }
-- }

-- local dap = require("dap")

require 'mason-nvim-dap'.setup_handlers {}

-- dap.adapters.node2 = {
--   type = "executable",
--   command = "node",
--   args = {os.getenv("HOME") .. ""},
-- }
-- dap.configurations.typescript = {
--   {
--     name = "Launch",
--     type = "node2",
--     request = "launch",
--     program = "${workspaceFolder}/${file}",
--     cwd = vim.fn.getcwd(),
--     sourceMaps = true,
--     protocol = "inspector",
--     console = "integratedTerminal",
--   },
--   {
--     name = 'Attach to process',
--     type = 'node2',
--     request = 'attach',
--     processId = require 'dap.utils'.pick_process,
--   }
-- }

-- require 'lspconfig'.prettierd.setup {
-- }

-- require 'lspconfig'.graphql.setup {
--   filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" },
--   cmd = {
--     "/Users/jonatanwitoszek/git-clone/graphiql/packages/graphql-language-service-cli/bin/graphql.js", "server", "-m",
--     "stream"
--   }
-- }

-- require 'lspconfig'.tailwindcss.setup {}
--
--
require("luasnip/loaders/from_vscode").load({
  paths = { "~/.local/share/lunarvim/site/pack/lazy/opt/react-nextjs-snippets" } })
