local set = vim.keymap.set

-- Move the cursor based on physical lines, not the actual lines.
set({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
set({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
set("n", "^", "g^")
set("n", "0", "g0")

-- Remap escape
set("i", "jj", "<Esc>")
set("i", "jk", "<Esc>")

-- Enter creates new line below, Shift + Enter creates new line above
set('n', '<S-CR>', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
set('n', '<CR>', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Easier way of navigating to the start and end
set({"n", "x"}, "<leader>l", "g_")
set({"n", "x"}, "<leader>h", " ^")
set("n", "<leader><leader>", "a <Esc>h")

-- Keeps visual selected when indenting
set("x", "<", "<gv")
set("x", ">", ">gv")

-- Clear highlights on search when pressing <Esc> in normal mode
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

set('x', 'g/', '<esc>/\\%V', { silent = false, desc = 'Search inside visual selection' })

-- Toggle spellcheck with F11
set("n", "<F11>", "<cmd>set spell!<cr>", { desc = "toggle spell" })
set("i", "<F11>", "<c-o><cmd>set spell!<cr>", { desc = "toggle spell" })

-- Change text without putting it into the vim register
set("n", "c", '"_c')
set("n", "C", '"_C')
set("n", "cc", '"_cc')
set("x", "c", '"_c')

-- Remove trailing whitespace characters
set('n', '<leader>wt', [[:%s/\s\+$//e<cr>]])

-- Easily go to beginning and end in insert mode
set("i", "<C-A>", "<HOME>")
set("i", "<C-E>", "<END>")

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

