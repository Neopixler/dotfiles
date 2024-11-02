" Setting some decent VIM settings for programming
" This source file comes from git-for-windows build-extra repository (git-extra/vimrc)
" https://github.com/git-for-windows/build-extra/blob/main/git-extra/vimrc

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-fugitive'  " A popular Git plugin
Plugin 'Konfekt/vim-wsl-copy-paste' " mappings in Vim under WSL to write and read on the Microsoft Windows clipboard

call vundle#end()            " required
filetype plugin indent on    " required

ru! defaults.vim                " Use Enhanced Vim defaults
set mouse=                      " Reset the mouse setting from defaults
aug vimStartup | au! | aug END  " Revert last positioned jump, as it is defined below
let g:skip_defaults_vim = 1     " Do not source defaults.vim again (after loading this system vimrc)

set ai                          " set auto-indenting on for programming
set tabstop=2
set shiftwidth=2
set expandtab
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set showmode                    " show the current mode
set wildmode=list:longest,longest:full   " Better command line completion
nnoremap <C-v> <C-v>
" Show EOL type and last modified timestamp, right after the filename
" Set the statusline
set statusline=%f               " filename relative to current $PWD
set statusline+=%h              " help file flag
set statusline+=%m              " modified flag
set statusline+=%r              " readonly flag
set statusline+=\ [%{&ff}]      " Fileformat [unix]/[dos] etc...
set statusline+=\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})  " last modified timestamp
set statusline+=%=              " Rest: right align
set statusline+=%l,%c%V         " Position in buffer: linenumber, column, virtual column
set statusline+=\ %P            " Position in buffer: Percentage
set cursorline
set nu
set nowrap
set hlsearch

" Copy the last CHANGELOG.md entry
let @a = '3yjPjjllDA'

" I prefer the active line to be highlighted with color instead of being underlined.
hi CursorLine cterm=NONE ctermfg=LightBlue ctermbg=NONE guibg=NONE guifg=NONE

if &term =~ 'xterm-256color'    " mintty identifies itself as xterm-compatible
  if &t_Co == 8
    set t_Co = 256              " Use at least 256 colors
  endif
  " set termguicolors           " Uncomment to allow truecolors on mintty
endif
"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,MERGE_MSG,git-rebase-todo setlocal fileencodings=utf-8

    " Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && &filetype !~# 'commit\|gitrebase'
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff" |
      \   exe "normal g`\"" |
      \ endif

    autocmd BufNewFile,BufRead *.patch set filetype=diff

    autocmd Filetype diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/

    " Highlight specific words in files with a `.tid` extension
    autocmd BufRead,BufNewFile *.tid syntax match InnovationGroup "\<[Ii]nnovat\w*\>"
    autocmd BufRead,BufNewFile *.tid syntax match MindfulGroup "\<[Mm]indful\w*\>"
    autocmd BufRead,BufNewFile *.tid syntax match HonorGroup "\<[Hh]onor\>"
    autocmd BufRead,BufNewFile *.tid syntax match ResponsibilityGroup "\<[Rr]esponsib\w*\>"
    autocmd BufRead,BufNewFile *.tid syntax match CultureGroup "\<[Cc]ultur\w*\>"
    autocmd BufRead,BufNewFile *.tid syntax match InspireGroup "\<[Ii]nspir\w*\>"
    autocmd BufRead,BufNewFile *.tid syntax match FulfillmentGroup "\<[Ff]ulfillment\>"
    autocmd BufRead,BufNewFile *.tid syntax match HappinessGroup "\<[Hh]appiness\>"
    autocmd BufRead,BufNewFile *.tid syntax match SuccessGroup "\<[Ss]uccess\w*\>"
    autocmd BufRead,BufNewFile *.tid syntax match LearnGroup "\<[Ll]earn\w*\>"
    autocmd BufRead,BufNewFile *.tid syntax match TrustGroup "\<[Tt]rust\w*\>"
    autocmd BufRead,BufNewFile *.tid syntax match ShareGroup "\<[Ss]hare\>"

    highlight HonorGroup ctermfg=magenta ctermbg=lightgreen
    highlight ResponsibilityGroup ctermfg=magenta ctermbg=lightgreen
    highlight CultureGroup ctermfg=magenta ctermbg=lightyellow
    highlight InspireGroup ctermfg=magenta ctermbg=lightyellow
    highlight SuccessGroup ctermfg=magenta ctermbg=white
    highlight LearnGroup ctermfg=magenta ctermbg=white
    highlight TrustGroup ctermfg=magenta ctermbg=white
    highlight ShareGroup ctermfg=magenta ctermbg=lightgreen
    highlight FulfillmentGroup ctermfg=magenta ctermbg=lightyellow
    highlight HappinessGroup ctermfg=magenta ctermbg=lightgreen
    highlight MindfulGroup ctermfg=magenta ctermbg=lightgreen
    highlight InnovationGroup ctermfg=magenta ctermbg=lightyellow

    " Change Color when entering Insert Mode
    autocmd InsertEnter * highlight  CursorLine ctermfg=NONE

    " Revert Color to default when leaving Insert Mode
    autocmd InsertLeave * highlight  CursorLine ctermfg=LightBlue
endif " has("autocmd")
