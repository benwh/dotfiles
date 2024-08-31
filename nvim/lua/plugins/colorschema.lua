return {
  -- Tokyodark, with some mods, looks best for now.
  {
    'tiagovla/tokyodark.nvim',
    opts = {
      gamma = 0.9,

      -- See files for reference:
      -- https://github.com/tiagovla/tokyodark.nvim/blob/master/lua/tokyodark/highlights.lua
      -- https://github.com/tiagovla/tokyodark.nvim/blob/master/lua/tokyodark/palette.lua
      custom_highlights = function(_, palette)
        return {
          -- Make visual selection brighter. We've got to override the fg too, as otherwise you can't distinguish between the two.
          Visual = { bg = palette.bg4, fg = palette.fg },
          -- Make the cursor line brighter too.
          CursorLine = { bg = palette.bg2 },
          -- Comments are too dim by default.
          Comment = { fg = palette.fg },

          -- NeoTree colors feel a bit back-to-front by default. Make it match closer to scmpuff.
          NeoTreeGitModified = { fg = palette.orange },
          NeoTreeGitUntracked = { fg = palette.cyan },
        }
      end,
    },
    config = function(_, opts)
      require('tokyodark').setup(opts) -- calling setup is optional
      vim.cmd [[colorscheme tokyodark]]
    end,
  },
  -- Other colorschemes, rejected for now.

  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     vim.cmd.colorscheme 'tokyonight-night'

  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
  -- {
  --   'rebelot/kanagawa.nvim',
  --   config = function()
  --     require('kanagawa').setup {
  --       theme = 'dragon',
  --     }
  --     vim.cmd [[colorscheme kanagawa-dragon]]
  --   end,
  -- },
  -- {
  --   'loctvl842/monokai-pro.nvim',
  --   config = function()
  --     require('monokai-pro').setup {
  --       filter = 'classic',
  --     }
  --     vim.cmd [[colorscheme monokai-pro]]
  --   end,
  -- },
  -- {
  --   'neanias/everforest-nvim',
  --   version = false,
  --   lazy = false,
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   -- Optional; default configuration will be used if setup isn't called.
  --   config = function()
  --     require('everforest').setup {
  --       background = 'hard',
  --     }
  --     require('everforest').load()
  --   end,
  -- },
  -- {
  --   'ribru17/bamboo.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('bamboo').setup {
  --       -- optional configuration here
  --     }
  --     require('bamboo').load()
  --   end,
  -- },
  -- {
  --   'AlexvZyl/nordic.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('nordic').load()
  --   end,
  -- },
  -- {
  --   'sainnhe/sonokai',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     vim.g.sonokai_enable_italic = true
  --     vim.g.sonokai_style = 'shusia'
  --     vim.cmd.colorscheme 'sonokai'
  --   end,
  -- },
  -- { --
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-night'

  --     -- You can configure highlights by doing something like:
  --     -- vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
}
