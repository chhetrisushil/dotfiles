if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
  finder_action_keys = {
    open = 'o',
    vsplit = 'v',
    split = 's',
    quit = 'q',
  },
}

EOF

nnoremap <silent> <C-j> :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> gh <cmd>lua require('lspsaga.provider').lsp_finder()<CR>
nnoremap <silent> gp :Lspsaga preview_definition<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
vnoremap <silent><leader>ca :<C-U>Lspsaga range_code_action<CR>
nnoremap <silent>gs :Lspsaga signature_help<CR>

lua << EOF
local status_ok, wk = pcall(require, 'which-key')

if not status_ok then
  return
end

wk.register({
  e = {"<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>" , "Line diagnostics"}
}, {prefix = '<space>', nnoremap = true, silent = true})

EOF
