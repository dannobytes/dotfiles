return {
  {
    'davidmh/mdx.nvim',
    event = { 'BufReadPre *.mdx', 'BufNewFile *.mdx' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
