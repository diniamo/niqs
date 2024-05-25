local plugins = {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
}

for i, plugin in ipairs(plugins) do
  plugins[i] = { plugin, enabled = false }
end
return plugins
