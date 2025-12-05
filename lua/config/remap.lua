-- set leaderkey
vim.g.mapleader = " "
vim.keymap.set("n","<leader>pv", vim.cmd.Ex)

-- copy/paste to system clipboard
vim.keymap.set({ "n", "x"}, "<leader>y", [["+y]]) 
vim.keymap.set({ "n", "x"}, "<leader>p", [["+p]]) 

-- Browse old files, buffert
vim.keymap.set( 'n', '<leader>bo',function() vim.cmd('browse oldfiles') end, opt) 
vim.keymap.del('n', '<C-l>')
vim.keymap.set( 'n', '<C-l>', ':bn<CR>')
vim.keymap.set( 'n', '<C-h>', ':bp<CR>')
vim.keymap.set( 'n', '<leader>bd', ':bd<CR>')
vim.keymap.set( 'n', '<leader>b', ':ls<CR>:b<space>')

-- Format clang, save line nr and return to same after format
vim.keymap.set( 'n', '<leader>FF',function() 
    local lineno =vim.api.nvim_win_get_cursor(0)
    local cmdString=":%!clang-format -style=file:"..string.format("%s.clang-format",vim.env.repoPath)
    local alternativeCmdString='%!clang-format -style="{BasedOnStyle: Google, BreakBeforeBraces: Stroustrup}"'

    vim.cmd(alternativeCmdString)
    vim.api.nvim_win_set_cursor(0,lineno)
end, opt) 

-- String search for c++ files using vimgrep
vim.keymap.set("n", "<leader>fs", function()
    local user_input = vim.fn.input("vimgrep string *{cc,cpp,h}: ")
    vim.cmd(string.format(":vim! /%s/jg %s**/*{cc,cpp,h}", user_input, vim.env.repoPath))
    vim.cmd(":copen")
end,opt)

-- Search file in Path
vim.keymap.set("n", "<leader>ff", function()
    return ":find **/*"
end,{expr=true})

-- diff buff with saved file
vim.cmd("command DiffOrig vert new | set buftype=nofile | read ++edit # | silent 0d_ | diffthis | wincmd p | diffthis")
vim.keymap.set("n", "<leader>do", function()
    vim.cmd(":DiffOrig")
end,opt)

--tabs
vim.keymap.set( 'n', '<leader>tn', ':tabnew<CR>')
vim.keymap.set( 'n', '<leader>tc', ':tabc<CR>')
vim.keymap.set( 'n', '<leader>tl', ':tabn<CR>')
vim.keymap.set( 'n', '<leader>th', ':tabp<CR>')
