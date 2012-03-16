" /sb/ My 'own' .vimrc

" /sb/ call pathogen#runtime_append_all_bundles() replaced with line below
call pathogen#infect()

"/sb/ use vim settings rather than those of vi
set nocompatible


" /sb/ syntax highlighting when colors available
"      also highlight search
if &t_Co > 2 || has('gui_running')
	syntax on
	set hlsearch
endif

" /sb/ os based guifont setting
if has("unix") 
	set guifont=Inconsolata-dz:h14
	set listchars=tab:▸\ ,eol:¬
elseif has("win32") 
	set guifont=Consolas:h12
endif 


" /sb/ solarized colors
syntax enable
if has('gui_running')
	set background=light
else
	set background=dark
endif
colorscheme solarized

" /sb/ gui customization - no icons toolbar, left scroller [March 2012]
set guioptions-=T		
set guioptions-=L		
set guioptions-=m " minus menu		
set guioptions-=r		
" Open files with <leader>f
"	map <leader>f :CommandTFlush<cr>\|:CommandT<cr>

set cmdheight=2


" /sb/
set ts=2 sts=2 sw=2 noexpandtab			"	-	default tabbing

if has('autocmd')

	filetype indent plugin on

	" /sb/ yaml needs to be 2 spaces!
	autocmd Filetype		yaml				setlocal ts=2 sts=2 sw=2 expandtab

	" /sb/ personal
	autocmd Filetype		ruby				setlocal ts=2 sts=2 sw=2 expandtab
	autocmd Filetype		html				setlocal ts=2 sts=2 sw=2 expandtab
	autocmd Filetype		javascript  setlocal ts=4 sts=4 sw=4 noexpandtab

	autocmd BufNewFile,BufRead *.coffee	setfiletype coffee
	autocmd BufNewFile,BufRead *.eco		setfiletype eco

else
	set autoindent
endif

let mapleader=','

" /sb/ map 
nmap <leader>l  :set list!<CR>				" - ',l'	to toggle set list 
nmap <leader>s  :w<CR>								" - ',s'	save in normal mode
nmap <leader>f  :Explore<CR>					" - ',f'	:Explore
nmap <leader>ff :Sexplore<CR>					" - ',ff' :SExplore

" /sb/ look'n'feel
set ruler
set number


" /sb/ netrw 
let g:netrw_preview=1			" - vertical
let g:netrw_liststyle=3		" - treeview
let g:netrw_winsize=40

" /sb/ DAS - http://bit.ly/xIrRbn
"		   gb - windows
set winwidth=200
set winminwidth=175

" /gb/ We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999
" switch between the last two files
nnoremap <leader><leader> <c-^>

" some rails using http://github.com/tpop./vim-rails.git
"
map <leader>\\ :A<cr>
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft 50 :split Gemfile<cr>

" /sb/ this is a big one not sure how good it is [march 2012]
function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>rr :call ShowRoutes()<cr>

