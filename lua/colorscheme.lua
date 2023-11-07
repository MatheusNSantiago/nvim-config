local M = {}
-- https://github.com/numToStr/Sakura.nvim/commit/392a5d5a2e6097b816314b38d727e641a5bde7c9
-- https://github.com/LunarVim/onedarker.nvim/blob/master/lua/onedarker/theme.lua
local hls = {}

hls.syntax = {
	Comment = { fg = c.comments },
	Boolean = { fg = c.red },
	Conditional = { fg = c.purple },
	Todo = { fg = c.comments },
	Constant = { fg = c.cyan, bold = true },
	String = { fg = c.green },
	Identifier = { fg = 'None' },
	Type = { fg = c.purple },
	TypeDef = { fg = c.yellow },
	Function = { fg = c.yellow },
	Statement = { fg = c.purple },
	Operator = { fg = c.red },
	WarningMsg = { fg = c.orange },
	PreProc = { fg = c.purple },
	Define = { fg = c.purple },
	Special = { fg = c.red },
	Conceal = { fg = c.orange },
	Character = { fg = c.green },
	Include = { fg = c.purple },
	Macro = { fg = c.purple },
	Structure = { fg = c.red },
	Underlined = { fg = 'None' },
	Error = { fg = c.red, underline = true },
}

hls.lsp = {
	-- ["@lsp.type.class"] = { link = "Structure" },
	-- ["@lsp.type.decorator"] = { link = "Function" },
	['@lsp.type.enum'] = { link = 'Structure' },
	-- ["@lsp.type.enumMember"] = { link = "Constant" },
	-- ["@lsp.type.function"] = { link = "Function" },
	['@lsp.type.interface'] = { link = 'Structure' }, -- interfaces
	-- ["@lsp.type.macro"] = { link = "Macro" },
	['@lsp.type.method'] = { link = '@method' },      -- Function
	['@lsp.type.namespace'] = { link = '@namespace' }, -- Structure
	['@lsp.type.parameter'] = { link = '@parameter' }, -- Identifier
	-- ["@lsp.type.property"] = { link = "Identifier" },
	-- ["@lsp.type.struct"] = { link = "Structure" },
	-- ["@lsp.type.type"] = { link = "Type" },
	['@lsp.type.type'] = { link = 'TypeDef' },
	['@lsp.type.typeParameter'] = { link = 'TypeDef' },
	['@lsp.type.variable'] = { link = 'Identifier' }, -- Identifier
	['@lsp.type.comment'] = { fg = 'none' },         -- Comment
	['@lsp.type.selfParameter'] = { link = '@variable.builtin' },
	-- ["@lsp.type.builtinConstant"] = { link = "@constant.builtin" },
	['@lsp.type.builtinConstant'] = { link = '@constant.builtin' },
	['@lsp.type.magicFunction'] = { link = '@function.builtin' },

	['@lsp.mod.readonly'] = { link = 'Constant' },
	['@lsp.mod.typeHint'] = { link = 'Type' },
	-- ["@lsp.mod.defaultLibrary"] = { link = "Special" },
	-- ["@lsp.mod.builtin"] = { link = "Special" },

	['@lsp.typemod.class.declaration'] = { link = 'Structure' },
	['@lsp.typemod.operator.controlFlow'] = { link = '@exception' },
	['@lsp.typemod.keyword.documentation'] = { link = 'Special' },
	['@lsp.typemod.variable.global'] = { link = 'Constant' },
	['@lsp.typemod.variable.static'] = { link = 'Constant' },
	['@lsp.typemod.variable.defaultLibrary'] = { link = 'Special' },
	['@lsp.typemod.function.builtin'] = { link = '@function.builtin' },
	['@lsp.typemod.function.defaultLibrary'] = { link = '@function.builtin' },
	['@lsp.typemod.method.defaultLibrary'] = { link = '@function.builtin' },
	['@lsp.typemod.operator.injected'] = { link = 'Operator' },
	['@lsp.typemod.string.injected'] = { link = 'String' },
	['@lsp.typemod.variable.injected'] = { link = '@variable' },
	-- ["@lsp.typemod.function.readonly"] = { fg = theme.syn.fun, bold = true },
	['@lsp.typemod.function.readonly'] = { link = 'Function', bold = true },
	['@lsp.mod.annotation'] = { fg = c.purple }, -- @[annotation]
	['@lsp.type.annotation'] = { fg = c.purple }, -- [@]annotation
}

