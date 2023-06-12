set background=dark
highlight clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "cogent"

" What's with all the boldface in the default color scheme?
highlight Comment                                      cterm=none
highlight String                      ctermfg=magenta  cterm=none
highlight Identifier                  ctermfg=gray     cterm=none

" some other color settings
highlight CursorColumn ctermbg=green                   cterm=none
highlight CursorLine   ctermbg=green                   cterm=none
highlight MatchParen   ctermfg=blue                    cterm=BOLD,INVERSE
highlight NonText      ctermfg=magenta                 cterm=BOLD

" mistakes and annoyances
highlight WSpaceAtEOL  ctermbg=red
highlight LongLineMark ctermbg=magenta

" status line
highlight StatusLine   ctermbg=blue   ctermfg=white    cterm=BOLD
highlight StatusLineNC ctermbg=blue   ctermfg=white    cterm=none
highlight User1        ctermbg=blue   ctermfg=cyan     cterm=BOLD
highlight User2        ctermbg=blue   ctermfg=red      cterm=BOLD

" Fix things that get broken when I change the Identifier color above
highlight helpvim                     ctermfg=cyan     cterm=BOLD
highlight Subtitle                    ctermfg=cyan     cterm=BOLD
highlight helpIdentifier              ctermfg=cyan     cterm=BOLD

" I don't like the standard POD syntax highlighting
highlight podVerbatimLine             ctermfg=magenta  cterm=none
highlight podCmdText                  ctermfg=white    cterm=BOLD
highlight podSpecial                  ctermfg=red      cterm=none
highlight podFormat                   ctermfg=cyan
highlight podForKeywd                 ctermfg=red
