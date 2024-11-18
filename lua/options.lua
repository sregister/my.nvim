-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

vim.opt.guicursor = ""
--vim.opt.tabstop = 4
--vim.opt.softtabstop = 4
--vim.opt.shiftwidth = 4
--vim.opt.expandtab = true
vim.opt.smartindent = true


vim.opt.wrap = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.o.hlsearch = false
vim.opt.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.opt.nu = true

-- Enable mouse mode
vim.o.mouse = 'a'

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.cmd[[highlight ColorColumn ctermbg=255 guibg=#262626]]

vim.diagnostic.config({
  virtual_text = {
    source = "always",  -- Or "if_many"
  },
  float = {
    source = "always",  -- Or "if_many"
  },
})


vim.api.nvim_create_augroup("AutoFormat", {})

vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        pattern = "*.py",
        group = "AutoFormat",
        callback = function()
            -- if filename of open file does not contain substring 'splunk'
            -- then format with black
            --    vim.cmd("silent !black --quiet %")
            --    vim.cmd("edit")
            if not vim.fn.expand("%:t"):match("splunk") then
                vim.cmd("silent !black --quiet %")
                vim.cmd("edit")
            end
        end,
    }
)



-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.cmd.colorscheme("moonfly")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- vim: ts=2 sts=2 sw=2 et
