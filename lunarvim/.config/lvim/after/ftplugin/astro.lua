require 'lspconfig'.tailwindcss.setup {}
require 'lspconfig'.astro.setup {
  init_options = {
    typescript = {
      -- needs to be installed in ~ by using `pnpm i typescript`. NOTE: do not use -g flag!
      serverPath = os.getenv("HOME") .. "/node_modules/typescript/lib/typescript.js"
    },
  },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "prettier",
    -- for projects with prettier, required by astro plugin
    args = { "--plugin-search-dir", "." },
    filetypes = {
      "astro",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "css",
      "scss",
      "less",
      "html",
      "json",
      "jsonc",
      "yaml",
      "markdown",
      "markdown.mdx",
      "graphql",
      "handlebars",
    },
  }
}
