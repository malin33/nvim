if vim.g.loaded_uiGrepSearch == 1 then
  return
end
vim.g.loaded_uiGrepSearch = 1
vim.g.loaded_uiGrepSearchPath=(vim.fn.getcwd())
vim.g.loaded_uiGrepSearchEndings=""

local uiGrepSearch=require("uiGrepSearch")

-- user commands here
vim.api.nvim_create_user_command(
  "UiGrepSearch",
  uiGrepSearch.main,
  {})

vim.keymap.set( 'n', '<leader>fs',function()
  uiGrepSearch.main()
end, {silent = true, nowait = true, noremap = true}) 

vim.keymap.set( 'n', '<leader>sp',function()
  uiGrepSearch.setSearchPath() 
end, {silent = true, nowait = true, noremap = true}) 
