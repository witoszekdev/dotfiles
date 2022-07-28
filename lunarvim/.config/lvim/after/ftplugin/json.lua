local formatters = require("lvim.lsp.null-ls.formatters")

formatters.setup {
  { name = "prettierd" }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.jsonls.setup {
  capabilities = capabilities,
}
