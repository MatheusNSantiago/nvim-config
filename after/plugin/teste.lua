--[[ utils.set_hls(require("colorscheme").get_plugin_highlights())
local palette = {
	-- Bg Shades
	sumiInk0 = "#16161D",
	sumiInk1 = "#181820",
	sumiInk2 = "#1a1a22",
	sumiInk3 = "#1F1F28",
	sumiInk4 = "#2A2A37",
	sumiInk5 = "#363646",
	sumiInk6 = "#54546D", --fg
	-- Popup and Floats
	waveBlue1 = "#223249",
	waveBlue2 = "#2D4F67",
	-- Diff and Git
	winterGreen = "#2B3328",
	winterYellow = "#49443C",
	winterRed = "#43242B",
	winterBlue = "#252535",
	autumnGreen = "#76946A",
	autumnRed = "#C34043",
	autumnYellow = "#DCA561",
	-- Diag
	samuraiRed = "#E82424",
	roninYellow = "#FF9E3B",
	waveAqua1 = "#6A9589",
	dragonBlue = "#658594",
	-- Fg and Comments
	oldWhite = "#C8C093",
	fujiWhite = "#DCD7BA",
	fujiGray = "#727169",
	oniViolet = "#957FB8",
	oniViolet2 = "#b8b4d0",
	crystalBlue = "#7E9CD8",
	springViolet1 = "#938AA9",
	springViolet2 = "#9CABCA",
	springBlue = "#7FB4CA",
	lightBlue = "#A3D4D5", -- unused yet
	waveAqua2 = "#7AA89F", -- improve lightness: desaturated greenish Aqua
	-- waveAqua2  = "#68AD99",
	-- waveAqua4  = "#7AA880",
	-- waveAqua5  = "#6CAF95",
	-- waveAqua3  = "#68AD99",

	springGreen = "#98BB6C",
	boatYellow1 = "#938056",
	boatYellow2 = "#C0A36E",
	carpYellow = "#E6C384",
	sakuraPink = "#D27E99",
	waveRed = "#E46876",
	peachRed = "#FF5D62",
	surimiOrange = "#FFA066",
	katanaGray = "#717C7C",
	dragonBlack0 = "#0d0c0c",
	dragonBlack1 = "#12120f",
	dragonBlack2 = "#1D1C19",
	dragonBlack3 = "#181616",
	dragonBlack4 = "#282727",
	dragonBlack5 = "#393836",
	dragonBlack6 = "#625e5a",
	dragonWhite = "#c5c9c5",
	dragonGreen = "#87a987",
	dragonGreen2 = "#8a9a7b",
	dragonPink = "#a292a3",
	dragonOrange = "#b6927b",
	dragonOrange2 = "#b98d7b",
	dragonGray = "#a6a69c",
	dragonGray2 = "#9e9b93",
	dragonGray3 = "#7a8382",
	dragonBlue2 = "#8ba4b0",
	dragonViolet = "#8992a7",
	dragonRed = "#c4746e",
	dragonAqua = "#8ea4a2",
	dragonAsh = "#737c73",
	dragonTeal = "#949fb5",
	dragonYellow = "#c4b28a", --"#a99c8b",
	-- "#8a9aa3",

	lotusInk1 = "#545464",
	lotusInk2 = "#43436c",
	lotusGray = "#dcd7ba",
	lotusGray2 = "#716e61",
	lotusGray3 = "#8a8980",
	lotusWhite0 = "#d5cea3",
	lotusWhite1 = "#dcd5ac",
	lotusWhite2 = "#e5ddb0",
	lotusWhite3 = "#f2ecbc",
	lotusWhite4 = "#e7dba0",
	lotusWhite5 = "#e4d794",
	lotusViolet1 = "#a09cac",
	lotusViolet2 = "#766b90",
	lotusViolet3 = "#c9cbd1",
	lotusViolet4 = "#624c83",
	lotusBlue1 = "#c7d7e0",
	lotusBlue2 = "#b5cbd2",
	lotusBlue3 = "#9fb5c9",
	lotusBlue4 = "#4d699b",
	lotusBlue5 = "#5d57a3",
	lotusGreen = "#6f894e",
	lotusGreen2 = "#6e915f",
	lotusGreen3 = "#b7d0ae",
	lotusPink = "#b35b79",
	lotusOrange = "#cc6d00",
	lotusOrange2 = "#e98a00",
	lotusYellow = "#77713f",
	lotusYellow2 = "#836f4a",
	lotusYellow3 = "#de9800",
	lotusYellow4 = "#f9d791",
	lotusRed = "#c84053",
	lotusRed2 = "#d7474b",
	lotusRed3 = "#e82424",
	lotusRed4 = "#d9a594",
	lotusAqua = "#597b75",
	lotusAqua2 = "#5e857a",
	lotusTeal1 = "#4e8ca2",
	lotusTeal2 = "#6693bf",
	lotusTeal3 = "#5a7785",
	lotusCyan = "#d7e3d8",
}

local theme = {
	ui = {
		fg = palette.fujiWhite,
		fg_dim = palette.oldWhite,
		fg_reverse = palette.waveBlue1,
		bg_dim = palette.sumiInk1,
		bg_gutter = palette.sumiInk4,
		bg_m3 = palette.sumiInk0,
		bg_m2 = palette.sumiInk1,
		bg_m1 = palette.sumiInk2,
		bg = palette.sumiInk3,
		bg_p1 = palette.sumiInk4,
		bg_p2 = palette.sumiInk5,
		special = palette.springViolet1,
		nontext = palette.sumiInk6,
		whitespace = palette.sumiInk6,
		bg_search = palette.waveBlue2,
		bg_visual = palette.waveBlue1,
		pmenu = {
			fg = palette.fujiWhite,
			fg_sel = "none", -- This is important to make highlights pass-through
			bg = palette.waveBlue1,
			bg_sel = palette.waveBlue2,
			bg_sbar = palette.waveBlue1,
			bg_thumb = palette.waveBlue2,
		},
		float = {
			fg = palette.oldWhite,
			bg = palette.sumiInk0,
			fg_border = palette.sumiInk6,
			bg_border = palette.sumiInk0,
		},
	},
	syn = {
		string = palette.springGreen,
		variable = "none",
		number = palette.sakuraPink,
		constant = palette.surimiOrange,
		identifier = palette.carpYellow,
		-- parameter  = "#C3B1B1",
		-- parameter  = "#B1ADC8",
		-- parameter  = "#b8b4d0",
		parameter = palette.oniViolet2,
		-- parameter = "#d5a4a6",
		-- parameter  = "#C8ADAD",
		-- parameter  = "#d7a8a8",
		fun = palette.crystalBlue,
		statement = palette.oniViolet,
		keyword = palette.oniViolet,
		operator = palette.boatYellow2,
		preproc = palette.waveRed, --lightBlue? deserves its own color
		type = palette.waveAqua2,
		regex = palette.boatYellow2,
		deprecated = palette.katanaGray,
		comment = palette.fujiGray,
		punct = palette.springViolet2,
		special1 = palette.springBlue,
		special2 = palette.waveRed,
		special3 = palette.peachRed,
	},
	vcs = {
		added = palette.autumnGreen,
		removed = palette.autumnRed,
		changed = palette.autumnYellow,
	},
	diff = {
		add = palette.winterGreen,
		delete = palette.winterRed,
		change = palette.winterBlue,
		text = palette.winterYellow,
	},
	diag = {
		ok = palette.springGreen,
		error = palette.samuraiRed,
		warning = palette.roninYellow,
		info = palette.dragonBlue,
		hint = palette.waveAqua1,
	},
	term = {
		palette.sumiInk0, -- black
		palette.autumnRed, -- red
		palette.autumnGreen, -- green
		palette.boatYellow2, -- yellow
		palette.crystalBlue, -- blue
		palette.oniViolet, -- magenta
		palette.waveAqua1, -- cyan
		palette.oldWhite, -- white
		palette.fujiGray, -- bright black
		palette.samuraiRed, -- bright red
		palette.springGreen, -- bright green
		palette.carpYellow, -- bright yellow
		palette.springBlue, -- bright blue
		palette.springViolet1, -- bright magenta
		palette.waveAqua2, -- bright cyan
		palette.fujiWhite, -- bright white
		palette.surimiOrange, -- extended color 1
		palette.peachRed, -- extended color 2
	},
}

local c = require("utils.colors")
utils.set_hls({
	-- CursorLineNR = { fg = c.secondary },
	-- BufferOffset = { fg = c.secondary },
	-- FloatBorder = { bg = "None" },
	-- CursorLine = { bg = c.bg_highlight },
	-- ErrorMsg = { fg = c.red, bg = c.bg, underline = true },
	-- Float = { fg = c.red },
	-- Folded = { bg = c.invisible },
	-- Keyword = { fg = c.purple },
	-- Label = { fg = c.green },
	-- LineNr = { fg = c.comments },
	-- MatchParen = { fg = c.white, bg = c.comments },
	-- ModeMsg = { fg = "None", bg = "None" },
	-- NonText = { fg = c.invisibles, bg = c.bg },
	-- Number = { fg = c.orange },
	-- Search = { fg = c.bg, bg = c.secondary },
	-- SpecialComment = { fg = c.comments },
	-- SpecialKey = { fg = c.invisibles, bg = c.bg },
	-- StorageClass = { fg = c.purple },
	-- Tag = { fg = c.purple },
	-- Title = { fg = c.red },
	-- VertSplit = { fg = c.black, bg = c.black },
	--  ╭──────────────────────────────────────────────────────────╮
	--  │                           foo                            │
	--  ╰──────────────────────────────────────────────────────────╯
	-- ColorColumn	Used for the columns set with 'colorcolumn'.
	ColorColumn = { bg = theme.ui.bg_p1 },
	-- Conceal		Placeholder characters substituted for concealed text (see 'conceallevel').
	Conceal = { fg = theme.ui.special, bold = true },
	-- CurSearch	Used for highlighting a search pattern under the cursor (see 'hlsearch').
	CurSearch = { fg = theme.ui.fg, bg = theme.ui.bg_search, bold = true },
	-- Cursor		Character under the cursor.
	Cursor = { fg = theme.ui.bg, bg = theme.ui.fg },
	-- lCursor		Character under the cursor when |language-mapping| is used (see 'guicursor').
	lCursor = { link = "Cursor" },
	-- CursorIM	Like Cursor, but used when in IME mode.
	CursorIM = { link = "Cursor" },
	-- CursorColumn	Screen-column at the cursor, when 'cursorcolumn' is set.
	CursorColumn = { link = "CursorLine" },
	-- CursorLine	Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
	CursorLine = { bg = theme.ui.bg_p2 },
	-- Directory	Directory names (and other special names in listings).
	Directory = { fg = theme.syn.fun },
	-- DiffAdd		Diff mode: Added line. |diff.txt|
	DiffAdd = { bg = theme.diff.add },
	-- DiffChange	Diff mode: Changed line. |diff.txt|
	DiffChange = { bg = theme.diff.change },
	-- DiffDelete	Diff mode: Deleted line. |diff.txt|
	DiffDelete = { fg = theme.vcs.removed, bg = theme.diff.delete },
	-- DiffText	Diff mode: Changed text within a changed line. |diff.txt|
	DiffText = { bg = theme.diff.text },
	-- EndOfBuffer	Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
	EndOfBuffer = { fg = theme.ui.bg },
	-- TermCursor	Cursor in a focused terminal.
	-- TermCursorNC	Cursor in an unfocused terminal.
	-- ErrorMsg	Error messages on the command line.
	ErrorMsg = { fg = theme.diag.error },
	-- WinSeparator	Separators between window splits.
	---- WinSeparator = { fg = theme.ui.bg_m3, bg = "NONE" },
	VertSplit = { link = "WinSeparator" },
	-- Folded		Line used for closed folds.
	Folded = { fg = theme.ui.special, bg = theme.ui.bg_p1 },
	-- FoldColumn	'foldcolumn'
	FoldColumn = { fg = theme.ui.nontext, bg = theme.ui.bg_gutter },
	-- SignColumn	Column where |signs| are displayed.
	---- SignColumn = { fg = theme.ui.special, bg = theme.ui.bg_gutter },
	-- IncSearch	'incsearch' highlighting; also used for the text replaced with ":s///c".
	IncSearch = { fg = theme.ui.fg_reverse, bg = theme.diag.warning },
	-- Substitute	|:substitute| replacement text highlighting.
	Substitute = { fg = theme.ui.fg, bg = theme.vcs.removed },
	-- LineNr		Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
	LineNr = { fg = theme.ui.nontext, bg = theme.ui.bg_gutter },
	-- LineNrAbove	Line number for when the 'relativenumber' option is set, above the cursor line.
	-- LineNrBelow	Line number for when the 'relativenumber' option is set, below the cursor line.
	-- CursorLineNr	Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
	CursorLineNr = { fg = theme.diag.warning, bg = theme.ui.bg_gutter, bold = true },
	-- CursorLineFold	Like FoldColumn when 'cursorline' is set for the cursor line.
	-- CursorLineSign	Like SignColumn when 'cursorline' is set for the cursor line.
	-- MatchParen	Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
	MatchParen = { fg = theme.diag.warning, bold = true },
	-- ModeMsg		'showmode' message (e.g., "-- INSERT --").
	ModeMsg = { fg = theme.diag.warning, bold = true },
	-- MsgArea		Area for messages and cmdline.
	MsgArea = vim.o.cmdheight == 0 and { link = "StatusLine" } or { fg = theme.ui.fg_dim },
	-- MsgSeparator	Separator for scrolled messages |msgsep|.
	MsgSeparator = { bg = vim.o.cmdheight == 0 and theme.ui.bg or theme.ui.bg_m3 },
	-- MoreMsg		|more-prompt|
	MoreMsg = { fg = theme.diag.info },
	-- NonText		'@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
	NonText = { fg = theme.ui.nontext },
	-- Normal		Normal text.
	Normal = { fg = theme.ui.fg, bg = theme.ui.bg },
	-- NormalFloat	Normal text in floating windows.
	NormalFloat = { fg = theme.ui.float.fg, bg = theme.ui.float.bg },
	-- FloatBorder	Border of floating windows.
	FloatBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.float.bg_border },
	-- FloatTitle	Title of floating windows.
	FloatTitle = { fg = theme.ui.special, bg = theme.ui.float.bg_border, bold = true },
	-- NormalNC	Normal text in non-current windows.
	NormalNC = { link = "Normal" },
	-- Pmenu		Popup menu: Normal item.
	Pmenu = { fg = theme.ui.pmenu.fg, bg = theme.ui.pmenu.bg },
	-- PmenuSel	Popup menu: Selected item.
	PmenuSel = { fg = theme.ui.pmenu.fg_sel, bg = theme.ui.pmenu.bg_sel },
	-- PmenuSbar	Popup menu: Scrollbar.
	PmenuSbar = { bg = theme.ui.pmenu.bg_sbar },
	-- PmenuThumb	Popup menu: Thumb of the scrollbar.
	PmenuThumb = { bg = theme.ui.pmenu.bg_thumb },
	-- Question	|hit-enter| prompt and yes/no questions.
	Question = { link = "MoreMsg" },
	-- QuickFixLine	Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
	QuickFixLine = { bg = theme.ui.bg_p1 },
	-- Search		Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
	Search = { fg = theme.ui.fg, bg = theme.ui.bg_search },
	-- SpecialKey	Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
	SpecialKey = { fg = theme.ui.special },
	-- SpellBad	Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
	SpellBad = { undercurl = true, underline = false, sp = theme.diag.error },
	-- SpellCap	Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
	SpellCap = { undercurl = true, underline = false, sp = theme.diag.warning },
	-- SpellLocal	Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
	SpellLocal = { undercurl = true, underline = not true, sp = theme.diag.warning },
	-- SpellRare	Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
	SpellRare = { undercurl = true, underline = not true, sp = theme.diag.warning },
	-- StatusLine	Status line of current window.
	StatusLine = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
	-- StatusLineNC	Status lines of not-current windows. Note: If this is equal to "StatusLine", Vim will use "^^^" in the status line of the current window.
	StatusLineNC = { fg = theme.ui.nontext, bg = theme.ui.bg_m3 },
	-- TabLine		Tab pages line, not active tab page label.
	TabLine = { bg = theme.ui.bg_m3, fg = theme.ui.special },
	-- TabLineFill	Tab pages line, where there are no labels.
	TabLineFill = { bg = theme.ui.bg },
	-- TabLineSel	Tab pages line, active tab page label.
	TabLineSel = { fg = theme.ui.fg_dim, bg = theme.ui.bg_p1 },
	-- Title		Titles for output from ":set all", ":autocmd" etc.
	Title = { fg = theme.syn.fun, bold = true },
	-- Visual		Visual mode selection.
	Visual = { bg = theme.ui.bg_visual },
	-- VisualNOS	Visual mode selection when vim is "Not Owning the Selection".
	VisualNOS = { link = "Visual" },
	-- WarningMsg	Warning messages.
	WarningMsg = { fg = theme.diag.warning },
	-- Whitespace	"nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
	Whitespace = { fg = theme.ui.whitespace },
	-- WildMenu	Current match in 'wildmenu' completion.
	WildMenu = { link = "Pmenu" },
	-- WinBar		Window bar of current window.
	Winbar = { fg = theme.ui.fg_dim, bg = "NONE" },
	-- WinBarNC	Window bar of not-current windows.
	WinbarNC = { fg = theme.ui.fg_dim, bg = "NONE" },
	SignColumnSB = { link = "SignColumn" },
	NormalSB = { link = "Normal" },
	debugPC = { bg = theme.diff.delete },
	debugBreakpoint = { fg = theme.syn.special1, bg = theme.ui.bg_gutter },
	LspReferenceText = { bg = theme.diff.text },
	LspReferenceRead = { link = "LspReferenceText" },
	LspReferenceWrite = { bg = theme.diff.text, underline = true },
	DiagnosticError = { fg = theme.diag.error },
	DiagnosticWarn = { fg = theme.diag.warning },
	DiagnosticInfo = { fg = theme.diag.info },
	DiagnosticHint = { fg = theme.diag.hint },
	DiagnosticOk = { fg = theme.diag.ok },
	DiagnosticSignError = { fg = theme.diag.error, bg = theme.ui.bg_gutter },
	DiagnosticSignWarn = { fg = theme.diag.warning, bg = theme.ui.bg_gutter },
	DiagnosticSignInfo = { fg = theme.diag.info, bg = theme.ui.bg_gutter },
	DiagnosticSignHint = { fg = theme.diag.hint, bg = theme.ui.bg_gutter },
	DiagnosticVirtualTextError = { link = "DiagnosticError" },
	DiagnosticVirtualTextWarn = { link = "DiagnosticWarn" },
	DiagnosticVirtualTextInfo = { link = "DiagnosticInfo" },
	DiagnosticVirtualTextHint = { link = "DiagnosticHint" },
	DiagnosticUnderlineError = { undercurl = true, underline = not true, sp = theme.diag.error },
	DiagnosticUnderlineWarn = {
		undercurl = true,
		underline = not true,
		sp = theme.diag.warning,
	},
	DiagnosticUnderlineInfo = { undercurl = true, underline = not true, sp = theme.diag.info },
	DiagnosticUnderlineHint = { undercurl = true, underline = not true, sp = theme.diag.hint },
	LspSignatureActiveParameter = { fg = theme.diag.warning },
	LspCodeLens = { fg = theme.syn.comment },
	-- vcs
	diffAdded = { fg = theme.vcs.added },
	diffRemoved = { fg = theme.vcs.removed },
	diffDeleted = { fg = theme.vcs.removed },
	diffChanged = { fg = theme.vcs.changed },
	diffOldFile = { fg = theme.vcs.removed },
	diffNewFile = { fg = theme.vcs.added },
	-- diffFile = { fg = c.steelGray },
	-- diffLine = { fg = c.steelGray },
	-- diffIndexLine = { link = 'Identifier' },

}) ]]
