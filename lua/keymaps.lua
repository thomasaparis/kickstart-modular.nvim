-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Tmux Sessionizer
-- vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

-- greatest remap ever, stops register overwrite when pasting over visual selection
-- vim.keymap.set('x', '<leader>p', [["_dP]]) -- sends deleted text to void register
vim.keymap.set({ 'n', 'x' }, '<leader>p', [["0p]], { desc = 'paste from yank register' }) -- keeps deleted text

-- Quick tab navigation
vim.keymap.set('n', '<leader>1', '1gt', { noremap = true, silent = true, desc = 'Move to tab 1' })
vim.keymap.set('n', '<leader>2', '2gt', { noremap = true, desc = 'Move to tab 2' })
vim.keymap.set('n', '<leader>3', '3gt', { noremap = true, desc = 'Move to tab 3' })
vim.keymap.set('n', '<leader>4', '4gt', { noremap = true, desc = 'Move to tab 4' })
vim.keymap.set('n', '<leader>5', '5gt', { noremap = true, desc = 'Move to tab 5' })

vim.keymap.set('n', '<leader>yp', function()
  vim.cmd 'let @+ = expand("%:p:.") . ":" . line(".")'
end, { desc = 'Copy relative file path and line number to clipboard' })

-- More powerful s(ubstitute)
vim.keymap.set('n', '<leader>S', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[S]ubstiute word under cursor' })

-- vim: ts=2 sts=2 sw=2 et
