local options = {
  encoding = "utf-8",
  fileencoding = "utf-8",
  fileformats = {"unix", "dos", "mac"},
  ambiwidth = "double",
  emoji = true,
  wrap = false,
  autoindent = true,
  hlsearch = true,
  tabstop = 2,
  shiftwidth = 2,
  list = true,
  expandtab = true,
  conceallevel = 0,
  clipboard = "unnamedplus",
  termguicolors = true,
  mouse = "a",
  backspace = { "indent", "eol", "start" },

  diffopt = "vertical",
  cursorline = true,
  number = true,
  numberwidth = 4,
  showmode = true,

  undofile = true,
  swapfile = false,
  backup = false,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end