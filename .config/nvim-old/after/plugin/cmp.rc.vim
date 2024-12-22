if !exists('g:loaded_cmp') | finish | endif

set completeopt=menuone,noinsert,noselect

lua <<EOF
  local cmp = require'cmp'
  local lspkind = require'lspkind'

  cmp.setup({
    snippet = {
      expand = function(args)
        --require('luasnip').lsp_expand(args.body)
        vim.fn["UltiSnips#Anon"](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true
      }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }
    }, {
      { name = 'buffer' },
      { name = 'path' }
      }, {
        { name = 'orgmode' }
      }),
    formatting = {
      format = lspkind.cmp_format({with_text = false, maxwidth = 50})
    }
  })

  vim.cmd [[highlight! default link CmpItemAbbr Pmenu]]
  vim.cmd [[highlight! default link CmpItemAbbrMatch PmenuSel]]
  vim.cmd [[highlight! default link CmpItemAbbrMatchFuzzy PmenuSel]]
  vim.cmd [[highlight! default link CmpItemKind Pmenu]]
  vim.cmd [[highlight! default link CmpItemMenu Pmenu]]
EOF

