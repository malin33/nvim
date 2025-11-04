vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

--vim.opt.guicursor = ""
vim.o.guicursor = 'n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'

-- timeout leaderkey
vim.opt.timeoutlen=400

vim.g.netrw_keepdir=0

-- case insensitivity/smart for search
vim.opt.ignorecase = true
vim.opt.smartcase = true
