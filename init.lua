local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'mfussenegger/nvim-dap' },
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } },
  { 'mfussenegger/nvim-dap-python' },
})

-- Python debugger setup
require('dap-python').setup('python3')

-- Auto-open/close debug UI
local dap, dapui = require('dap'), require('dapui')
dapui.setup()
dap.listeners.after.event_initialized['dapui'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui'] = function() dapui.close() end

-- Keymaps
vim.keymap.set('n', '<F5>', dap.continue)
vim.keymap.set('n', '<F10>', dap.step_over)
vim.keymap.set('n', '<F11>', dap.step_into)
vim.keymap.set('n', '<F12>', dap.step_out)
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<F4>', dap.terminate)
vim.cmd('colorscheme zaibatsu')
