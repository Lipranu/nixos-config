vim.keymap.set('n', 'tt', '<Cmd>Neotree<CR>')
vim.keymap.set('n', 'tb', '<Cmd>Neotree float buffers<CR>')
vim.keymap.set('n', 'tg', '<Cmd>Neotree float git_status<CR>')

require("neo-tree").setup({
  close_if_last_window = true
})
