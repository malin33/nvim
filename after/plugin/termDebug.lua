vim.cmd(":packadd termdebug")

vim.keymap.set( 'n', '<F5>', ':Continue<CR>')
vim.keymap.set( 'n', '<F9>', ':Break<CR>')
vim.keymap.set( 'n', '<leader><F9>', ':Clear<CR>')
vim.keymap.set( 'n', '<F10>', ':Over<CR>')
vim.keymap.set( 'n', '<F11>', ':Step<CR>')

-- simple run&debug for single file c++
vim.keymap.set("n", "<leader><F5>", function()
  local currentFileName = vim.fn.expand("%:p")
  local compiledFileName = vim.fn.expand("%:r")
  vim.cmd(string.format(":!g++ %s -o %s -g", currentFileName, compiledFileName))
  
  vim.cmd(string.format(":Termdebug %s",compiledFileName))
  vim.cmd(":call TermDebugSendCommand('start')")
  vim.cmd(string.format(":Var"))
  vim.cmd(string.format(":Source"))
  vim.cmd(string.format(":wincmd L"))
end,opt)

-- close debug session
vim.keymap.set("n", "<leader><F6>", function()
  vim.cmd(string.format(":Gdb"))
  vim.cmd(":call TermDebugSendCommand('quit')")
  vim.cmd(":call TermDebugSendCommand('y')")
  vim.cmd(":call TermDebugSendCommand('<CR>')")
  vim.cmd(":q")
end,opt)
