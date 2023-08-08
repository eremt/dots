-- LSP and competion config
--
-- Required plugins:
-- - nvim-lspconfig:     https://github.com/neovim/nvim-lspconfig
-- - nvim-cmp:           https://github.com/hrsh7th/nvim-cmp/
-- - ultisnips:          https://github.com/SirVer/ultisnips/
-- - cmp-nvim-lsp:       https://github.com/hrsh7th/cmp-nvim-lsp/
-- - cmp-nvim-ultisnips: https://github.com/quangnguyen30192/cmp-nvim-ultisnips
-- - cmp-path:           https://github.com/hrsh7th/cmp-path
-- - cmp-buffer:         https://github.com/hrsh7th/cmp-buffer
-- - cmp-cmdline:        https://github.com/hrsh7th/cmp-cmdline
--
-- Language servers:
-- - Bash:       npm install -g bash-language-server
-- - TypeScript: npm install -g typescript typescript-language-server
-- - Python:     npm install -g pyright
-- - clangd:     https://clangd.llvm.org/installation.html
-- - SQL:        npm i -g sql-language-server
-- - Rust:       https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary
-- - Go:         go install golang.org/x/tools/gopls@latest

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = { 'bashls', 'tsserver', 'pyright', 'clangd', 'sqlls', 'rust_analyzer', 'gopls' }

local cmp = require('cmp')
cmp.setup {
  snippet = {
    expand = function (args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
  }, {
    { name = 'buffer' },
  },
}
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- jumping
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)

  -- documentation
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

  -- formatting
  vim.keymap.set('n', '<Tab>', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end
