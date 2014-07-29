" Vim syntax file
" Language:     Atm	
" Maintainer:   Chia-hsun Cheng	
" Last Change:	2012 Dec 10
" Filenames:	*.atm
" URL:		
" Credits: 	Modified from promela.vim from Viliam Holub 

" Quit when a (custom) syntax file was already loaded
"if exists("b:current_syntax")
"	finish
"endif

syntax case match

" Comments
syn keyword	atmTodo		contained TODO FIXME XXX
syn region	atmComment		start="/\*" end="\*/" contains=atmTodo fold
syn match	atmCommentError	"\*/"
syn region	atmComment		start="//" skip="\\$" end="$" keepend contains=atmTodo

" Promela constants
syn region	atmString		start=+"+ skip=+\\"+ end=+"+ contains=atmFormat
syn match	atmStringFormat	display "%\(d\|u\|x\|o\|c\|e\|%\)" contained
syn match	atmStringFormat	display "\\\(n\|t\|\\\|\"\|\)"  contained
syn match	atmNumber		"\<[0-9]\+\>"
syn keyword	atmBoolean		true false TRUE FALSE

" Identifiers
syn keyword	atmFunction		printf len empty nempty full nfull enabled eval pc_value 
syn keyword     atmDeclaration          process endprocess 

" Statements
syn keyword 	atmStatement		atomic d_step goto never of priority provided timeout _ _last _pid c_code c_decl c_track c_expr np_ STDIN trace notrace when
syn keyword	atmStatementConditional	assert else fi if unless xr xs
syn keyword 	atmStatementRepeat		do od match with
syn keyword 	atmStatementLabel		break skip
"syn match   	atmStatementLabel		display "\s*\I\i*\s*:"
syn keyword 	atmStatementOperator	run 

" Preprocessor
syn region	atmPreProcIncluded	display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	atmPreProcInclude	display "^\s*\(%:\|#\)\s*include\>\s*\"" contains=atmPreProcIncluded
syn region	atmPreProcDefine	start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" end="//"me=s-1 contains=atmNumber,atmComment
syn region	atmPreProcCondit	start="^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" end="//"me=s-1 contains=atmComment
syn match	atmPreProcCondit	display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"
syn region	atmOut		start="^\s*\(%:\|#\)\s*if\s\+0\+\>" end=".\@=\|$" contains=atmOut2 fold
syn region	atmOut2		contained start="0" end="^\s*\(%:\|#\)\s*\(endif\>\|else\>\|elif\>\)" contains=atmSkip
syn region	atmSkip		contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=atmSkip

" Types
syn keyword	atmType		bit bool byte pid chan int mtype proctype short unsigned Dproctype 
syn keyword 	atmStorageClass	hidden init inline active local show
syn keyword 	atmTypedef		typedef c_state 

" Basic block definition
syntax region	atmBlock		start="{" end="}" transparent fold

" chiahsun add    
syntax match _Operator display "[-+&|<>=!~.,;:*%&^?()$]"
"syn region   atmProcess matchgroup=atmKeyword start="\<process\>\.*" matchgroup=atmKeyword end="\<\w*\>" 
"syn region   atmProcessDecl start="\<process\>\s*" matchgroup=atmKeyword  end="\<\w\(\w\|'\)*\>" contains=atmComment skipwhite skipempty 
syn match    atmTerminal "\u\(\w\|'\)*\>"
syn match    atmMTDef "=\s*\w\(\w\|'\)*\>"hs=s+1,me=s

" Define the default highlighting.
hi def link atmComment	        	Comment
hi def link atmCommentError		Error
hi def link atmString		        String
hi def link atmStringFormat		Special
hi def link atmNumber		        Number
hi def link atmBoolean		        Boolean
hi def link atmPreProcDefine      	Define
hi def link atmPreProcInclude	        Include
hi def link atmPreProcIncluded	        String
hi def link atmPreProcCondit 	        PreCondit
hi def link atmStatement		Statement
hi def link atmStatementConditional	Conditional
hi def link atmStatementRepeat	        Repeat
hi def link atmStatementLabel   	Label 
hi def link atmStatementOperator	Operator
hi def link atmFunction		        Function
hi def link atmType			Type
hi def link atmDeclaration              Type
hi def link atmStorageClass		StorageClass
hi def link atmTypedef		        Typedef
hi def link atmTodo			Todo
hi def link atmOut			Comment
hi def link atmOut2			Comment
hi def link atmSkip			Comment

" chiahsun add
hi def link atmKeyword                  Include
hi def link atmProcess                  Include 
hi def link atmProcessDecl              Include 
hi def link atmMTDef                    Include 
hi def link atmTerminal                 Special
" hi def link atmTerminal                 Include 
hi atmProcess guifg=yellow1 guibg=NONE gui=none

" chiahsun add
hi link _Operator Operator

let b:current_syntax = "atme"

" vim: ts=8