hls.treesitter = {
	--  ╭──────────────────────────────────────────────────────────╮
	--  │                           Misc                           │
	--  ╰──────────────────────────────────────────────────────────╯
	-- @comment (Comment)                          ; line and block comments
	-- @error                                      ; syntax/parser errors
	-- @none                                       ; completely disable the highlight
	-- @preproc (PreProc)                          ; various preprocessor directives & shebangs
	-- @define (Define)                            ; preprocessor definition directives
	-- @operator (Operator)                        ; symbolic operators (e.g. `+` / `*`)
	['@operator'] = { link = 'Operator' },
	-- Punctuation (Delimiter)
	-- @punctuation.delimiter                      ; delimiters (e.g. ` ; ` / `.` / `,`)
	-- ["@punctuation.delimiter"] = { fg = theme.syn.punct },
	-- @punctuation.bracket                        ; brackets (e.g. `()` / `{}` / `[]`)
	-- ["@punctuation.bracket"] = { fg = theme.syn.punct },
	-- @punctuation.special                        ; special symbols (e.g. `{}` in string interpolation)
	['@punctuation.special'] = { link = 'Operator' },
	--  ╭──────────────────────────────────────────────────────────╮
	--  │                         Literals                         │
	--  ╰──────────────────────────────────────────────────────────╯
	-- @string (String)                            ; string literals
	-- @string.regex                               ; regular expressions
	-- ["@string.regex"] = { fg = theme.syn.regex },
	-- @string.escape (SpecialChar)                ; escape sequences
	-- ["@string.escape"] = { fg = theme.syn.regex, bold = true },
	-- @string.special (SpecialChar)               ; other special strings (e.g. dates)

	-- @character (Character)                      ; character literals
	-- @character.special (Special)                ; special characters (e.g. wildcards)

	-- @boolean (Boolean)                          ; boolean literals
	-- @number (Number)                            ; numeric literals
	-- @float (Float)                              ; floating-point number literals
	--  ╭──────────────────────────────────────────────────────────╮
	--  │                        Functions                         │
	--  ╰──────────────────────────────────────────────────────────╯
	-- @function (Function)                        ; function definitions
	-- @function.builtin (Special)                 ; built-in functions
	-- @function.call                              ; function calls
	-- @function.macro (Macro)                     ; preprocessor macros

	-- @method (Function)                          ; method definitions
	-- @method.call                                ; method calls

	-- @constructor (Special)                      ; constructor calls and definitions
	-- ["@constructor.lua"] = { fg = theme.syn.keyword },
	['@constructor'] = { fg = c.purple }, -- interfaces
	-- @parameter (Identifier)                     ; parameters of a function
	['@parameter'] = { fg = c.cyan },    -- interfaces
	--  ╭──────────────────────────────────────────────────────────╮
	--  │                    Keywords (Keyword)                    │
	--  ╰──────────────────────────────────────────────────────────╯
	['@keyword'] = { link = 'Keyword' }, -- interfaces
	-- @keyword                                    ; various keywords
	-- @keyword.function                           ; keywords that define a function (e.g. `func` in Go, `def` in Python)
	-- @keyword.operator                           ; operators that are English words (e.g. `and` / `or`)
	-- ["@keyword.operator"] = { fg = theme.syn.operator, bold = true },
	-- @keyword.return                             ; keywords like `return` and `yield`
	-- ["@keyword.return"] = vim.tbl_extend("force", { fg = theme.syn.special3 }, config.keywordStyle),
	-- ["@keyword.luap"] = { link = "@string.regex" },
	-- @conditional (Conditional -> Statement)     ; keywords related to conditionals (e.g. `if` / `else`)
	-- @conditional.ternary                        ; Ternary operator: condition ? 1 : 2
	-- @repeat (Repeat)                            ; keywords related to loops (e.g. `for` / `while`)
	-- @debug (Debug)                              ; keywords related to debugging
	-- @label (Label)                              ; GOTO and other labels (e.g. `label:` in C)
	-- @include (Include)                          ; keywords for including modules (e.g. `import` / `from` in Python)
	-- @exception (Exception)                      ; keywords related to exceptions (e.g. `throw` / `catch`)
	-- ["@exception"] = vim.tbl_extend("force", { fg = theme.syn.special3 }, config.statementStyle),

	--  ╭──────────────────────────────────────────────────────────╮
	--  │                          Types                           │
	--  ╰──────────────────────────────────────────────────────────╯
	-- @type (Type)                                ; type or class definitions and annotations
	-- @type.builtin                               ; built-in types
	-- @type.definition (TypeDef)                  ; type definitions (e.g. `typedef` in C)
	-- @type.qualifier                             ; type qualifiers (e.g. `const`)

	-- @structure (Structure)

	-- @storageclass (StorageClass)                ; modifiers that affect storage in memory or life-time
	-- @attribute                                  ; attribute annotations (e.g. Python decorators)
	-- ["@attribute"] = { link = "Constant" },
	-- @field (Identifier)                         ; object and struct fields
	-- @property (Identifier)                      ; similar to `@field`
	['@property'] = { fg = c.cyan },
	--  ╭──────────────────────────────────────────────────────────╮
	--  │                       Identifiers                        │
	--  ╰──────────────────────────────────────────────────────────╯
	-- @variable (Identifier)                      ; various variable names
	['@variable'] = { fg = c.cyan },
	-- @variable.builtin                           ; built-in variable names (e.g. `this`)
	-- ["@variable.builtin"] = { fg = theme.syn.special2, italic = true },
	-- @constant (Constant)                        ; constant identifiers
	-- @constant.builtin (Special)                 ; built-in constant values
	-- @constant.macro (Define -> PreProc)         ; constants defined by the preprocessor

	-- @namespace (Identifier)                     ; modules or namespaces
	['@namespace'] = { link = 'Identifier' },

	-- @symbol                                     ; symbols or atoms
	-- ["@symbol"] = { fg = theme.syn.identifier },
	--  ╭──────────────────────────────────────────────────────────╮
	--  │                           Text                           │
	--  ╰──────────────────────────────────────────────────────────╯
	-- @text                                       ; non-structured text
	-- @text.strong                                ; bold text
	-- ["@text.strong"] = { bold = true },
	-- @text.emphasis                              ; text with emphasis
	-- ["@text.emphasis"] = { italic = true },
	-- @text.underline (Underlined)                ; underlined text
	-- @text.strike                                ; strikethrough text
	-- @text.title (Title)                         ; text that is part of a title
	-- ["@text.title"] = { link = "Function" },
	-- @text.literal (Comment)                     ; literal or verbatim text (e.g., inline code)
	-- ["@text.literal"] = { link = "String" },
	-- @text.quote                                 ; text quotations
	-- @text.uri (Underlined)                      ; URIs (e.g. hyperlinks)
	-- @text.math                                  ; math environments (e.g. `$ ... $` in LaTeX)
	-- @text.environment                           ; text environments of markup languages
	-- @text.environment.name                      ; text indicating the type of an environment
	-- @text.reference (Identifier)                ; text references, footnotes, citations, etc.

	-- @text.todo (Todo)                           ; todo notes
	-- @text.note                                  ; info notes
	-- ["@text.note"] = { fg = theme.ui.fg_reverse, bg = theme.diag.hint, bold = true },
	-- @text.warning                               ; warning notes
	-- ["@text.warning"] = { fg = theme.ui.fg_reverse, bg = theme.diag.warning, bold = true },
	-- @text.danger                                ; danger/error notes
	-- ["@text.danger"] = { fg = theme.ui.fg, bg = theme.diag.error, bold = true },
	-- @text.diff.add                              ; added text (for diff files)
	-- ["@text.diff.add"] = { fg = theme.vcs.added },
	-- @text.diff.delete                           ; deleted text (for diff files)
	-- ["@text.diff.delete"] = { fg = theme.vcs.removed },
	--  ╭──────────────────────────────────────────────────────────╮
	--  │                        Tags (Tag)                        │
	--  ╰──────────────────────────────────────────────────────────╯
	-- @tag                                        ; XML tag names
	['@tag'] = { fg = c.pink }, -- interfaces
	-- @tag.attribute                              ; XML tag attributes
	-- ["@tag.attribute"] = { fg = theme.syn.identifier },
	-- @tag.delimiter                              ; XML tag delimiter
	['@tag.delimiter'] = { fg = c.white }, -- interfaces
}

