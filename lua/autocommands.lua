local api = vim.api

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- troca entre relative e absolute line numbers
api.nvim_create_autocmd({ "InsertEnter" }, {
	callback = function()
		vim.opt.relativenumber = false
	end,
})
api.nvim_create_autocmd({ "InsertLeave" }, {
	callback = function()
		vim.opt.relativenumber = true
	end,
})

-- create directories when needed, when saving a file
api.nvim_create_autocmd("BufWritePre", {
	group = api.nvim_create_augroup("auto_create_dir", { clear = true }),
	command = [[call mkdir(expand('<afile>:p:h'), 'p')]],
})

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
	"BufReadPost",
	{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Strip trailing spaces before write
api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd([[ %s/\s\+$//e ]])
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function(event)
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
