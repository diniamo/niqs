local plugins = {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "echasnovski/mini.pairs"
}

for i, plugin in ipairs(plugins) do
  plugins[i] = { plugin, enabled = false }
end
return plugins
