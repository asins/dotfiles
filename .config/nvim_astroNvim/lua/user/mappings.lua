-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map

    -- navigate buffer tabs with `H` and `L`
    -- L = {
    --   function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
    --   desc = "Next buffer",
    -- },
    -- H = {
    --   function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
    --   desc = "Previous buffer",
    -- },

    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<c-s>"] = { ":update<cr>", desc = "保存文件" },
    -- quick save
  },
  v = {
    ["<c-s>"] = { "<C-C>:update<CR>", desc = "保存文件" },
    ["<c-x>"] = { "\"+x", desc = "剪切选中文本" },
    ["<c-c>"] = { "\"+y", desc = "复制选中文本" },
  },
  i = {
    ["<c-s>"] = { "<C-O>:update<CR>", desc = "保存文件" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
