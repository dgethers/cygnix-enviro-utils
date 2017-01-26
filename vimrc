" see https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"call vundle#begin('~/custom/bundle/location')

" required
Plugin 'gmarik/Vundle.vim'

" my plugins

" really good python folds
Plugin 'tmhedberg/SimpylFold'

" decent python indenting
Plugin 'vim-scripts/indentpython.vim'

" inherited from the vimscript from the link at top. I don't really use this.
Plugin 'vim-scripts/mru.vim'

" likewise... though now that I read the docs and try the color scheme, I may
" want to try this out!
Plugin 'jnurmine/Zenburn'

" A jinja plugin. No real complaints.
Plugin 'Glench/Vim-Jinja2-Syntax'

" Plugin for ES6 which Zeconomy uses extensively.
Plugin 'isRuslan/vim-es6'

" Git utilities. :Gdiff and :Gblame are very useful.
Plugin 'tpope/vim-fugitive'

" I use ack regularly in bash to inspect code; and this is an
" invaluable navigation aid if I actually want to edit around the results.
" Perhaps needless to say you have to have ack to use. Command :Ack.
" Only pitfall, sometimes: https://github.com/mileszs/ack.vim/issues/199
" One of my most-used plugins.
Plugin 'mileszs/ack.vim'

" Utilities for surrounding braces. Vim comes with a few text object utilities
" along these lines but those just help you specify a selection or a motion;
" this goes further and lets you manipulate the surrounding braces. Frequently
" used: ys{motion}b to surround the contents of motion with parentheses, ds)
" to delete surround parentheses (and keep interior content), cSbb to put
" content on separate line(s) from parens.
" So, so useful.
Plugin 'tpope/vim-surround.git'

" Spelling utilities. I mostly use for :Subvert.
Plugin 'tpope/vim-abolish.git'

" in the tpope/* utilities, some complex commands are defined; this basically
" instructs the "." to treat each one as a single command. Very useful.
Plugin 'tpope/vim-repeat.git'

" prereq for many custom text objects that I find invaluable. I don't really
" use it directly.
Plugin 'kana/vim-textobj-user'

" indent-based text objects. ai for everything at this indent level or above;
" ii restricts further to the current paragraph. super useful.
Plugin 'kana/vim-textobj-indent'

" al means whole line; il means line minus surrounding whitespace.
" Occasionally useful.
Plugin 'kana/vim-textobj-line'

" text objects based on arguments to a function. ia is the current argument,
" aa is that plus whitespace and one comma if present. Do not use outside
" braces.  However it seems to play reasonably nicely with {} and [].
" Very important.
Plugin 'b4winckler/vim-angry'

" name explains itself. example: *C*amelCaseMotion, after \w, navigates to
" Camel*C*aseMotion. Works with snake_case as well. Provides text objects for
" inner words as well. So, so useful.
Plugin 'bkad/CamelCaseMotion'

" Lets you run flake8 on your script. Works well and very useful; not sure why
" I'm so unexcited to document it.
Plugin 'nvie/vim-flake8'

" Useful largely for highlighting csv file. Has many commands beginning with
" CSV, found them well-documented the few times I've needed them.
Plugin 'chrisbra/csv.vim'

" A bunch of ]-mappings. [q / ]q move you through quickfix list, [f / ]f move
" through arg files, &c. [e / ]e moves current line or selection up or down by
" [count] lines; [<space> / ]<space> adds lines above or before this line
" instead of calling o<Esc> or O<Esc>. Saves a lot of time.
Plugin 'tpope/vim-unimpaired'

" runs make and shit asynchronously. ack.vim has this as an optional
" dependency; it improves performance very noticeably and seems to solve an
" extremely annoying problem I was running into occasionally
" (https://github.com/mileszs/ack.vim/issues/199). Highly recommend, at least
" with ack.vim.
Plugin 'tpope/vim-dispatch'

" All Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" \w, \b, \e, a\w, i\w ... etc, motions for moving inside a camel case word.
call camelcasemotion#CreateMotionMappings('<leader>')

" syntax highlighting! I think.
syntax on

"define BadWhitespace before using in a match
highlight BadWhitespace ctermbg=red guibg=darkred
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" shortcut for unfolding a fold.
" nnoremap <space> za
" Disabled in favor of using z-* keybindings directly, which are somewhat more
" powerful and more useful.

" number lines, always, no exceptions
set number

" backspace works globally
set backspace=start,indent,eol
" keeps buffers around if you "abandon" them. I don't entirely understand it.
set hidden

" display this funny unicode thing for every tab everywhere, with width 8
set list listchars=tab:⟩— tabstop=8
" use spaces instead when entering new content, and let my tabs have width 4.
" shiftwidth too, see docs for distinction.
set expandtab softtabstop=4 shiftwidth=4
" formerly the tabstop bits were in a filetype autocmd; now we set them
" globally.
" autocmd Filetype javascript,html,jinja,vim,python,gitcommit setlocal ...

