return {
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = true,
    keys = {
      { "ii", '<cmd>lua require("various-textobjs").indentation("inner", "inner")<CR>', mode = { "o", "x" } },
      { "ai", '<cmd>lua require("various-textobjs").indentation("outer", "outer")<CR>', mode = { "o", "x" } },
      { "r", '<cmd>lua require("various-textobjs").restOfIndentation()<CR>', mode = { "o", "x" } },
      { "B", '<cmd>lua require("various-textobjs").entireBuffer()<CR>', mode = { "o", "x" } },
    },
  },
}
