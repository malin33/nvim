
local M={}
 
function M.setup()

  print("setup")
end

function M.searchWindow()
    -- Define the size of the floating window
    local width = 50
    local height = 10

    -- Create the scratch buffer displayed in the floating window
    local buf = vim.api.nvim_create_buf(false, true)


    vim.api.nvim_buf_set_keymap(buf, 'n', '<leader>', ':close<CR>', { silent = true, nowait = true, noremap = true })

    -- window
    local ui = vim.api.nvim_list_uis()[1]
    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor((ui.width - width) / 2),
        row = math.floor((ui.height - height) / 2),
        anchor = 'NW',
        style = 'minimal',
        border = 'rounded'
    }
    local win = vim.api.nvim_open_win(buf, true, opts)
    
    -- print current search path
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, { string.format("Current search path: %s ", vim.env.repoPath),"" })

    -- pipe cmd output to scratch buffer
    --local user_input = vim.fn.input("vimgrep string *{cc,cpp,h}: ")

    -- Change highlighting
    -- use :highlight to see options
    vim.api.nvim_set_option_value('winhl', 'Normal:Label', { win = win })

    vim.keymap.set({ 'n', 'i', 'v' }, '<cr>', function()
      local lines = vim.api.nvim_buf_get_lines(win.buffer, 0, 1, false)
      if on_confirm then
        confirmed = true
        on_confirm(lines[1])
        return
      end
  end
  )

  end

return M 

--:put =map(getqflist(), 'v:val')
--local cmd=vim.api.nvim_exec(string.format(":vim! /%s/jg %s**/*{cc,cpp,h}", user_input, vim.env.repoPath),{output=true})
