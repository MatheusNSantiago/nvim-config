if exists("b:current_syntax") | finish | endif
let b:current_syntax = "cobol"

setlocal isk=@,48-57,-,_ " important for most of the keywords to work!

let g:omni_syntax_group_exclude_cobol = ''
      \ . 'cobolSeqNumArea,cobolIndicator,cobolAB,cobolProgIdArea,cobolover80,cobolUnder7'
      \ . 'cobolComment,cobolTodo,cobolDebugLine,cobolPreProc,'
      \ . 'cobolDivision,cobolSection,cobolParagraph,'
      \ . 'cobolDataLvl,'
      \ . 'cobolSeqNum,'
      \ . 'cobolIndComment,cobolIndDebug,cobolIndPreProc,cobolIndCont,'
      \ . 'cobolFormatFree,cobolBadFree,'
      \ . 'cobolBad'


syn case ignore

" ╾───────────────────────────────────────────────────────────────────────────────────╼

" ╭──────────────────────────────────────────────────────────╮
" │                          Areas                           │
" ╰──────────────────────────────────────────────────────────╯

syn match cobolSeqNumArea  '\%<7c'
syn match cobolIndicator   '\%7c'
syn match cobolAB          '\%>7c\%<73c'    contains=@cobolCode
syn match cobolProgIdArea  '\%>72c.\%<81c'
syn match cobolOver80      '\%>80c.'
syn match cobolUnder7      '\%<7c.'

syn cluster cobolAreas contains=cobolSeqNumArea,cobolIndicator,cobolAB,cobolProgIdArea

" ╭──────────────────────────────────────────────────────────╮
" │                        Indicators                        │
" ╰──────────────────────────────────────────────────────────╯

syn match cobolIndComment  '[*/]'  contained containedin=cobolIndicator
syn match cobolIndComment  '^[*/]' contained containedin=cobolFormatFree

syn keyword cobolIndDebug    D     contained containedin=cobolIndicator
syn match   cobolIndDebug  '^D '   contained containedin=cobolFormatFree

syn match cobolIndPreProc  '\$'    contained containedin=cobolIndicator
syn match cobolIndPreProc  '^\$'   contained containedin=cobolFormatFree

syn match cobolIndCont     '-'     contained containedin=cobolIndicator
syn match cobolIndCont     '-'     contained containedin=cobolFormatFree


syn match cobolBad     '[^ */D$-]' contained containedin=cobolIndicator

" ╭──────────────────────────────────────────────────────────╮
" │                       "Indicated"                        │
" ╰──────────────────────────────────────────────────────────╯

syn match cobolComment  '[*/].*$'     contained containedin=cobolIndicator
syn match cobolComment  '^\s*[*/].*$' contained containedin=cobolFormatFree

syn match cobolInlineComment '\*>.*'
syn cluster cobolCode add=cobolInlineComment

syn match cobolPreProc '\$.*$' contained containedin=cobolIndicator
syn match cobolPreProc '^\s*\$.*$'   contained containedin=cobolFormatFree

" syn match cobolDebugLine  '\v(%7cD\s*)@<=.*$' contains=ALLBUT,cobolBad
" syn match cobolDebugLine  '^\s*D .*$'  contains=ALL contained containedin=cobolFormatFree

" ╭──────────────────────────────────────────────────────────╮
" │               DIVISION, SECTION, PRAGRAPH                │
" ╰──────────────────────────────────────────────────────────╯

" syn match   cobolDivision       contained  '\a\k*\w\s\+DIVISION'  contains=cobolDivisionName
" syn keyword cobolDivisionName   contained  IDENTIFICATION ENVIRONMENT DATA PROCEDURE

" syn match   cobolSection        contained '\a\k*\w\s\+SECTION\ze\.'  contains=cobolSectionName
" syn keyword cobolSectionName    contained  CONFIGURATION INPUT-OUTPUT FILE WORKING-STORAGE LOCAL-STORAGE LINKAGE

" syn match   cobolParagraph      contained '\v%(^((\s|\d){6}.)?)@<=\w\k*\ze\.'  contains=cobolParaNameIdDiv,cobolParaNameSec
" syn keyword cobolParaNameIdDiv  contained  PROGRAM-ID AUTHOR INSTALLATION SOURCE-COMPUTER OBJECT-COMPUTER DATE-WRITTEN DATE-COMPILED SECURITY
" syn keyword cobolParaNameSec    contained  SPECIAL-NAMES FILE-CONTROL I-O-CONTROL

syn cluster cobolCode add=cobolDivision,cobolSection,cobolParagraph

