local set = vim.keymap.set

-- Move the cursor based on physical lines, not the actual lines.
set({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
set({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
set("n", "^", "g^")
set("n", "0", "g0")

-- Remap escape
set("i", "jj", "<Esc>")
set("i", "jk", "<Esc>")

-- Typing ` is harder than typing ', and ` is more useful
set("n", "'", "`")

set("i", "jk", "<Esc>")
-- Insert semicolon at end of line (useful when nvim-autopairs inserts parenthesis)
set("i", ";;", "<Esc>mzA;<Esc>`za")

-- Enter creates new line below
set('n', '<CR>', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

-- Use Shift + Enter as insert new line above; use as open link in Neorg files
set('n', '<S-CR>', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
vim.api.nvim_create_autocmd("Filetype", {
    pattern = "norg",
    callback = function()
        vim.keymap.set("n", "<S-CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
    end,
})

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

set("n", "<c-h>", "<c-w>h", {desc = "Switch between windows"})
set("n", "<c-j>", "<c-w>j", {desc = "Switch between windows"})
set("n", "<c-k>", "<c-w>k", {desc = "Switch between windows"})
set("n", "<c-l>", "<c-w>l", {desc = "Switch between windows"})

-- Remove trailing whitespace characters
set('n', '<leader>wt', [[:%s/\s\+$//e<cr>]])

-- Copy absolute path of current buffer
set("n", "<Leader>c", ":call setreg('+', expand('%:p'))<CR>", { silent = true})
set("n", "<c-c>", ":call setreg('+', expand('%:p'))<CR>", { silent = true})

-- Delete the lines surrounding the current indentation
set("n", "dsi", function()
	-- select outer indentation
	require("various-textobjs").indentation("outer", "outer")

	-- plugin only switches to visual mode when a textobj has been found
	local indentationFound = vim.fn.mode():find("V")
	if not indentationFound then return end

	-- dedent indentation
	vim.cmd.normal { "<", bang = true }

	-- delete surrounding lines
	local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1]
	local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1]
	vim.cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
	vim.cmd(tostring(startBorderLn) .. " delete")
end, { desc = "Delete Surrounding Indentation" })

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

