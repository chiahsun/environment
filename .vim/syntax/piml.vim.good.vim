" Vim syntax file
" Language:     Pi-ml : ocaml with pi extension 
" Filenames:    *.piml *.pimli
" Maintainers:  Chia-hsun Cheng
"
" Credits:    - Adopted from ocaml.vim
"               Markus Mottl      <markus.mottl@gmail.com>
"               Karl-Heinz Sylla  <Karl-Heinz.Sylla@gmd.de>
"               Issac Trotts      <ijtrotts@ucdavis.edu>
" URL:          http://www.ocaml.info/vim/syntax/ocaml.vim
" Credits:    - Adopted from promela.vim
"               Viliam Holub
" Last Change:  2012 Dec 17 - Extend ocaml syntax with pi-notion keyword (process ...) and
"                             parallel matching constructs
"                           - Most of the syntax prefix by ocaml is directly
"                             inherited from ocaml.vim
"                           - Prefixs with piml are new extensions for this language

if version < 600
  syntax clear
elseif exists("b:current_syntax") && b:current_syntax != "ocaml"
  finish
endif

" OCaml is case sensitive.
syn case match

" Script headers highlighted like comments
syn match    ocamlComment   "^#!.*"
syn region	pimlComment		start="/\*" end="\*/" contains=pimlTodo fold
syn region	pimlComment		start="//" skip="\\$" end="$" keepend contains=pimlTodo

" Scripting directives
syn match    ocamlScript "^#\<\(quit\|labels\|warnings\|directory\|cd\|load\|use\|install_printer\|remove_printer\|require\|thread\|trace\|untrace\|untrace_all\|print_depth\|print_length\)\>"

