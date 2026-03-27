-- apply custom color overrides whenever color scheme changes
local function custom_highlights()
  vim.api.nvim_set_hl(0, "diagnosticerror", { fg = "#ff8787" }) -- ctermfg 210
  vim.api.nvim_set_hl(0, "diagnosticwarn", { fg = "#ffaf5f" }) -- ctermfg 215
  vim.api.nvim_set_hl(0, "diagnosticinfo", { fg = "#afffaf" }) -- ctermfg 157
  vim.api.nvim_set_hl(0, "diagnostichint", { fg = "#afffff" }) -- ctermfg 159

  -- coc colors
  vim.api.nvim_set_hl(0, "cocfloating", { fg = "#d7d7ff", bg = "#262626" }) -- ctermfg 189, ctermbg 235
  vim.api.nvim_set_hl(0, "cocfloatactive", { fg = "#ff875f" }) -- ctermfg 209
  vim.api.nvim_set_hl(0, "cocfloatdividingline", { fg = "#8a8a8a" }) -- ctermfg 245
  vim.api.nvim_set_hl(0, "CocErrorFloat", { link = "DiagnosticError" })
  vim.api.nvim_set_hl(0, "CocWarningFloat", { link = "DiagnosticWarn" })
  vim.api.nvim_set_hl(0, "cocinfofloat", { link = "diagnosticinfo" })
  vim.api.nvim_set_hl(0, "CocHintFloat", { link = "DiagnosticHint" })
  vim.api.nvim_set_hl(0, "CocErrorHighlight", { fg = "#ff5f87" }) -- ctermfg 204
  vim.api.nvim_set_hl(0, "CocWarningHighlight", { fg = "#ff875f" }) -- ctermfg 209
  vim.api.nvim_set_hl(0, "CocInfoHighlight", { fg = "#d7d787" }) -- ctermfg 186
  vim.api.nvim_set_hl(0, "CocHintHighlight", { fg = "#87d7af" }) -- ctermfg 115
  vim.api.nvim_set_hl(0, "CocPumSearch", { fg = "#ff8700" }) -- ctermfg 208
  vim.api.nvim_set_hl(0, "CocNotificationProgress", { fg = "#ff8700" }) -- ctermfg 208
  vim.api.nvim_set_hl(0, "CocHighlightText", { bg = "#5f5f00" }) -- ctermbg 58

  vim.api.nvim_set_hl(0, "Visual", { bg = "#18748a", fg = "#eeeeee" }) -- ctermbg 54, ctermfg 7
  vim.api.nvim_set_hl(0, "Search", { bg = "#d7afdd", fg = "#000000" }) -- ctermbg 183
  vim.api.nvim_set_hl(0, "netrwMarkFile", { link = "Search" })

  -- Snacks picker
  vim.api.nvim_set_hl(0, "SnacksPickerListCursorLine", { bg = "#785858", fg = "#ffffff" })
end

-- Custom highlights autogroup
local custom_highlights_group = vim.api.nvim_create_augroup("customHighlights", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = custom_highlights_group,
  callback = custom_highlights,
})
custom_highlights()

-- Editing autogroup
local editing_group = vim.api.nvim_create_augroup("editing", { clear = true })
-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = editing_group,
  callback = function() vim.highlight.on_yank({ timeout = 200 }) end,
})
-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = editing_group,
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- File types autogroup
local file_types_group = vim.api.nvim_create_augroup("fileTypes", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = file_types_group,
  pattern = "*.coffee",
  command = "set filetype=coffee",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = file_types_group,
  pattern = "*.hamlc",
  command = "set filetype=haml",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = file_types_group,
  pattern = "*.md",
  command = "set shiftwidth=2",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = file_types_group,
  pattern = "*.{pug,jade}",
  command = "set filetype=pug",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = file_types_group,
  pattern = ".eslintignore",
  command = "set filetype=gitignore",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = file_types_group,
  pattern = ".stylelintignore",
  command = "set filetype=gitignore",
})

-- Format options autogroup
local format_options_group = vim.api.nvim_create_augroup("formatOptions", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = format_options_group,
  pattern = "*.scss",
  command = "setlocal formatoptions=roql",
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = format_options_group,
  pattern = "*.md",
  command = "setlocal formatoptions-=t",
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = format_options_group,
  pattern = "*",
  command = "setlocal formatoptions+=wj",
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = format_options_group,
  pattern = "*",
  command = "setlocal formatoptions-=c",
})

-- CoC tweaks autogroup
local coc_tweaks_group = vim.api.nvim_create_augroup("cocTweaks", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = coc_tweaks_group,
  pattern = "css",
  command = "setl iskeyword+=-",
})
vim.api.nvim_create_autocmd("FileType", {
  group = coc_tweaks_group,
  pattern = "scss",
  command = "setlocal iskeyword+=@-@",
})

-- Goto file autogroup
local goto_file_group = vim.api.nvim_create_augroup("gotoFile", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
  group = goto_file_group,
  pattern = "*.scss",
  command = "setlocal includeexpr=substitute(v:fname,'^\\\\~*','node_modules/','') ",
})
