return {
  'stevearc/oil.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- tag = "v2.8.0",
  config = function ()
      require("oil").setup({
          columns = {
              { "icon", add_padding = false },
              -- "permissions",
              -- "size",
              -- "mtime",
          },
      })
  end
}
