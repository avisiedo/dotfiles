local M = {}

function M.show_leader_keys()
  local keys = vim.api.nvim_get_keymap('n')
  local leader_keys = {}
  for _, key in ipairs(keys) do
    if key.lhs:match('^<leader>') then
      table.insert(leader_keys, key.lhs .. ' ' .. key.rhs)
    end
  end
  local bufnr = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, leader_keys)
  local winnr = vim.api.nvim_open_win(bufnr, true, {
    relative = 'editor',
    width = 60,
    height = 10,
    col = (vim.opt.columns:get() - 60) / 2,
    row = (vim.opt.lines:get() - 10) / 2,
    style = 'minimal',
    border = 'rounded',
  })
end

return M

