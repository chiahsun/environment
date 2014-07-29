" Vim syntax file
" Language:     Pi-ml : ml with pi notion extensions
" Maintainer:   Chia-hsun Cheng	
" Last Change:	2012 Dec 17
" Filenames:	*.piml *.pimli
" URL:		
" Credits: 	Modified from promela.vim from Viliam Holub
" TODO:         

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

syntax case match

" Comments
syn keyword	pimlTodo		contained TODO FIXME XXX ISSUE
syn region	pimlComment		start="/\*" end="\*/" contains=pimlTodo fold
syn match	pimlCommentError	"\*/"
syn region	pimlComment		start="//" skip="\\$" end="$" keepend contains=pimlTodo

" Promela constants
syn region	pimlString		start=+"+ skip=+\\"+ end=+"+ contains=pimlFormat
syn match	pimlStringFormat	display "%\(d\|u\|x\|o\|c\|e\|%\)" contained
syn match	pimlStringFormat	display "\\\(n\|t\|\\\|\"\|\)"  contained
syn match	pimlNumber		"\<[0-9]\+\>"
syn keyword	pimlBoolean		true false TRUE FALSE

" Identifiers
syn keyword	pimlFunction		printf len empty nempty full nfull enabled eval pc_value 
syn keyword     pimlDeclaration         process  nextgroup=pimlProcess
syn keyword     pimlDeclaration         syncprocess endprocess function endfunction
syn match       pimlAssignment          "\<=\>"
syn region      pimlProcessRegion       start="process" end="\s*\w*\s*" 

" Statements
syn keyword 	pimlStatement		atomic d_step goto never of priority provided timeout _ _last _pid c_code c_decl c_track c_expr np_ STDIN trace notrace when
syn keyword	pimlStatementConditional	assert else fi if unless xr xs
syn keyword 	pimlStatementRepeat		do od match with
syn keyword 	pimlStatementLabel		break skip
"syn match   	pimlStatementLabel		display "\s*\I\i*\s*:"
syn keyword 	pimlStatementOperator	run

" Types
syn keyword	pimlType		bit bool byte pid chan int mtype proctype short unsigned Dproctype 
syn keyword 	pimlStorageClass	hidden init inline active local show
syn keyword 	pimlTypedef		typedef c_state 


syn match pimlProcess '\w*\s*\w*=\s*\w*\s*' skipwhite contains=pimlComment, pimlOperatorWhite
syn match pimlProcess2 '\w*\.' contains=pimlOperatorWhite nextgroup=pimlProcess2
syntax match pimlOperator "\(::=\|:=\)"
syntax match pimlOperator "[!?$]"
syntax match pimlOperatorWhite "[=.]" 
syntax match pimlOperatorBrace2 "\[\["
syntax match pimlOperatorBrace2 "\]\]"

syn match    pimlTerminal "\u\(\w\|'\)*\>" contains=pimlProcess, pimlProcess2

" Define the default highlighting.
hi def link pimlComment	        	Comment
hi def link pimlCommentError		Error
hi def link pimlString		        String
hi def link pimlStringFormat		Special
hi def link pimlNumber		        Number
hi def link pimlBoolean		        Boolean
hi def link pimlPreProcDefine      	Define
hi def link pimlPreProcInclude	        Include
hi def link pimlPreProcIncluded	        String
hi def link pimlPreProcCondit 	        PreCondit
hi def link pimlStatement		Statement
hi def link pimlStatementConditional	Conditional
hi def link pimlStatementRepeat	        Repeat
hi def link pimlStatementLabel   	Label 
hi def link pimlStatementOperator	Operator
hi def link pimlFunction		        Function
hi def link pimlType			Type
hi def link pimlDeclaration              Type
hi def link pimlStorageClass		StorageClass
hi def link pimlTypedef		        Typedef
hi def link pimlTodo			Todo
hi def link pimlOut			Comment
hi def link pimlOut2			Comment
hi def link pimlSkip			Comment

" chiahsun add
hi def link pimlProcessRegion            Include
hi def link pimlKeyword                  Include
hi def link pimlProcess                  Include 
hi def link pimlProcess2                 Include 
hi def link pimlProcessDecl              Include 
hi def link pimlMTDef                    Include 
hi def link pimlTerminal                 Special

hi link _Operator Operator

hi link pimlOperator Operator
"hi link pimlOperator1 Include 
hi link pimlOperator Operator
hi ColorWhite ctermfg=White guifg=White
hi ColorDarkMagenta term=bold ctermfg=LightCyan guifg=#99ff00
hi ColorDarkCyan term=bold ctermfg=DarkCyan guifg=#99ffcc
hi link pimlOperatorWhite ColorWhite
hi link pimlOperatorBrace1 ColorDarkMagenta
hi link pimlOperatorBrace2 ColorDarkCyan

let b:current_syntax = "piml"

" vim: ts=8
