if exists("b:current_syntax")
	finish
endif

syn keyword celKeyword HELLO
" Keywords
syn keyword syntaxElementKeyword keyword1 keyword2 nextgroup=syntaxElement2

" Matches
syn match syntaxElementMatch 'regexp' contains=syntaxElement1 nextgroup=syntaxElement2 skipwhite

" Regions
syn region syntaxElementRegion start='x' end='y'


syn keyword basicLanguageKeywords PRINT OPEN IF
syn keyword celBlockCmd RA Dec SpectralType Mass Distance AbsMag nextgroup=celNumber skipwhite

syn match celNumber '\d\+'

hi def link celKeyword Keyword
hi def link basicLanguageKeywords Keyword
hi def link celBlockCmd Keyword