hls.ts = {
	['@type.typescript'] = { link = 'TypeDef' },
	['@type.tsx'] = { link = 'TypeDef' },
}

hls.dart = {
	['@lsp.type.source.dart'] = { link = 'Structure' },
	['@lsp.type.type.dart'] = { link = 'Type' },
}

hls.css = {
	cssBraces = { fg = c.fg },
	cssInclude = { fg = c.purple },
	cssTagName = { fg = c.yellow },
	cssClassName = { fg = c.yellow },
	cssPseudoClass = { fg = c.yellow },
	cssPseudoClassId = { fg = c.yellow },
	cssPseudoClassLang = { fg = c.yellow },
	cssIdentifier = { fg = c.yellow },
	cssProp = { fg = c.fg },
	cssDefinition = { fg = c.fg },
	cssAttr = { fg = c.orange },
	cssAttrRegion = { fg = c.orange },
	cssColor = { fg = c.orange },
	cssFunction = { fg = c.purple },
	cssFunctionName = { fg = c.yellow },
	cssVendor = { fg = c.orange },
	cssValueNumber = { fg = c.orange },
	cssValueLength = { fg = c.orange },
	cssUnitDecorators = { fg = c.orange },
	cssStyle = { fg = c.fg },
	cssImportant = { fg = c.blue },
	cssPropriety = { fg = c.purple },
}

