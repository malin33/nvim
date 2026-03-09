local M={}

local UI_WIDTH=60
local UI_HEIGHT=2
local UI=vim.api.nvim_list_uis()[1]

local uiStruct={
  header={
    buf={},
    win={},
    cs={
      size={},
      pos={},
      conf={},
    },
    txt={},
  },
  info={
    buf={},
    win={},
    cs={
      size={},
      pos={},
      conf={},
    },
    txt={
      "Search path:",
      "File extensions:"
    },
  },
  cmd={
    buf={},
    win={},
    cs={
      size={},
      pos={},
      conf={}
    },
  },
}

local function ui_config()
  
  -- header
  uiStruct.header.cs.size={
    height=UI_HEIGHT,
    width=UI_WIDTH,
  }
  uiStruct.header.cs.pos={
    x=math.floor((UI.width - uiStruct.header.cs.size.width) / 2),
    y=math.floor((UI.height - uiStruct.header.cs.size.height) / 2),
  }
  uiStruct.header.cs.conf={
    relative = "editor",
    width = uiStruct.header.cs.size.width,
    height = 1,
    anchor = 'NW',
    style = "minimal",
    col = uiStruct.header.cs.pos.x,
    row = uiStruct.header.cs.pos.y-5,
    zindex = 2,
    border = 'none',
  }
  
  -- info
  uiStruct.info.cs.size={
    height=UI_HEIGHT,
    width=UI_WIDTH,
  }
  uiStruct.info.cs.pos={
    x=math.floor((UI.width - uiStruct.info.cs.size.width) / 2),
    y=math.floor((UI.height - uiStruct.info.cs.size.height) / 2),
  }
  uiStruct.info.cs.conf={
    relative = "editor",
    width = uiStruct.info.cs.size.width,
    height = uiStruct.info.cs.size.height,
    anchor = 'NW',
    style = "minimal",
    col = uiStruct.info.cs.pos.x,
    row = uiStruct.info.cs.pos.y,
    zindex = 2,
    border = 'rounded',
  }

  -- cmd
  uiStruct.cmd.cs.size={
    height=UI_HEIGHT,
    width=UI_WIDTH,
  }
  uiStruct.cmd.cs.pos={
    x=math.floor((UI.width - uiStruct.cmd.cs.size.width) / 2),
    y=math.floor((UI.height - uiStruct.cmd.cs.size.height) / 2),
  }
  uiStruct.cmd.cs.conf={
    relative = "editor",
    width = uiStruct.cmd.cs.size.width,
    height = 1,
    anchor = 'NW',
    style = "minimal",
    col = uiStruct.cmd.cs.pos.x,
    row = uiStruct.cmd.cs.pos.y+uiStruct.info.cs.size.height+2,
    border = 'rounded',
  }
end

local function create_ui_window()
  uiStruct.header.buf=vim.api.nvim_create_buf(false,true)
  uiStruct.header.win=vim.api.nvim_open_win(uiStruct.header.buf,false,uiStruct.header.cs.conf)
  uiStruct.info.buf=vim.api.nvim_create_buf(false,true)
  uiStruct.info.win=vim.api.nvim_open_win(uiStruct.info.buf,true,uiStruct.info.cs.conf)
  uiStruct.cmd.buf=vim.api.nvim_create_buf(false,true)
  uiStruct.cmd.win=vim.api.nvim_open_win(uiStruct.cmd.buf,true,uiStruct.cmd.cs.conf)

  vim.api.nvim_set_option_value('winhl', 'Normal:Label', { win = uiStruct.header.win })
  vim.api.nvim_set_option_value('winhl', 'Normal:Label', { win = uiStruct.info.win })
  vim.api.nvim_set_option_value('winhl', 'Normal:Label', { win = uiStruct.cmd.win })
end

local function fill_info()
  local someInfo={
    string.format("%s",vim.g.loaded_uiGrepSearchPath),
    string.format("%s",((vim.g.loaded_uiGrepSearchEndings=="") and "*.{}" or vim.g.loaded_uiGrepSearchEndings)),
  }
  for idx,_ in ipairs(uiStruct.info.txt) do
    vim.api.nvim_buf_set_lines(uiStruct.info.buf, idx-1, -1, false, {uiStruct.info.txt[idx] .. someInfo[idx]})
  end
end

local function close_windows()
  for name,element in pairs(uiStruct) do
    vim.api.nvim_win_close(element.win,true)
  end
end

local function user_prompt()
  local user_input=table.concat(vim.api.nvim_buf_get_lines(uiStruct.cmd.buf,0,-1,false))
  vim.cmd(":stopinsert")
  vim.cmd(string.format("silent :grep! '%s' '%s' -g '%s' -S", user_input, vim.g.loaded_uiGrepSearchPath, vim.g.loaded_uiGrepSearchEndings))
  vim.cmd(":copen")
  close_windows()
end

local function set_searchEndings()
  vim.api.nvim_set_current_win(uiStruct.info.win)
  local sIdx,eIdx=string.find(table.concat(vim.api.nvim_buf_get_lines(uiStruct.info.buf,1,-1,false)),':')
  vim.api.nvim_win_set_cursor(uiStruct.info.win,{2,eIdx+3})
end

local function get_searchEndings()
  local sIdx,eIdx=string.find(table.concat(vim.api.nvim_buf_get_lines(uiStruct.info.buf,1,-1,false)),':')
  local user_input=table.concat(vim.api.nvim_buf_get_text(uiStruct.info.buf,1,eIdx+1,1,-1,{}))
  vim.g.loaded_uiGrepSearchEndings=string.format("%s",user_input)
end

local function set_keymaps()

  vim.keymap.set('n', '<leader>',function() 
    close_windows()
  end, {buffer=uiStruct.cmd.buf,silent = true, nowait = true, noremap = true } )

  vim.keymap.set({'n','i'}, '<CR>',function()
    user_prompt()
  end, {buffer=uiStruct.cmd.buf,silent = true, nowait = true, noremap = false} )

  vim.keymap.set({'n'}, 'e',function()
    set_searchEndings()
  end, {buffer=uiStruct.cmd.buf,silent = true, nowait = true, noremap = false} )

  vim.keymap.set({'n','i'}, '<CR>',function()
    get_searchEndings()
    vim.api.nvim_set_current_win(uiStruct.cmd.win)
    fill_info()
  end, {buffer=uiStruct.info.buf,silent = true, nowait = true, noremap = false} )

end

function M.setSearchPath()
  vim.g.loaded_uiGrepSearchPath=(vim.fn.getcwd())
  print(vim.g.loaded_uiGrepSearchPath)
end

function M.main()
  ui_config()
  create_ui_window()
  set_keymaps()
  fill_info()
  vim.cmd(":startinsert")
end

-- M.main()

return M 
