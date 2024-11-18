return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      -- empty setup using defaults
      require("nvim-tree").setup()

      -- OR setup with some options
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          special_files = {},
          icons = {
            show = {
              folder_arrow = false,
            },
            glyphs = {
              default = "",
              folder = {
                default = "",
                open = "",
                empty = "",
                empty_open = "",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
