if vim.g.loaded_vimGrepSearch == 1 then
  return
end
vim.g.loaded_vimGrepSearch = 1

local vimGrepSearch=require("vimGrepSearch")

-- user commands here
vim.api.nvim_create_user_command(
  "VimGrepSearch",
  vimGrepSearch.setup,
  {})

vim.keymap.set( 'n', '<leader>S',function() vimGrepSearch.searchWindow() end, {silent = true, nowait = true, noremap = true}) 
