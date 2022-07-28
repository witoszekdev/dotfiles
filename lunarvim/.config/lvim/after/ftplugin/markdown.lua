require("lvim.lsp.manager").setup("prosemd_lsp")

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "prettier"
  }
}

-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   {
--     name = "proselint"
--   }
-- }

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
-- diagnostics = linters in lunarvim
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "alex" }
}