" lowercase identifier - the standard way to match
syn match    ocamlLCIdentifier /\<\(\l\|_\)\(\w\|'\)*\>/

syn match    ocamlKeyChar    "|"

" Errors
syn match    ocamlBraceErr   "}"
syn match    ocamlBrackErr   "\]"
syn match    ocamlParenErr   ")"
syn match    ocamlArrErr     "|]"

syn match    ocamlCommentErr "\*)"

syn match    ocamlCountErr   "\<downto\>"
syn match    ocamlCountErr   "\<to\>"

if !exists("ocaml_revised")
  syn match    ocamlDoErr      "\<do\>"
endif

syn match    ocamlDoneErr    "\<done\>"
syn match    ocamlThenErr    "\<then\>"

" Error-highlighting of "end" without synchronization:
" as keyword or as error (default)
if exists("ocaml_noend_error")
  syn match    ocamlKeyword    "\<end\>"
else
  syn match    ocamlEndErr     "\<end\>"
endif

" Some convenient clusters
syn cluster  ocamlAllErrs contains=ocamlBraceErr,ocamlBrackErr,ocamlParenErr,ocamlCommentErr,ocamlCountErr,ocamlDoErr,ocamlDoneErr,ocamlEndErr,ocamlThenErr

syn cluster  ocamlAENoParen contains=ocamlBraceErr,ocamlBrackErr,ocamlCommentErr,ocamlCountErr,ocamlDoErr,ocamlDoneErr,ocamlEndErr,ocamlThenErr

syn cluster  ocamlContained contains=ocamlTodo,ocamlPreDef,ocamlModParam,ocamlModParam1,ocamlPreMPRestr,ocamlMPRestr,ocamlMPRestr1,ocamlMPRestr2,ocamlMPRestr3,ocamlModRHS,ocamlFuncWith,ocamlFuncStruct,ocamlModTypeRestr,ocamlModTRWith,ocamlWith,ocamlWithRest,ocamlModType,ocamlFullMod


" Enclosing delimiters
syn region   ocamlEncl transparent matchgroup=ocamlKeyword start="(" matchgroup=ocamlKeyword end=")" contains=ALLBUT,@ocamlContained,ocamlParenErr
syn region   ocamlEncl transparent matchgroup=ocamlKeyword start="{" matchgroup=ocamlKeyword end="}"  contains=ALLBUT,@ocamlContained,ocamlBraceErr
syn region   ocamlEncl transparent matchgroup=ocamlKeyword start="\[" matchgroup=ocamlKeyword end="\]" contains=ALLBUT,@ocamlContained,ocamlBrackErr
syn region   ocamlEncl transparent matchgroup=ocamlKeyword start="\[|" matchgroup=ocamlKeyword end="|\]" contains=ALLBUT,@ocamlContained,ocamlArrErr


" Comments
syn region   ocamlComment start="(\*" end="\*)" contains=ocamlComment,ocamlTodo
syn keyword  ocamlTodo contained TODO FIXME XXX


" Objects
syn region   ocamlEnd matchgroup=ocamlObject start="\<object\>" matchgroup=ocamlObject end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr


" Blocks
if !exists("ocaml_revised")
  syn region   ocamlEnd matchgroup=ocamlKeyword start="\<begin\>" matchgroup=ocamlKeyword end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr
endif


" "for"
syn region   ocamlNone matchgroup=ocamlKeyword start="\<for\>" matchgroup=ocamlKeyword end="\<\(to\|downto\)\>" contains=ALLBUT,@ocamlContained,ocamlCountErr


" "do"
if !exists("ocaml_revised")
  syn region   ocamlDo matchgroup=ocamlKeyword start="\<do\>" matchgroup=ocamlKeyword end="\<done\>" contains=ALLBUT,@ocamlContained,ocamlDoneErr
endif

" "if"
syn region   ocamlNone matchgroup=ocamlKeyword start="\<if\>" matchgroup=ocamlKeyword end="\<then\>" contains=ALLBUT,@ocamlContained,ocamlThenErr


"" Modules

" "struct"
syn region   ocamlStruct matchgroup=ocamlModule start="\<struct\>" matchgroup=ocamlModule end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr

" "sig"
syn region   ocamlSig matchgroup=ocamlModule start="\<sig\>" matchgroup=ocamlModule end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr,ocamlModule
syn region   ocamlModSpec matchgroup=ocamlKeyword start="\<module\>" matchgroup=ocamlModule end="\<\u\(\w\|'\)*\>" contained contains=@ocamlAllErrs,ocamlComment skipwhite skipempty nextgroup=ocamlModTRWith,ocamlMPRestr

" "open"
syn region   ocamlNone matchgroup=ocamlKeyword start="\<open\>" matchgroup=ocamlModule end="\<\u\(\w\|'\)*\(\.\u\(\w\|'\)*\)*\>" contains=@ocamlAllErrs,ocamlComment

" "include"
syn match    ocamlKeyword "\<include\>" contained skipwhite skipempty nextgroup=ocamlModParam,ocamlFullMod

" "module" - somewhat complicated stuff ;-)
syn region   ocamlModule matchgroup=ocamlKeyword start="\<module\>" matchgroup=ocamlModule end="\<\u\(\w\|'\)*\>" contains=@ocamlAllErrs,ocamlComment skipwhite skipempty nextgroup=ocamlPreDef
syn region   ocamlPreDef start="."me=e-1 matchgroup=ocamlKeyword end="\l\|="me=e-1 contained contains=@ocamlAllErrs,ocamlComment,ocamlModParam,ocamlModTypeRestr,ocamlModTRWith nextgroup=ocamlModPreRHS
syn region   ocamlModParam start="([^*]" end=")" contained contains=@ocamlAENoParen,ocamlModParam1
syn match    ocamlModParam1 "\<\u\(\w\|'\)*\>" contained skipwhite skipempty nextgroup=ocamlPreMPRestr

syn region   ocamlPreMPRestr start="."me=e-1 end=")"me=e-1 contained contains=@ocamlAllErrs,ocamlComment,ocamlMPRestr,ocamlModTypeRestr

syn region   ocamlMPRestr start=":" end="."me=e-1 contained contains=@ocamlComment skipwhite skipempty nextgroup=ocamlMPRestr1,ocamlMPRestr2,ocamlMPRestr3
syn region   ocamlMPRestr1 matchgroup=ocamlModule start="\ssig\s\=" matchgroup=ocamlModule end="\<end\>" contained contains=ALLBUT,@ocamlContained,ocamlEndErr,ocamlModule
syn region   ocamlMPRestr2 start="\sfunctor\(\s\|(\)\="me=e-1 matchgroup=ocamlKeyword end="->" contained contains=@ocamlAllErrs,ocamlComment,ocamlModParam skipwhite skipempty nextgroup=ocamlFuncWith,ocamlMPRestr2
syn match    ocamlMPRestr3 "\w\(\w\|'\)*\(\.\w\(\w\|'\)*\)*" contained
syn match    ocamlModPreRHS "=" contained skipwhite skipempty nextgroup=ocamlModParam,ocamlFullMod
syn region   ocamlModRHS start="." end=".\w\|([^*]"me=e-2 contained contains=ocamlComment skipwhite skipempty nextgroup=ocamlModParam,ocamlFullMod
syn match    ocamlFullMod "\<\u\(\w\|'\)*\(\.\u\(\w\|'\)*\)*" contained skipwhite skipempty nextgroup=ocamlFuncWith

syn region   ocamlFuncWith start="([^*]"me=e-1 end=")" contained contains=ocamlComment,ocamlWith,ocamlFuncStruct skipwhite skipempty nextgroup=ocamlFuncWith
syn region   ocamlFuncStruct matchgroup=ocamlModule start="[^a-zA-Z]struct\>"hs=s+1 matchgroup=ocamlModule end="\<end\>" contains=ALLBUT,@ocamlContained,ocamlEndErr

syn match    ocamlModTypeRestr "\<\w\(\w\|'\)*\(\.\w\(\w\|'\)*\)*\>" contained
syn region   ocamlModTRWith start=":\s*("hs=s+1 end=")" contained contains=@ocamlAENoParen,ocamlWith
syn match    ocamlWith "\<\(\u\(\w\|'\)*\.\)*\w\(\w\|'\)*\>" contained skipwhite skipempty nextgroup=ocamlWithRest
syn region   ocamlWithRest start="[^)]" end=")"me=e-1 contained contains=ALLBUT,@ocamlContained

" "module type"
syn region   ocamlKeyword start="\<module\>\s*\<type\>" matchgroup=ocamlModule end="\<\w\(\w\|'\)*\>" contains=ocamlComment skipwhite skipempty nextgroup=ocamlMTDef
syn match    ocamlMTDef "=\s*\w\(\w\|'\)*\>"hs=s+1,me=s

syn keyword  ocamlKeyword  and as assert class
syn keyword  ocamlKeyword  constraint else
syn keyword  ocamlKeyword  exception external fun

syn keyword  ocamlKeyword  in inherit initializer
syn keyword  ocamlKeyword  land lazy let match
syn keyword  ocamlKeyword  method mutable new of
syn keyword  ocamlKeyword  parser private raise rec
syn keyword  ocamlKeyword  try type
syn keyword  ocamlKeyword  val virtual when while with

syn keyword  pimlKeyword   endfunction 
syn keyword  pimlKeyword   process syncprocess endprocess
syn match pimlProcess '\w*\s*\w*=\s*\w*\s*' skipwhite contains=pimlComment, pimlOperatorWhite
syn match pimlProcess2 '\w*\.' contains=pimlOperatorWhite nextgroup=pimlProcess2

syntax match pimlOperator "\(::=\|:=\)"
syntax match pimlOperator "[!?$]"
syntax match pimlOperatorWhite "[=.]" 
syntax match pimlOperatorBrace2 "\[\["
syntax match pimlOperatorBrace2 "\]\]"

if exists("ocaml_revised")
  syn keyword  ocamlKeyword  do value
  syn keyword  ocamlBoolean  True False
else
  syn keyword  ocamlKeyword  function
  syn keyword  ocamlBoolean  true false
  syn match    ocamlKeyChar  "!"
endif

syn keyword  ocamlType     array bool char exn float format format4
syn keyword  ocamlType     int int32 int64 lazy_t list nativeint option
syn keyword  ocamlType     string unit

syn keyword  ocamlOperator asr lor lsl lsr lxor mod not

syn match    ocamlConstructor  "(\s*)"
syn match    ocamlConstructor  "\[\s*\]"
syn match    ocamlConstructor  "\[|\s*>|]"
syn match    ocamlConstructor  "\[<\s*>\]"
syn match    ocamlConstructor  "\u\(\w\|'\)*\>"

" Polymorphic variants
syn match    ocamlConstructor  "`\w\(\w\|'\)*\>"

" Module prefix
syn match    ocamlModPath      "\u\(\w\|'\)*\."he=e-1

syn match    ocamlCharacter    "'\\\d\d\d'\|'\\[\'ntbr]'\|'.'"
syn match    ocamlCharErr      "'\\\d\d'\|'\\\d'"
syn match    ocamlCharErr      "'\\[^\'ntbr]'"
syn region   ocamlString       start=+"+ skip=+\\\\\|\\"+ end=+"+

syn match    ocamlFunDef       "->"
syn match    ocamlRefAssign    ":="
syn match    ocamlTopStop      ";;"
syn match    ocamlOperator     "\^"
syn match    ocamlOperator     "::"

syn match    ocamlOperator     "&&"
syn match    ocamlOperator     "<"
syn match    ocamlOperator     ">"
syn match    ocamlAnyVar       "\<_\>"
syn match    ocamlKeyChar      "|[^\]]"me=e-1
syn match    ocamlKeyChar      ";"
syn match    ocamlKeyChar      "\~"
syn match    ocamlKeyChar      "?"
syn match    ocamlKeyChar      "\*"
syn match    ocamlKeyChar      "="

if exists("ocaml_revised")
  syn match    ocamlErr        "<-"
else
  syn match    ocamlOperator   "<-"
endif

syn match    ocamlNumber        "\<-\=\d\+\>"
syn match    ocamlNumber        "\<-\=0[x|X]\x\+\>"
syn match    ocamlNumber        "\<-\=0[o|O]\o\+\>"
syn match    ocamlNumber        "\<-\=0[b|B][01]\+\>"
syn match    ocamlFloat         "\<-\=\d\+\.\d*\([eE][-+]\=\d\+\)\=[fl]\=\>"

" Labels
syn match    ocamlLabel        "\~\(\l\|_\)\(\w\|'\)*"lc=1
syn match    ocamlLabel        "?\(\l\|_\)\(\w\|'\)*"lc=1
syn region   ocamlLabel transparent matchgroup=ocamlLabel start="?(\(\l\|_\)\(\w\|'\)*"lc=2 end=")"me=e-1 contains=ALLBUT,@ocamlContained,ocamlParenErr


" Synchronization
syn sync minlines=50
syn sync maxlines=500

if !exists("ocaml_revised")
  syn sync match ocamlDoSync      grouphere  ocamlDo      "\<do\>"
  syn sync match ocamlDoSync      groupthere ocamlDo      "\<done\>"
endif

if exists("ocaml_revised")
  syn sync match ocamlEndSync     grouphere  ocamlEnd     "\<\(object\)\>"
else
  syn sync match ocamlEndSync     grouphere  ocamlEnd     "\<\(begin\|object\)\>"
endif

syn sync match ocamlEndSync     groupthere ocamlEnd     "\<end\>"
syn sync match ocamlStructSync  grouphere  ocamlStruct  "\<struct\>"
syn sync match ocamlStructSync  groupthere ocamlStruct  "\<end\>"
syn sync match ocamlSigSync     grouphere  ocamlSig     "\<sig\>"
syn sync match ocamlSigSync     groupthere ocamlSig     "\<end\>"

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_ocaml_syntax_inits")
  if version < 508
    let did_ocaml_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink ocamlBraceErr     Error
  HiLink ocamlBrackErr     Error
  HiLink ocamlParenErr     Error
  HiLink ocamlArrErr       Error

  HiLink ocamlCommentErr   Error

  HiLink ocamlCountErr     Error
  HiLink ocamlDoErr        Error
  HiLink ocamlDoneErr      Error
  HiLink ocamlEndErr       Error
  HiLink ocamlThenErr      Error

  HiLink ocamlCharErr      Error

  HiLink ocamlErr          Error

  HiLink ocamlComment      Comment

  HiLink ocamlModPath      Include
  HiLink ocamlObject	   Include
  HiLink ocamlModule       Include
  HiLink ocamlModParam1    Include
  HiLink ocamlModType      Include
  HiLink ocamlMPRestr3     Include
  HiLink ocamlFullMod      Include
  HiLink ocamlModTypeRestr Include
  HiLink ocamlWith         Include
  HiLink ocamlMTDef        Include

  HiLink ocamlScript       Include

  HiLink ocamlConstructor  Constant

  HiLink ocamlModPreRHS    Keyword
  HiLink ocamlMPRestr2     Keyword
  HiLink ocamlKeyword      Keyword
  HiLink ocamlFunDef       Keyword
  HiLink ocamlRefAssign    Keyword
  HiLink ocamlKeyChar      Keyword
  HiLink ocamlAnyVar       Keyword
  HiLink ocamlTopStop      Keyword
  HiLink ocamlOperator     Keyword

  HiLink ocamlBoolean      Boolean
  HiLink ocamlCharacter    Character
  HiLink ocamlNumber       Number
  HiLink ocamlFloat        Float
  HiLink ocamlString       String

  HiLink ocamlLabel        Identifier

  HiLink ocamlType         Type

  HiLink ocamlTodo         Todo

  HiLink ocamlEncl         Keyword

  HiLink pimlComment	   Comment
  HiLink pimlKeyword       Keyword
  HiLink pimlOperator      Operator
  HiLink pimlProcess                  Include 
  HiLink pimlProcess2                 Include 
  HiLink pimlProcessDecl              Include 
  hi ColorWhite ctermfg=White guifg=White
  hi ColorDarkMagenta term=bold ctermfg=LightCyan guifg=#99ff00
  hi ColorDarkCyan term=bold ctermfg=DarkCyan guifg=#99ffcc
  HiLink pimlOperatorWhite  ColorWhite
  HiLink pimlOperatorBrace1 ColorDarkMagenta
  HiLink pimlOperatorBrace2 ColorDarkCyan
  delcommand HiLink
endif

let b:current_syntax = "ocaml"

" vim: ts=8
