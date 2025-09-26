-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps

vim.keymap.set("n", "<leader>ww", function()
  if vim.bo.filetype == "java" then
    require('jdtls').organize_imports()
    vim.lsp.buf.format({ async = false })
  end
  vim.cmd("w")
end)

vim.keymap.set("n", "<leader>wq", function()
  if vim.bo.filetype == "java" then
    require('jdtls').organize_imports()
    vim.cmd("wq")
  else
    vim.cmd("wq")
  end
end)

keymap.set("n", "<leader>qq", ":q!<CR>")       -- quit without saving
keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursor

keymap.set("n", "J", "mzJ`z")                  -- when using J cursor stays at beginning
keymap.set("n", "<C-d>", "<C-d>zz")            -- keep cursor in the middle when Ctrl + d
keymap.set("n", "<C-u>", "<C-u>zz")            -- keep cursor in the middle when Ctrl + u
keymap.set("n", "n", "nzzzv")                  -- keep cursor in the middle when searching with n
keymap.set("n", "N", "Nzzzv")                  -- keep cursor in the middle when searching with N
keymap.set("v", "<A-j>", "yyp")                -- copy current line into the next one
keymap.set("v", "J", ":m '>+1<CR>gv=gv")       -- move line up
keymap.set("v", "K", ":m '<-2<CR>gv=gv")       -- move line down

-- replace word you are hovering over currently
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gc<Left><Left><Left>]])

-- Technical keymaps

-- Paste from system clipboard and remove ^M (carriage returns)
keymap.set("n", "<leader>p",
  function()
    local content = vim.fn.getreg("+")
    content = content:gsub("\r", "")
    vim.api.nvim_paste(content, true, -1)
  end)

keymap.set("v", "<leader>p",
  function()
    local content = vim.fn.getreg("+")
    content = content:gsub("\r", "")
    vim.api.nvim_paste(content, true, -1)
  end)

---- Auto indent on empty line.
vim.keymap.set('n', 'i', function()
  return string.match(vim.api.nvim_get_current_line(), '%g') == nil
      and 'cc' or 'i'
end, { expr = true, noremap = true })

keymap.set("n", "<leader>y", "\"+y")  -- Yank into system clipboard
keymap.set("v", "<leader>y", "\"+y")  -- Yank into system clipboard
keymap.set("n", "<leader>Y", "\"+Y")  -- Yank into system clipboard

keymap.set("x", "<leader>p", "\"_dP") -- when pasting do not load whats pasted into the buffer
keymap.set("n", "<leader>d", "\"_d")  -- delete into the void
keymap.set("v", "<leader>d", "\"_d")  -- delete into the void

-- Maven
-- run application
keymap.set("n", "<leader>mr", function()
  vim.cmd("botright split | terminal mvn clean compile javafx:run")
  vim.cmd([[
    augroup CloseTerminalOnExit
      autocmd!
      autocmd TermClose * ++once if &buftype == 'terminal' | bd! | endif
    augroup END
  ]])
end)

-- compile
vim.keymap.set("n", "<leader>mc", function()
  vim.cmd("botright split | terminal mvn compile")
end)

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v")     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s")     -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=")     -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
keymap.set("n", "<leader>sj", "<C-w>-")     -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+")     -- make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5")    -- make split windows width bigger
keymap.set("n", "<leader>sh", "<C-w><5")    -- make split windows width smaller

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>")   -- open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close a tab
keymap.set("n", "<leader>tn", ":tabn<CR>")     -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>")     -- previous tab

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>")   -- put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c")             -- next diff hunk
keymap.set("n", "<leader>cp", "[c")             -- previous diff hunk

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>")  -- open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>") -- jump to first quickfix list item
keymap.set("n", "<leader>qn", ":cnext<CR>")  -- jump to next quickfix list item
keymap.set("n", "<leader>qp", ":cprev<CR>")  -- jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>")  -- jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>") -- close quickfix list

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle maximize tab

-- Nvim-tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>")   -- toggle file explorer
keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>")    -- toggle focus to file explorer
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>") -- find file in file explorer

-- Telescope
keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {}) -- fuzzy find files in project
keymap.set('n', '<leader>fc', function()
  require('telescope.builtin').find_files {                                -- find config directory
    cwd = vim.fn.stdpath("config")
  }
end)
keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {})                 -- grep file contents in project
keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {})                   -- fuzzy find open buffers
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {})                 -- fuzzy find help tags
keymap.set('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find, {}) -- fuzzy find in current file buffer
keymap.set('n', '<leader>fo', require('telescope.builtin').lsp_document_symbols, {})      -- fuzzy find LSP/class symbols
keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, {})        -- fuzzy find LSP/incoming calls
-- keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({default_text=":method:"}) end) -- fuzzy find methods in current class
keymap.set('n', '<leader>fm',
  function() require('telescope.builtin').treesitter({ symbols = { 'function', 'method' } }) end) -- fuzzy find methods in current class
keymap.set('n', '<leader>ft',
  function()                                                                                      -- grep file contents in current nvim-tree node
    local success, node = pcall(function() return require('nvim-tree.lib').get_node_at_cursor() end)
    if not success or not node then return end;
    require('telescope.builtin').live_grep({ search_dirs = { node.absolute_path } })
  end)
-- keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({default_text=":method:"}) end) -- fuzzy find methods in current class

-- Refactorings
vim.keymap.set("n", "<leader>rv", function()
  require('jdtls').extract_variable()
end)

-- Extract Method
vim.keymap.set("n", "<leader>rm", function()
  require('jdtls').extract_method()
end)

-- Extract Constant
vim.keymap.set("n", "<leader>rc", function()
  require('jdtls').extract_constant()
end)

-- Git-blame
keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>") -- toggle git blame

-- Harpoon
keymap.set("n", "<leader>ha", require("harpoon.mark").add_file)
keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu)
keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end)
keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end)
keymap.set("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end)
keymap.set("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end)
keymap.set("n", "<leader>h5", function() require("harpoon.ui").nav_file(5) end)
keymap.set("n", "<leader>h6", function() require("harpoon.ui").nav_file(6) end)
keymap.set("n", "<leader>h7", function() require("harpoon.ui").nav_file(7) end)
keymap.set("n", "<leader>h8", function() require("harpoon.ui").nav_file(8) end)
keymap.set("n", "<leader>h9", function() require("harpoon.ui").nav_file(9) end)

-- Vim REST Console
keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>") -- Run REST query

-- LSP

keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>')
keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>')
keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>')
keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>')
keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>')

-- Specific keymaps for Java files (these can be done in the ftplugin directory instead if you prefer)
local jdtls = require("jdtls")

-- Java: Organize Imports
keymap.set("n", "<leader>oi", function() jdtls.organize_imports() end)

keymap.set("n", '<leader>tc', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').test_class();
  end
end)

keymap.set("n", '<leader>tm', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').test_nearest_method();
  end
end)

-- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>')
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
keymap.set("n", '<leader>dd', function()
  require('dap').disconnect(); require('dapui').close();
end)
keymap.set("n", '<leader>dt', function()
  require('dap').terminate(); require('dapui').close();
end)
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
keymap.set("n", '<leader>d?',
  function()
    local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
  end)
keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({ default_text = ":E:" }) end)
