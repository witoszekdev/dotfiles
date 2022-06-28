require 'lspconfig'.graphql.setup {
  filetypes = { "graphql", "typescriptreact", "javascriptreact", "typescript" },
  cmd = {
    "/Users/jonatanwitoszek/git-clone/graphiql/packages/graphql-language-service-cli/bin/graphql.js", "server", "-m",
    "stream"
  }
}