hls.html = {
	htmlH1 = { fg = c.fg },
	htmlH2 = { fg = c.fg },
	htmlH3 = { fg = c.fg },
	htmlH4 = { fg = c.fg },
	htmlH5 = { fg = c.fg },
	htmlH6 = { fg = c.fg },
	htmlHead = { fg = c.fg },
	htmlTitle = { fg = c.fg },
	htmlArg = { fg = c.fg },
	htmlTag = { fg = c.blue },
	htmlTagN = { fg = c.blue },
	htmlTagName = { fg = c.blue },
	htmlComment = { fg = c.green },
	htmlLink = { fg = c.orange, underline = true },
}

hls.python = {
	['@punctuation.special.python'] = { link = 'Operator' },
}

hls.cobol = {
	['@division.cobol'] = { fg = c.purple, bold = true, underline = true },
	['@section.cobol'] = { fg = c.orange, bold = true },
	['@paragraph.cobol'] = { fg = c.white },

	['@constant.cobol'] = { link = "Constant" },
	['@variable.cobol'] = { link = "@variable" },
	['@keyword.cobol'] = { link = 'Keyword' },

	['@level_number.cobol'] = { fg = c.red },

	cobolCalls = { fg = c.yellow, bold = true },
	cobolParagraph = { fg = c.orange, bold = true },
	CobolDeclA = { fg = c.red },
	CobolDecl = { fg = c.red },
}

