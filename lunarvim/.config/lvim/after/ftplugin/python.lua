local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "autopep8" },
  { name = "black" },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "flake8" }
}
