return {
  {
    'willothy/nvim-cokeline',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      -- 'stevearc/resession.nvim', -- Optional, for persistent history
    },
    config = function()
      local get_hex = require('cokeline.hlgroups').get_hl_attr
      local get_visible = require('cokeline/buffers').get_visible
      local is_picking_focus = require('cokeline/mappings').is_picking_focus
      local is_picking_close = require('cokeline/mappings').is_picking_close

      local oceanblue = '#0066cc'
      local red = vim.g.terminal_color_1
      local yellow = vim.g.terminal_color_3

      local black = get_hex('StatusLineNC', 'bg')
      local green = get_hex('PmenuSel', 'bg')

      local hlgroups = require 'cokeline.hlgroups'

      require('cokeline').setup {

        components = {
          {
            text = function(buffer)
              return ' ' .. buffer.devicon.icon
            end,
            fg = function(buffer)
              return buffer.devicon.color
            end,
          },
          {
            text = function(buffer)
              return buffer.index .. ':'
            end,
          },
          {
            text = function(buffer)
              return buffer.unique_prefix
            end,
            fg = function()
              return hlgroups.get_hl_attr('Comment', 'fg')
            end,
            italic = true,
          },
          {
            text = function(buffer)
              return buffer.filename
            end,
            underline = function(buffer)
              if buffer.is_hovered and not buffer.is_focused then
                return true
              end
            end,
          },
          {
            text = ' ',
          },
          {
            ---@param buffer Buffer
            text = function(buffer)
              if buffer.is_modified then
                return ''
              end
              if buffer.is_hovered then
                return '󰅙'
              end
              return '󰅖'
            end,
            on_click = function(_, _, _, _, buffer)
              buffer:delete()
            end,
          },
          {
            text = ' ',
          },
        },
      }
    end,
  },
}