hls.editor = {
	CursorLineNR = { fg = c.secondary },
	BufferOffset = { fg = c.secondary },
	FloatBorder = { bg = 'None' },
	CursorLine = { bg = c.bg_highlight },
	ErrorMsg = { fg = c.red, bg = c.bg, underline = true },
	Folded = { bg = c.invisible },
	Keyword = { fg = c.purple },
	Label = { fg = c.green },
	LineNr = { fg = c.comments },
	MatchParen = { fg = c.white, bg = c.comments },
	ModeMsg = { fg = 'None', bg = 'None' },
	NonText = { fg = c.invisible, bg = c.bg },
	Number = { fg = c.orange },
	Search = { fg = c.bg, bg = c.secondary },
	SpecialComment = { fg = c.comments },
	SpecialKey = { fg = c.invisible, bg = c.bg },
	StorageClass = { fg = c.purple },
	Tag = { fg = c.purple },
	Title = { fg = c.red },
	VertSplit = { fg = c.black, bg = c.black },
	--  ╭──────────────────────────────────────────────────────────╮
	--  │                           foo                            │
	--  ╰──────────────────────────────────────────────────────────╯
	-- -- ColorColumn = { bg = c.red, fg = c.transparent },
	-- -- ColorColumn	Used for the columns set with 'colorcolumn'.
	-- -- Conceal		Placeholder characters substituted for concealed text (see 'conceallevel').
	-- Conceal = { fg = theme.ui.special, bold = true },
	-- -- CurSearch	Used for highlighting a search pattern under the cursor (see 'hlsearch').
	-- CurSearch = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },
	-- -- Cursor		Character under the cursor.
	-- Cursor = { fg = theme.ui.bg, bg = theme.ui.fg },
	-- -- lCursor		Character under the cursor when |language-mapping| is used (see 'guicursor').
	-- lCursor = { link = "Cursor" },
	-- -- CursorIM	Like Cursor, but used when in IME mode.
	-- CursorIM = { link = "Cursor" },
	-- -- CursorColumn	Screen-column at the cursor, when 'cursorcolumn' is set.
	-- CursorColumn = { link = "CursorLine" },
	-- -- CursorLine	Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
	-- CursorLine = { bg = theme.ui.bg_p2 },
	-- -- Directory	Directory names (and other special names in listings).
	-- Directory = { fg = theme.syn.fun },
	-- -- DiffAdd		Diff mode: Added line. |diff.txt|
	-- DiffAdd = { bg = theme.diff.add },
	-- -- DiffChange	Diff mode: Changed line. |diff.txt|
	-- DiffChange = { bg = theme.diff.change },
	-- -- DiffDelete	Diff mode: Deleted line. |diff.txt|
	-- DiffDelete = { fg = theme.vcs.removed, bg = theme.diff.delete },
	-- -- DiffText	Diff mode: Changed text within a changed line. |diff.txt|
	-- DiffText = { bg = theme.diff.text },
	-- -- EndOfBuffer	Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
	-- EndOfBuffer = { fg = theme.ui.bg },
	-- -- TermCursor	Cursor in a focused terminal.
	-- -- TermCursorNC	Cursor in an unfocused terminal.
	-- -- ErrorMsg	Error messages on the command line.
	-- ErrorMsg = { fg = theme.diag.error },
	-- -- WinSeparator	Separators between window splits.
	-- WinSeparator = { fg = theme.ui.bg_m3, bg = config.dimInactive and theme.ui.bg_dim or "NONE" },
	-- VertSplit = { link = "WinSeparator" },
	-- -- Folded		Line used for closed folds.
	-- Folded = { fg = theme.ui.special, bg = theme.ui.bg_p1 },
	-- -- FoldColumn	'foldcolumn'
	-- FoldColumn = { fg = theme.ui.nontext, bg = theme.ui.bg_gutter },
	-- -- SignColumn	Column where |signs| are displayed.
	-- SignColumn = { fg = theme.ui.special, bg = theme.ui.bg_gutter },
	-- -- IncSearch	'incsearch' highlighting; also used for the text replaced with ":s///c".
	-- IncSearch = { fg = theme.ui.fg_reverse, bg = theme.diag.warning },
	-- -- Substitute	|:substitute| replacement text highlighting.
	-- Substitute = { fg = theme.ui.fg, bg = theme.vcs.removed },
	-- -- LineNr		Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
	-- LineNr = { fg = theme.ui.nontext, bg = theme.ui.bg_gutter },
	-- -- LineNrAbove	Line number for when the 'relativenumber' option is set, above the cursor line.
	-- -- LineNrBelow	Line number for when the 'relativenumber' option is set, below the cursor line.
	-- -- CursorLineNr	Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
	-- CursorLineNr = { fg = theme.diag.warning, bg = theme.ui.bg_gutter, bold = true },
	-- -- CursorLineFold	Like FoldColumn when 'cursorline' is set for the cursor line.
	-- -- CursorLineSign	Like SignColumn when 'cursorline' is set for the cursor line.
	-- -- MatchParen	Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
	-- MatchParen = { fg = theme.diag.warning, bold = true },
	-- -- ModeMsg		'showmode' message (e.g., "-- INSERT --").
	-- ModeMsg = { fg = theme.diag.warning, bold = true },
	-- -- MsgArea		Area for messages and cmdline.
	-- MsgArea = vim.o.cmdheight == 0 and { link = "StatusLine" } or { fg = theme.ui.fg_dim },
	-- -- MsgSeparator	Separator for scrolled messages |msgsep|.
	-- MsgSeparator = { bg = vim.o.cmdheight == 0 and theme.ui.bg or theme.ui.bg_m3 },
	-- -- MoreMsg		|more-prompt|
	-- MoreMsg = { fg = theme.diag.info },
	-- -- NonText		'@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
	-- NonText = { fg = theme.ui.nontext },
	-- Normal		Normal text.
	-- Normal = { fg = theme.ui.fg, bg = theme.ui.bg},
	-- Normal = { bg = c.bg },
	-- -- NormalFloat	Normal text in floating windows.
	-- NormalFloat = { fg = theme.ui.float.fg, bg = theme.ui.float.bg },
	-- -- FloatBorder	Border of floating windows.
	-- FloatBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.float.bg_border },
	-- -- FloatTitle	Title of floating windows.
	-- FloatTitle = { fg = theme.ui.special, bg = theme.ui.float.bg_border, bold = true },
	-- -- NormalNC	Normal text in non-current windows.
	-- NormalNC = config.dimInactive and { fg = theme.ui.fg_dim, bg = theme.ui.bg_dim } or { link = "Normal" },
	-- -- Pmenu		Popup menu: Normal item.
	-- Pmenu = { fg = theme.ui.pmenu.fg, bg = theme.ui.pmenu.bg },
	-- -- PmenuSel	Popup menu: Selected item.
	-- PmenuSel = { fg = theme.ui.pmenu.fg_sel, bg = theme.ui.pmenu.bg_sel },
	-- -- PmenuSbar	Popup menu: Scrollbar.
	-- PmenuSbar = { bg = theme.ui.pmenu.bg_sbar },
	-- -- PmenuThumb	Popup menu: Thumb of the scrollbar.
	-- PmenuThumb = { bg = theme.ui.pmenu.bg_thumb },
	-- -- Question	|hit-enter| prompt and yes/no questions.
	-- Question = { link = "MoreMsg" },
	-- -- QuickFixLine	Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
	-- QuickFixLine = { bg = theme.ui.bg_p1 },
	-- -- Search		Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
	-- Search = { fg = theme.ui.fg, bg = theme.ui.bg_search },
	-- -- SpecialKey	Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
	-- SpecialKey = { fg = theme.ui.special },
	-- -- SpellBad	Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
	-- SpellBad = { undercurl = config.undercurl, underline = not config.undercurl, sp = theme.diag.error },
	-- -- SpellCap	Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
	-- SpellCap = { undercurl = config.undercurl, underline = not config.undercurl, sp = theme.diag.warning },
	-- -- SpellLocal	Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
	-- SpellLocal = { undercurl = config.undercurl, underline = not config.undercurl, sp = theme.diag.warning },
	-- -- SpellRare	Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
	-- SpellRare = { undercurl = config.undercurl, underline = not config.undercurl, sp = theme.diag.warning },
	-- -- StatusLine	Status line of current window.
	-- StatusLine = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
	-- -- StatusLineNC	Status lines of not-current windows. Note: If this is equal to "StatusLine", Vim will use "^^^" in the status line of the current window.
	-- StatusLineNC = { fg = theme.ui.nontext, bg = theme.ui.bg_m3 },
	-- -- TabLine		Tab pages line, not active tab page label.
	-- TabLine = { bg = theme.ui.bg_m3, fg = theme.ui.special },
	-- -- TabLineFill	Tab pages line, where there are no labels.
	-- TabLineFill = { bg = theme.ui.bg },
	-- -- TabLineSel	Tab pages line, active tab page label.
	-- TabLineSel = { fg = theme.ui.fg_dim, bg = theme.ui.bg_p1 },
	-- -- Title		Titles for output from ":set all", ":autocmd" etc.
	-- Title = { fg = theme.syn.fun, bold = true },
	-- -- Visual		Visual mode selection.
	-- Visual = { bg = theme.ui.bg_visual },
	-- -- VisualNOS	Visual mode selection when vim is "Not Owning the Selection".
	-- VisualNOS = { link = "Visual" },
	-- -- WarningMsg	Warning messages.
	-- WarningMsg = { fg = theme.diag.warning },
	-- -- Whitespace	"nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
	-- Whitespace = { fg = theme.ui.whitespace },
	-- -- WildMenu	Current match in 'wildmenu' completion.
	-- WildMenu = { link = "Pmenu" },
	-- -- WinBar		Window bar of current window.
	-- Winbar = { fg = theme.ui.fg_dim, bg = "NONE" },
	-- -- WinBarNC	Window bar of not-current windows.
	-- WinbarNC = { fg = theme.ui.fg_dim, bg = config.dimInactive and theme.ui.bg_dim or "NONE" },
	-- -- SignColumnSB = { link = "SignColumn" },
	-- -- NormalSB = { link = "Normal" },

	-- debugPC = { bg = theme.diff.delete },
	-- debugBreakpoint = { fg = theme.syn.special1, bg = theme.ui.bg_gutter },
	-- LspReferenceText = { bg = theme.diff.text },
	-- LspReferenceRead = { link = "LspReferenceText" },
	-- LspReferenceWrite = { bg = theme.diff.text, underline = true },
	-- DiagnosticError = { fg = theme.diag.error },
	-- DiagnosticWarn = { fg = theme.diag.warning },
	-- DiagnosticInfo = { fg = theme.diag.info },
	-- DiagnosticHint = { fg = theme.diag.hint },
	-- DiagnosticOk = { fg = theme.diag.ok },
	-- DiagnosticSignError = { fg = theme.diag.error, bg = theme.ui.bg_gutter },
	-- DiagnosticSignWarn = { fg = theme.diag.warning, bg = theme.ui.bg_gutter },
	-- DiagnosticSignInfo = { fg = theme.diag.info, bg = theme.ui.bg_gutter },
	-- DiagnosticSignHint = { fg = theme.diag.hint, bg = theme.ui.bg_gutter },
	-- DiagnosticVirtualTextError = { link = "DiagnosticError" },
	-- DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
	-- DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
	-- DiagnosticVirtualTextHint = { link = "DiagnosticHint" },
	-- DiagnosticUnderlineError = { undercurl = config.undercurl, underline = not config.undercurl, sp = theme.diag.error },
	-- DiagnosticUnderlineWarn = {
	-- 	undercurl = config.undercurl,
	-- 	underline = not config.undercurl,
	-- 	sp = theme.diag.warning,
	-- },
	-- DiagnosticUnderlineInfo = { undercurl = config.undercurl, underline = not config.undercurl, sp = theme.diag.info },
	-- DiagnosticUnderlineHint = { undercurl = config.undercurl, underline = not config.undercurl, sp = theme.diag.hint },
	--
	-- LspSignatureActiveParameter = { fg = theme.diag.warning },
	-- LspCodeLens = { fg = theme.syn.comment },
	--
	-- vcs
	-- diffAdded = { fg = theme.vcs.added },
	-- diffRemoved = { fg = theme.vcs.removed },
	-- diffDeleted = { fg = theme.vcs.removed },
	-- diffChanged = { fg = theme.vcs.changed },
	-- diffOldFile = { fg = theme.vcs.removed },
	-- diffNewFile = { fg = theme.vcs.added },
	-- diffFile = { fg = c.steelGray },
	-- diffLine = { fg = c.steelGray },
	-- diffIndexLine = { link = 'Identifier' },
}

hls.ext_marks = {
	-- DiagnosticUnnecessary = { link = 'Comment' },
	DiagnosticUnnecessary = { link = '@variable' },
}

function M.get_base_highlights() return utils.flatten(hls) end

function M.get_plugin_highlights()
	local all_hls = {}
	local plugin_files = vim.fn.glob(vim.fn.stdpath('config') .. '/lua/plugins' .. '/**/*.lua', true, true)

	for _, file in ipairs(plugin_files) do
		local is_installed, plugin = pcall(require, file:match('/(plugins/.*).lua'):gsub('/', '.'))

		if is_installed then
			if type(plugin) == 'table' then
				if plugin.highlights then -- plugin has highlights
					for group, highlight in pairs(plugin.highlights) do
						all_hls[group] = highlight
					end
				end
			end
		end
	end

	return all_hls
end

function M.get_all_highlights() return vim.tbl_extend('force', M.get_base_highlights(), M.get_plugin_highlights()) end

return M
