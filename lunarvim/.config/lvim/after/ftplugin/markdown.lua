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
