local opt = vim.opt

opt.relativenumber = true
opt.number = true

vim.cmd("let g:netrw_liststyle = 3")

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- search settings
opt.ignorecase = true -- case insensitive searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- highlight cursor line
opt.cursorline = true

-- turn on termguicolors (requires a true color terminal, i use kitty)
opt.termguicolors = true

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- remember undo history across sessions
opt.undofile = true
