local M={}
 
function M.setup()

  print("setup")
end

local function userConfirm()

  print("enter")

end

function M.main()
    -- Define the size of the floating window
    local width = 50
    local height = 10

    -- Create the scratch buffer displayed in the floating window
    local buf = vim.api.nvim_create_buf(false, true)
    vim.keymap.set('n', '<cr>', function()
      userConfirm() 
    end, { silent = true, nowait = true, noremap = true })

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
    }
    local win = vim.api.nvim_open_win(buf, true, opts)
    
    -- print current search path
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, { string.format("Current search path: %s ", vim.env.repoPath),"" })
    vim.api.nvim_buf_set_lines(buf, 1, -1, true, { string.format("[%s]","x" ),"" })
    local lines = vim.api.nvim_buf_get_lines(buf, 1, 1, false)
    

    -- Change highlighting
    -- use :highlight to see options
    vim.api.nvim_set_option_value('winhl', 'Normal:Label', { win = win })
  end

return M 
