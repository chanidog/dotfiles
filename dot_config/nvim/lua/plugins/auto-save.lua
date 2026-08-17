return {
  "okuuva/auto-save.nvim",
  version = '^1.0.0', -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
  cmd = "ASToggle", -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  opts = {
    -- your config goes here
    -- or just leave it empty :)
    noautocmd = true
  },
  config = function(_, opts)
    local autosave = require("auto-save")
    autosave.setup(opts)

    require("snacks.toggle").new({
      name = "Auto Save",
      get = function()
         return autosave.enabled()
      end,
      set = function(state)
          if state then
              autosave.on()
          else
              autosave.off()
          end
      end,
    }):map("<leader>uv") -- Or any other keymap (for details, check the snacks.toggle docs at https://github.com/folke/snacks.nvim/blob/main/docs/toggle.md)
  end,
}
