"set t_Co=256
set nohlsearch
set colorcolumn=80

set shiftwidth=2 tabstop=2 softtabstop=2 expandtab
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for do codeAction of current line
nmap <leader>ca <Plug>(coc-codeaction)
nmap <leader>cf <Plug>(coc-format)
nmap <leader>cr <Plug>(coc-rename)
nmap <leader>ch <Plug>(coc-action-doHover)
nmap <leader>cn <Plug>(coc-diagnostic-next)
nmap <leader>cp <Plug>(coc-diagnostic-prev)
nmap <leader>cd <Plug>(coc-diagnostic-info)

nnoremap <silent> K :call <SID>show_documentation()<CR>


" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>

" inoremap <Up> <Nop>
" inoremap <Down> <Nop>
" inoremap <Left> <Nop>
" inoremap <Right> <Nop>

" vnoremap <Up> <Nop>
" vnoremap <Down> <Nop>
" vnoremap <Left> <Nop>
" vnoremap <Right> <Nop>
" 
let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }
function! s:fasd_update() abort
  if empty(&buftype) || &filetype ==# 'dirvish'
    call jobstart(['fasd', '-A', expand('%:p')])
  endif
endfunction
augroup fasd
  autocmd!
  autocmd BufWinEnter,BufFilePost * call s:fasd_update()
augroup END
command! FASD call fzf#run(fzf#wrap({'source': 'fasd -al', 'options': '--no-sort --tac --tiebreak=index'}))
nnoremap <silent> <Leader>e :FASD<CR>
nnoremap <silent> <Leader>a :FZF<CR>