" bash is a special baby, for some reason I find 2-char indent works better
autocmd Filetype sh setlocal softtabstop=2 shiftwidth=2

" I do not remember how this got in here. It seems fine.
au BufEnter /private/tmp/crontab.* setlocal backupcopy=yes

set hlsearch " highlights a completed search
set incsearch " jumps to and highlights a search as you type
" use \n to temporarily suppress search highlighting
nnoremap <Leader>n :noh<CR>

" set a useful statusline
set ruler laststatus=2

" timestamp in ruler pulled from vim wikia
" window dimensions in ruler entirely my own (-: it took some doing!
" TODO add git branch
" TODO use let instead of set, for clarity and to avoid escaping spaces
set rulerformat=%47(%{strftime('%e\ %b\ %T\ %p')}\ %5l,%-6(%c%V%)\ %P%10((%{winwidth(0)}x%{winheight(0)})%)%)


" mark the right border with a subtle grey. That's 80 in python/vimL, 72 in
" commit messages, for now the biggest places I care about line length.
autocmd Filetype python,gitcommit,vim highlight ColorColumn ctermbg=235
" soft limit, no real need to enforce.
autocmd Filetype python,vim setlocal colorcolumn=+2 textwidth=78
" no autowrap on text
autocmd Filetype python setlocal formatoptions-=t
" continue comment on <Enter> in Insert mode
autocmd Filetype python setlocal formatoptions+=r
" strict limit; textwidth=72 from distro plugin, and it also sets
" formatoptions to my liking
autocmd Filetype gitcommit setlocal colorcolumn=+0 " textwidth is already 72

" don't autocomment in vimscripts. however, leave 'c' so that it can autowrap
" a very long comment like this one
autocmd Filetype vim setlocal fo-=ro

" create custom vim-surround setting for {% %} and {# #} blocks in jinja
" got the first one from SO i think, link now lost. The others are all me.
autocmd Filetype jinja
        \ let b:surround_{char2nr('^')} = "{% \1{% \1 %}\r{% end\1\r .*\r\1 %}"
autocmd Filetype jinja
        \ let b:surround_{char2nr('%')} = "{% \r %}"
autocmd Filetype jinja
        \ let b:surround_{char2nr('#')} = "{# \r #}"

