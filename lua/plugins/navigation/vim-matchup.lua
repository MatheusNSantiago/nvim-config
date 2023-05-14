local M = {}

function M.setup()
	return {
		'andymass/vim-matchup',
		config = M.config,
	}
end

function M.config()
end

M.highlights = {
	MatchParen = {link = "CursorLine"}
}

return M
