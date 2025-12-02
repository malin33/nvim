vim.cmd(":packadd termdebug")
vim.keymap.set( 'n', '<F5>', ':Continue<CR>')
vim.keymap.set( 'n', '<F9>', ':Break<CR>')
vim.keymap.set( 'n', '<F10>', ':Over<CR>')
vim.keymap.set( 'n', '<F11>', ':Step<CR>')


-- Search file in Path
vim.keymap.set("n", "<leader>ff", function()
    return ":find **/*"
end,{expr=true})

local function getSource()
  print("Source is")
end

-- let g:termdebug_wide=1

-- simple run&debug for single file c++
vim.keymap.set("n", "<leader><F5>", function()
  local fileName = vim.fn.expand("%:p")
  local baseName = vim.fn.expand("%:r")
  vim.cmd(string.format(":!g++ %s -o %s -g", fileName, baseName))

  vim.cmd(string.format(":Termdebug %s",baseName))
  vim.cmd(":call TermDebugSendCommand('start')")
  vim.cmd(string.format(":Var"))
  vim.cmd(string.format(":Source"))
  vim.cmd(string.format(":wincmd L"))
end,opt)

vim.keymap.set("n", "<leader><F6>", function()
  vim.cmd(string.format(":Gdb"))
  vim.cmd(":call TermDebugSendCommand('quit')")
  vim.cmd(":call TermDebugSendCommand('y')")
  vim.cmd(":call TermDebugSendCommand('<CR>')")
end,opt)
