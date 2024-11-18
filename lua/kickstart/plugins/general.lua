return {
  'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',
  'nvim-tree/nvim-tree.lua',
  'tpope/vim-sleuth',
  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set("n", "<F4>", vim.cmd.UndotreeToggle)
    end,
  },
}