" ╭──────────────────────────────────────────────────────────╮
" │                     Strings, numbers                     │
" ╰──────────────────────────────────────────────────────────╯

syn match cobolString  /"[^"]*\("\|$\)/
syn match cobolString  /'[^']*\('\|$\)/
syn cluster cobolCode add=cobolString

" syn match   cobolNumber "\v<-?\d*\.?\d+>"
" syn cluster cobolCode  add=cobolNumber

" ╭──────────────────────────────────────────────────────────╮
" │                        Data items                        │
" ╰──────────────────────────────────────────────────────────╯

" syn match cobolDataLvl '\%8c\s*\d\?\d\s'
" syn match cobolDataLvl '\v^\s*\d?\d\s' contained containedin=cobolFormatFree

" syn match cobolPic '\v%(PIC\s*)@<=[9AXVSPZ]+(\(\d+\))?' " esse regex é muito lento
syn cluster cobolCode add=cobolPic

" ╭──────────────────────────────────────────────────────────╮
" │                    Reserved keywords                     │
" ╰──────────────────────────────────────────────────────────╯

" Taken from: https://www.ibm.com/docs/en/iis/9.1?topic=words-cobol-reserved
syn keyword cobolReserved  contained  ACCEPT ACCESS ADD ADDRESS ADVANCING AFTER ALL ALPHABET ALPHABETIC
syn keyword cobolReserved  contained  ALPHABETIC-LOWER ALPHABETIC-UPPER ALPHANUMERIC ALPHANUMERIC-EDITED ALSO ALTER
syn keyword cobolReserved  contained  ALTERNATE AND ANY APPLY ARE AREA AREAS ASCENDING ASSIGN AT BASIS BEFORE
syn keyword cobolReserved  contained  BEGINNING BINARY BLANK BLOCK BOTTOM BY CALL CANCEL CBL CD CF CH CHARACTER
syn keyword cobolReserved  contained  CHARACTERS CLASS CLASS-ID CLOCK-UNITS CLOSE COBOL CODE CODE-SET COLLATING
syn keyword cobolReserved  contained  COLUMN COM-REG COMMA COMMON COMMUNICATION COMP COMP-1 COMP-2 COMP-3 COMP-4
syn keyword cobolReserved  contained  COMP-5 COMPUTATIONAL COMPUTATIONAL-1 COMPUTATIONAL-2 COMPUTATIONAL-3
syn keyword cobolReserved  contained  COMPUTATIONAL-4 COMPUTATIONAL-5 COMPUTE CONTENT CONTINUE CONTROL CONTROLS
syn keyword cobolReserved  contained  CONVERTING COPY CORR CORRESPONDING COUNT CURRENCY DAY DAY-OF-WEEK DBCS DE
syn keyword cobolReserved  contained  DEBUG-CONTENTS DEBUG-ITEM DEBUG-LINE DEBUG-NAME DEBUG-SUB-1 DEBUG-SUB-2
syn keyword cobolReserved  contained  DEBUG-SUB-3 DEBUGGING DECIMAL-POINT DECLARATIVES DELETE DELIMITED DELIMITER
syn keyword cobolReserved  contained  DEPENDING DESCENDING DESTINATION DETAIL DISPLAY DISPLAY-1 DIVIDE DIVISION DOWN
syn keyword cobolReserved  contained  DUPLICATES DYNAMIC EGCS EGI EJECT ELSE EMI ENABLE END END-ADD END-CALL
syn keyword cobolReserved  contained  END-COMPUTE END-DELETE END-DIVIDE END-EVALUATE END-IF END-INVOKE END-MULTIPLY
syn keyword cobolReserved  contained  END-OF-PAGE END-PERFORM END-READ END-RECEIVE END-RETURN END-REWRITE END-SEARCH
syn keyword cobolReserved  contained  END-START END-STRING END-SUBTRACT END-UNSTRING END-WRITE ENDING ENTER ENTRY EOP
syn keyword cobolReserved  contained  EQUAL ERROR ESI EVALUATE EVERY EXCEPTION EXIT EXTEND EXTERNAL FALSE FD FILLER
syn keyword cobolReserved  contained  FINAL FIRST FOOTING FOR FROM FUNCTION GENERATE GIVING GLOBAL GO GO GOBACK
syn keyword cobolReserved  contained  GREATER GROUP HEADING HIGH-VALUE HIGH-VALUES I-O ID IF INDEX INDEXED INDICATE
syn keyword cobolReserved  contained  INHERITS INITIAL INITIALIZE INITIATE INPUT INSERT INSPECT INTO INVALID INVOKE
syn keyword cobolReserved  contained  IS JUST JUSTIFIED KANJI KEY LABEL LAST LEADING LEFT LENGTH LESS LIMIT LIMITS
syn keyword cobolReserved  contained  LINAGE LINAGE-COUNTER LINE LINE-COUNTER LINES LOCK LOW-VALUE LOW-VALUES MEMORY
syn keyword cobolReserved  contained  MERGE MESSAGE METACLASS METHOD METHOD-ID MODE MODULES MORE-LABELS MOVE MULTIPLE
syn keyword cobolReserved  contained  MULTIPLY NATIVE NATIVE_BINARY NEGATIVE NEXT NO NOT NULL NULLS NUMBER NUMERIC
syn keyword cobolReserved  contained  NUMERIC-EDITED OBJECT OCCURS OF OFF OMITTED ON OPEN OPTIONAL OR ORDER
syn keyword cobolReserved  contained  ORGANIZATION OTHER OUTPUT OVERFLOW OVERRIDE PACKED-DECIMAL PADDING PAGE
syn keyword cobolReserved  contained  PAGE-COUNTER PASSWORD PERFORM PF PH PIC PICTURE PLUS POINTER POSITION POSITIVE
syn keyword cobolReserved  contained  PRINTING PROCEDURE-POINTER PROCEDURES PROCEED PROCESSING PROGRAM PURGE QUEUE
syn keyword cobolReserved  contained  QUOTE QUOTES RANDOM RD READ READY RECEIVE RECORD RECORDING RECORDS RECURSIVE
syn keyword cobolReserved  contained  REDEFINES REEL REFERENCE REFERENCES RELATIVE RELEASE RELOAD REMAINDER REMOVAL
syn keyword cobolReserved  contained  RENAMES REPLACE REPLACING REPLACING REPORT REPORTING REPORTS REPOSITORY RERUN
syn keyword cobolReserved  contained  RESERVE RESET RETURN RETURN-CODE RETURNING REVERSED REWIND REWRITE RF RH RIGHT
syn keyword cobolReserved  contained  ROUNDED RUN SAME SD SEARCH SEGMENT SEGMENT-LIMIT SELECT SELF SEND
syn keyword cobolReserved  contained  SENTENCE SEPARATE SEQUENCE SEQUENTIAL SERVICE SET SHIFT-IN SHIFT-OUT SIGN SIZE
syn keyword cobolReserved  contained  SKIP1 SKIP2 SKIP3 SORT SORT-CONTROL SORT-CORE-SIZE SORT-FILE-SIZE SORT-MERGE
syn keyword cobolReserved  contained  SORT-MESSAGE SORT-MODE-SIZE SORT-RETURN SOURCE SPACE SPACES STANDARD STANDARD-1
syn keyword cobolReserved  contained  STANDARD-2 START STATUS STOP STRING SUB-QUEUE-1 SUB-QUEUE-2 SUB-QUEUE-3
syn keyword cobolReserved  contained  SUBTRACT SUM SUPER SUPPRESS SYMBOLIC SYNC SYNCHRONIZED TABLE TALLY TALLYING
syn keyword cobolReserved  contained  TAPE TERMINAL TERMINATE TEST TEXT THAN THEN THROUGH THRU TIME TIMES TITLE TO
syn keyword cobolReserved  contained  TOP TRACE TRAILING TRUE TYPE UNIT UNSTRING UNTIL UP UPON USAGE USE USING VALUE
syn keyword cobolReserved  contained  VALUES VARYING WHEN WHEN-COMPILED WITH WORDS WRITE WRITE-ONLY ZERO ZEROES ZEROS


"""" Palavras que eu exclui """""
" syn keyword cobolReserved  contained  SECTION

" ╭──────────────────────────────────────────────────────────╮
" │                      NOVAS KEYWORDS                      │
" ╰──────────────────────────────────────────────────────────╯

syn keyword cobolReserved  contained  EXEC END-EXEC SQL INCLUDE
syn keyword cobolReserved  contained  EQUAL GREATER IS LESS NOT

" ╾───────────────────────────────────────────────────────────────────────────────────╼

" syn keyword cobolArithmetic   contained  COMPUTE END-COMPUTE ADD END-ADD SUBTRACT END-SUBTRACT MULTIPLY END-MULTIPLY DIVIDE END-DIVIDE
syn keyword cobolBoolean      contained  TRUE FALSE
syn keyword cobolBoolOperator contained  AND OR
" syn keyword cobolCalls        contained  FUNCTION CALL END-CALL CANCEL GOBACK PERFORM END-PERFORM INVOKE END-INVOKE THRU

syn keyword cobolComp         contained  COMP COMP-1 COMP-2 COMP-3 COMP-4 COMP-5
syn keyword cobolComp         contained  COMPUTATIONAL COMPUTATIONAL-1 COMPUTATIONAL-2 COMPUTATIONAL-3 COMPUTATIONAL-4 COMPUTATIONAL-5
" syn keyword cobolCompare      contained  EQUAL GREATER IS LESS
syn keyword cobolConditional  contained  IF END-IF THEN ELSE EVALUATE END-EVALUATE WHEN WHEN-COMPILED
syn keyword cobolConstant     contained  SPACE SPACES NULL NULLS ZERO ZEROS ZEROES LOW-VALUE LOW-VALUES HIGH-VALUE HIGH-VALUES
syn keyword cobolDebug        contained  DEBUG-CONTENTS DEBUG-ITEM DEBUG-LINE DEBUG-NAME DEBUG-SUB-1 DEBUG-SUB-2 DEBUG-SUB-3 DEBUGGING
" syn keyword cobolExec         contained  EXEC END-EXEC
syn keyword cobolGoTo         contained  GOTO
syn keyword cobolObjective    contained  CLASS CLASS-ID METACLASS METHOD METHOD-ID SELF OBJECT
syn keyword cobolRepeat       contained  UNTIL VARYING TIMES
syn keyword cobolSort         contained  SORT SORT-CONTROL SORT-CORE-SIZE SORT-FILE-SIZE SORT-MERGE SORT-MESSAGE SORT-MODE-SIZE SORT-RETURN
syn keyword cobolSorting      contained  ASCENDING DESCENDING ALPHABETIC ALPHABETIC-LOWER ALPHABETIC-UPPER ALPHANUMERIC ALPHANUMERIC-EDITED NUMERIC NUMERIC-EDITED

syn cluster cobolCode add=cobolReserved
      \ add=cobolArithmetic
      \ add=cobolBoolean
      \ add=cobolBoolOperator
      \ add=cobolComp
      \ add=cobolCompare
      \ add=cobolConditional
      \ add=cobolConstant
      \ add=cobolDebug
      \ add=cobolExec
      \ add=cobolGoTo
      \ add=cobolRepeat
      \ add=cobolSort
      \ add=cobolSorting
      " \ add=cobolCalls

let b:cobol_syntax_missing_keywords = [ "CONTAINS" ]

" ~ {{{2

" syn match cobolBadFree '\v^\s*\d{6}(\w\k*\.)@!' contained containedin=cobolFormatFree

" if b:cobol_legacy_code
" syn match cobolBad '^\s\{,6}'
" endif

syn match cobolTodo		'TODO' contained containedin=.*Comment

syn match cobolSeqNum '.'    contained containedin=cobolSeqNumArea

" ╭──────────────────────────────────────────────────────────╮
" │                        HIGHLIGHTS                        │
" ╰──────────────────────────────────────────────────────────╯

hi def link cobolSeqNum         Tag

hi def link cobolComment        Comment
hi def link cobolInlineComment  cobolComment
hi def link cobolTodo           Todo

hi def link cobolIndicator      SpecialChar
hi def link cobolIndPreProc     cobolIndicator
hi def link cobolIndDebug       cobolIndicator
hi def link cobolIndCont        cobolIndicator

hi def link cobolDebugLine      Debug
hi def link cobolPreProc        PreProc

" hi def link cobolDataLvl        Type
hi def link cobolPic            Type

hi def link cobolRepeat         Repeat

hi def link cobolConditional    Conditional

hi def link cobolProgIdArea     WarningMsg

hi def link cobolCallProg       Identifier
hi def link cobolFunction       Function

" hi def link cobolDivision       Label
" hi def link cobolSection        Label
" hi def link cobolParagraph      Label
"
" hi def link cobolDivisionName   Keyword
" hi def link cobolSectionName    Keyword
" hi def link cobolParaNameIdDiv  Keyword
" hi def link cobolParaNameSec    Keyword
hi def link cobolBad            Error

hi def link cobolUnder7         Comment
hi def link cobolOver80         Comment

hi def link cobolConstant       Constant
" hi def link cobolNumber         cobolConstant
hi def link cobolString         cobolConstant

hi def link cobolBoolean        Boolean
hi def link cobolBoolOperator   Operator

hi def link cobolArithmetic     Operator

hi def link cobolReserved       Statement
