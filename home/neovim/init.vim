set number
syntax on
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set list listchars=tab:»·,trail:·
set cursorline
set expandtab
set colorcolumn=80
set termguicolors

let ayucolor='dark'

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

colorscheme ayu

map <C-n> :NERDTreeToggle<CR>