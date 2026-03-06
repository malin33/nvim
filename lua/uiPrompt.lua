local M={}

local uiStruct={
  header={
  },
  info={
  },
  cmd={
  },
}

local function create_ui_window()
  local infoWidth = 50
  local infoHeight = 5
 
  local ui=vim.api.nvim_list_uis()[1]
  local posCol=math.floor((ui.width - infoWidth) / 2)
  local posRow=math.floor((ui.height - infoHeight) / 2)

  local headerConf={
    relative = "editor",
    width = infoWidth,
    height = 1,
    anchor = 'NW',
    style = "minimal",
    col = posCol,
    row = posRow-5,
    zindex = 2,
    border = 'none',
  }
  local infoConf={
    relative = "editor",
    width = infoWidth,
    height = infoHeight,
    anchor = 'NW',
    style = "minimal",
    col = posCol,
    row = posRow,
    zindex = 1,
    border = 'rounded',
  }
  local cmdConf={
    relative = "editor",
    width = infoWidth,
  height = 1,
    anchor = 'NW',
    style = "minimal",
    col = posCol,
    row = posRow+infoHeight+2,
    border = 'rounded',
  } 

  uiStruct.header.buf=vim.api.nvim_create_buf(false,true)
  uiStruct.header.win=vim.api.nvim_open_win(uiStruct.header.buf,false,headerConf)
  
  uiStruct.info.buf=vim.api.nvim_create_buf(false,true)
  uiStruct.info.win=vim.api.nvim_open_win(uiStruct.info.buf,true,infoConf)

  uiStruct.cmd.buf=vim.api.nvim_create_buf(false,true)
  uiStruct.cmd.win=vim.api.nvim_open_win(uiStruct.cmd.buf,true,cmdConf)

  vim.api.nvim_set_option_value('winhl', 'Normal:Label', { win = uiStruct.header.win })
  vim.api.nvim_set_option_value('winhl', 'Normal:Label', { win = uiStruct.info.win })
  vim.api.nvim_set_option_value('winhl', 'Normal:Label', { win = uiStruct.cmd.win })
end

local function close_windows()
  for name,element in pairs(uiStruct) do
    vim.api.nvim_win_close(element.win,true)
  end
end

local function user_prompt()
  print("enter")
  local user_input=table.concat(vim.api.nvim_buf_get_lines(uiStruct.cmd.buf,0,-1,false))
  print(user_input)
end

local function set_keymaps()

  vim.keymap.set('n', '<leader>',function() 
    close_windows()
  end, {buffer=uiStruct.cmd.buf,silent = true, nowait = true, noremap = true } )

  vim.keymap.set('n', '<CR>',function()
    user_prompt()
  end, {buffer=uiStruct.cmd.buf,silent = true, nowait = true, noremap = true } )

end

local function fill_info()
  local someInfo={
    "/path/dd",
    "*.cc",
    "ripgrep",
  }
  local infoStruct={
    "Search Path: ",
    "Include endings: ",
    "Search Engine: ",
  }
  for idx,_ in ipairs(infoStruct) do
    vim.api.nvim_buf_set_lines(uiStruct.info.buf, idx, -1, false, {infoStruct[idx] .. someInfo[idx]})
  end
end

function M.main()
  create_ui_window()
  set_keymaps()
  fill_info()
end

M.main()

return M 