" enact syntax folds to fight the incredible verbosity of zeconomy email
" templates. see vim-dir/after/syntax/html.vim for custom htmlFold definition.
" The built-in folds are pretty nice too (-:
autocmd BufRead,BufNewFile app/templates/email/*.html
            \ setlocal foldmethod=syntax

" for debugging syntax settings, copied from vim wikia
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" sets :make to run f8diff and read errors into a quickfix list.
" errorformat copied from nvie/vim-flake8
command SetPyMake setlocal makeprg=f8diff makeef=/tmp/flake.err errorformat="%f:%l:%c: %m\,%f:%l: %m"
autocmd Filetype python SetPyMake

" the following is convoluted because we have to create an autocmd that itself
" creates another autocmd. This failed a few times but this works.
" The result is that if your python file ends with a line matching the regex
" below (e.g. "# autoflake"), then on every save, we'll run Flake8 on the
" whole thing.
autocmd BufReadPost *.py if getline('$') =~ '^\s*\#.*autoflake' | call AutoFlake() | endif
function AutoFlake()
    " sets Flake8 to automatically run upon writing a file
    autocmd BufWrite <buffer> call Flake8()
endfunction

" my convention is to save temporary git files as "./.log"
autocmd BufRead,BufNewFile .log setf gitcommit

" define command :Nocommit to abandon a git commit message but save the results
autocmd Filetype gitcommit command Nocommit call GitNoCommit()
function GitNoCommit()
    if expand('%') == ".log"
        " ... that's where we would be saving the file. Ya goofed.
        echo "you're working on .log right now you lumbering halfwit."
        return
    endif
    1,/^#/-1 write! .log
    %delete
    write
    quit
endfunction

" helpful wildcard settings
set wildmode=full wildmenu
" displays full list of wildcard matches as you tab through them
set splitright

" search code base for whole-word matches of current word. Kind of like "*"
" across a whole project instead of a file.
nnoremap gb :Ack -Qw <cword><CR>
" same but cWORD indicates non-space "word" instead of token-defined "word"
nnoremap gB :Ack -Qw <cWORD><CR>

autocmd BufRead,BufNewFile Dockerfile.* setlocal filetype=dockerfile

" vizualizes fold structure
autocmd FileType python set foldcolumn=4

" delete backward then start an insert.
" TODO: try and figure out how to use repeat.vim on this.
nnoremap <unique> S Xi
nnoremap <unique> zS Xi<CR><Esc>

" A bunch of stuff to populate the search register and highlight the results.
" Inspired by something on the msgboard that points out you don't always want
" the usual "*" behavior of navigating to the next match in order to get the
" highlighting.
" Note: The direction bit doesn't work right now. I think vim resets
" v:searchforward after a function. TODO: see if I can override
function SetSearch(patt, direction, ...)
    let thing = a:patt
    if a:0
        let thing = escape(thing, '\')
    endif
    let @/ = thing
    let v:searchforward = a:direction
endfunction

" highlight matches of the current word
nnoremap <silent> z* :call SetSearch(expand("<cword>"), 1, 1)<CR>:set hls<CR>
" highlight matches of the current word when they appear as a word
nnoremap <silent> Z* :call SetSearch("<".expand("<cword>").">", 1, 1)<CR>:set hls<CR>
" like z* but set search direction to backward
nnoremap <silent> z# :call SetSearch(expand("<cword>"), 0, 1)<CR>:set hls<CR>
" like Z* but set search direction to backward
nnoremap <silent> Z# :call SetSearch('\<'.expand("<cword>").'\>', 0, 1)<CR>:set hls<CR>

" to use with motion operators and visual mode
" doesn't work with linewise selection/motions or block selection
function SetSearchFromSelection(type, direction, ...)
    let sel_save = &selection
    let reg_save = @@
    let proceed = 1
    if a:0
        silent exe "normal! gvy"
    elseif a:type == 'char'
        silent exe "normal! `[v`]y"
    else
        proceed = 0
    endif

    if proceed == 1
        call SetSearch('\V' . @@, a:direction)
    endif

    let &selection = sel_save
    let @@ = reg_save

    let &hlsearch = 1
endfunction

" search for next/last instance of selection. Normally keeps you in visual and
" just moves cursor to next word, which is sensible but rarely useful for me.
vnoremap <silent> * :<C-U>call SetSearchFromSelection(visualmode(), 1, 1)<CR>n<CR>
vnoremap <silent> # :<C-U>call SetSearchFromSelection(visualmode(), 0, 1)<CR>n<CR>

" like the above mappings but without navigating.
vnoremap <silent> z* :<C-U>call SetSearchFromSelection(visualmode(), 1, 1)<CR>:set hls<CR>
vnoremap <silent> z# :<C-U>call SetSearchFromSelection(visualmode(), 0, 1)<CR>:set hls<CR>

" place text under motions into search register and highlight them. only words
" with character-wise motions.
nnoremap <silent> =* :set operatorfunc=OperatorSetSearchForward<CR>g@
nnoremap <silent> =# :set operatorfunc=OperatorSetSearchBackward<CR>g@
function OperatorSetSearchForward(type)
    call SetSearchFromSelection(a:type, 1)
endfunction
function OperatorSetSearchBackward(type)
    call SetSearchFromSelection(a:type, 0)
endfunction

" let's start using this...
colors zenburn

" prevents open quickfix window from keeping vim open
autocmd BufEnter * if &buftype == "quickfix" && winbufnr(2) == -1 | quit | fi

" " vim-unimpaired provides mappings for [e and ]e. normally, [e inserts [count]
" " newlines above this line, ]e inserts them below. However as implemented, if
" " folds are active, this causes all the folds to be recalculated, which
" " results in all folds closing. The following is my workaround. But instead
" " I decided to try implementing it in the plugin...
" " these variants will cause re-folding
" nmap [E <Plug>unimpairedMoveUp
" nmap ]E <Plug>unimpairedMoveDown
" xmap [E <Plug>unimpairedMoveSelectionUp
" xmap ]E <Plug>unimpairedMoveSelectionDown
" " these do not, though they do have the unfortunate side effect of
" " recalculating the folds which can occasion a noticeable pause. Also it
" " doesn't respect [count]. TODO: refactor to a function, then <Plug> mappings,
" " then autocmds to map [e and ]e to those mappings
" autocmd FileType python nmap <buffer> <silent> ]e :<C-U>set fdm=manual<CR>:<C-U>exe "normal ".v:count1."]E"<CR>:<C-U>set fdm=expr<CR>
" autocmd FileType python xmap <buffer> <silent> ]e :<C-U>set fdm=manual<CR>:<C-U>exe "normal ".v:count1."]E"<CR>:<C-U>set fdm=expr<CR>
" autocmd FileType python nmap <buffer> <silent> [e :<C-U>set fdm=manual<CR>:<C-U>exe "normal ".v:count1."[E"<CR>:<C-U>set fdm=expr<CR>
" autocmd FileType python xmap <buffer> <silent> [e :<C-U>set fdm=manual<CR>:<C-U>exe "normal ".v:count1."[E"<CR>:<C-U>set fdm=expr<CR>

" Another unimpaired-style mapping to create newlines.
nnoremap <unique> [<CR> i<CR><Esc>
nnoremap <unique> ]<CR> a<CR><Esc>

" tell ack.vim to use dispatch
let g:ack_use_dispatch = 1
