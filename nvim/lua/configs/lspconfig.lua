-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

lspconfig.servers = {
	"lua_ls",
	"clangd",
	"html",
	"cssls",
	"ts_ls",
	"rust_analyzer",
}

local nvlsp = require("nvchad.configs.lspconfig")
local default_servers = {
	"cssls",
	"html",
	"ts_ls",
}

for _, lsp in ipairs(default_servers) do
	lspconfig[lsp].setup({
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	})
end

require("lspconfig").clangd.setup({
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
		on_attach(client, bufnr)
	end,
	on_init = on_init,
	capabilities = capabilities,
	filetype = { "c", "cpp" },
})

require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	on_init = on_init,
	capabilities = capabilities,

	settings = {
		Lua = {
			diagnostics = {
				enable = false, -- Disable all diagnostics from lua_ts
				-- globals = { "vim" }
			},
			workspace = {
				Library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
					vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
					"${3rd}/love2d/library",
				},
				maxPreLoad = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})
