-- require('dapui').setup(
--   {
--     controls = {
--       element = "repl",
--       enabled = true,
--       icons = {
--         disconnect = "",
--         pause = "",
--         play = "",
--         run_last = "",
--         step_back = "",
--         step_into = "",
--         step_out = "",
--         step_over = "",
--         terminate = ""
--       }
--     },
--     element_mappings = {},
--     expand_lines = true,
--     floating = {
--       border = "single",
--       mappings = {
--         close = { "q", "<Esc>" }
--       }
--     },
--     force_buffers = true,
--     icons = {
--       collapsed = "",
--       current_frame = "",
--       expanded = ""
--     },
--     layouts = { {
--         elements = { {
--             id = "scopes",
--             size = 0.25
--           }, {
--             id = "breakpoints",
--             size = 0.25
--           }, {
--             id = "stacks",
--             size = 0.25
--           }, {
--             id = "watches",
--             size = 0.25
--           } },
--         position = "left",
--         size = 40
--       }, {
--         elements = { {
--             id = "console",
--             size = 1.0
--           } },
--         position = "bottom",
--         size = 10
--       }, {
--         elements = { {
--             id = "repl",
--             size = 1.0
--           } },
--         position = "bottom",
--         size = 2
--       } },
--     mappings = {
--       edit = "e",
--       expand = { "<CR>", "<2-LeftMouse>" },
--       open = "o",
--       remove = "d",
--       repl = "r",
--       toggle = "t"
--     },
--     render = {
--       indent = 1,
--       max_value_lines = 100
--     }
--   }
-- )

--[[
require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python')
table.insert(require('dap').configurations.python, {
	type='python',
	request = 'launch',
	name = 'query.py with gpu question',
	program = 'query.py',
	args = {'"i have issue with gpu"'}
})
--]]
