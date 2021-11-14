-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/garrett/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/garrett/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/garrett/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/garrett/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/garrett/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\nZ\0\1\4\0\3\2\15\26\1\0\0*\2\1\0\3\2\1\0X\1\6€6\1\0\0009\1\1\1\18\3\0\0B\1\2\2\14\0\1\0X\2\4€6\1\0\0009\1\2\1\18\3\0\0B\1\2\2L\1\2\0\nfloor\tceil\tmath\2\1€€€ÿ\3ú\1\0\0\a\1\v\00206\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\t\0\0\0X\0\3€'\0\4\0L\0\2\0X\0%€6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0026\1\0\0009\1\1\0019\1\2\1'\3\5\0B\1\2\2\5\0\1\0X\0\3€'\0\6\0L\0\2\0X\0\22€6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0026\1\0\0009\1\1\0019\1\2\1'\3\5\0B\1\2\2#\0\1\0\24\0\1\0006\1\a\0009\1\b\1'\3\t\0-\4\0\0\18\6\0\0B\4\2\0A\1\1\2'\2\n\0&\1\2\1L\1\2\0K\0\1\0\0À\a%%\t%02d\vformat\vstring\bbot\6$\btop\6.\tline\afn\bvim\2È\1Þ\2\1\0\b\0\21\0!6\0\0\0009\0\1\0)\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\1\0=\1\3\0003\0\4\0003\1\5\0006\2\6\0'\4\a\0B\2\2\0029\2\b\0025\4\14\0005\5\t\0005\6\n\0=\6\v\0055\6\f\0=\6\r\5=\5\15\0045\5\17\0004\6\3\0005\a\16\0>\a\1\6=\6\18\0054\6\3\0>\1\1\6=\6\19\5=\5\20\4B\2\2\0012\0\0€K\0\1\0\rsections\14lualine_y\14lualine_c\1\0\0\1\2\2\0\rfilename\16file_status\2\tpath\3\1\foptions\1\0\0\23section_separators\1\3\0\0\5\5\25component_separators\1\3\0\0\6|\6|\1\0\2\ntheme\tauto\18icons_enabled\1\nsetup\flualine\frequire\0\0\rshowmode\15laststatus\bopt\bvim\0" },
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\né\2\0\0\f\0\15\0\0316\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0026\1\0\0'\3\4\0B\1\2\0026\2\5\0009\2\6\0029\2\a\0029\2\b\2B\2\1\0025\3\t\0006\4\n\0\18\6\3\0B\4\2\4X\a\6€8\t\b\0009\t\v\t5\v\f\0=\1\r\v=\2\14\vB\t\2\1E\a\3\3R\aøK\0\1\0\17capabilities\14on_attach\1\0\0\nsetup\vipairs\1\b\0\0\fpyright\18rust_analyzer\14sourcekit\vjsonls\rtsserver\veslint\vsvelte\29make_client_capabilities\rprotocol\blsp\bvim\20utils/on-attach\14lspconfig\30utils/lua-language-server\27utils/diagnostic-signs\frequire\0" },
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n¼\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14highlight\1\0\1\venable\2\21ensure_installed\1\0\0\1\n\0\0\tfish\blua\bvim\nswift\vpython\trust\tjson\15typescript\vsvelte\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\nÕ\4\0\0\3\0\b\0\0166\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0029\0\5\0B\0\1\0016\0\3\0'\2\4\0B\0\2\0029\0\6\0'\2\a\0B\0\2\1K\0\1\0\bfzf\19load_extension\nsetup\14telescope\frequireÞ\3\t\t\tcommand! Browse Telescope file_browser\n\t\t\tcommand! Bufs Telescope buffers\n\t\t\tcommand! Find Telescope find_files\n\t\t\tcommand! Tracked Telescope git_files\n\t\t\tcommand! Grep Telescope live_grep\n\t\t\tcommand! Help Telescope help_tags\n\t\t\t\" LSP lists\n\t\t\tcommand! Acts Telescope lsp_code_actions\n\t\t\tcommand! Defs Telescope lsp_definitions\n\t\t\tcommand! Doc Telescope lsp_document_diagnostics\n\t\t\tcommand! Imps Telescope lsp_implementations\n\t\t\tcommand! Refs Telescope lsp_references\n\t\t\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\nt\0\0\3\0\a\0\n6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\4\0009\0\5\0'\2\6\0B\0\2\1K\0\1\0\27colorscheme tokyonight\17nvim_command\bapi\nnight\21tokyonight_style\6g\bvim\0" },
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-indexed-search"] = {
    config = { "\27LJ\2\n>\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0!indexed_search_numbered_only\6g\bvim\0" },
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/vim-indexed-search",
    url = "https://github.com/henrik/vim-indexed-search"
  },
  ["vim-lastplace"] = {
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/vim-lastplace",
    url = "https://github.com/farmergreg/vim-lastplace"
  },
  ["vim-markdown"] = {
    config = { '\27LJ\2\nq\0\0\2\0\4\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\3\0K\0\1\0&vim_markdown_new_list_item_indent"vim_markdown_folding_disabled\6g\bvim\0' },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/Users/garrett/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n¼\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\14highlight\1\0\1\venable\2\21ensure_installed\1\0\0\1\n\0\0\tfish\blua\bvim\nswift\vpython\trust\tjson\15typescript\vsvelte\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\nÕ\4\0\0\3\0\b\0\0166\0\0\0009\0\1\0'\2\2\0B\0\2\0016\0\3\0'\2\4\0B\0\2\0029\0\5\0B\0\1\0016\0\3\0'\2\4\0B\0\2\0029\0\6\0'\2\a\0B\0\2\1K\0\1\0\bfzf\19load_extension\nsetup\14telescope\frequireÞ\3\t\t\tcommand! Browse Telescope file_browser\n\t\t\tcommand! Bufs Telescope buffers\n\t\t\tcommand! Find Telescope find_files\n\t\t\tcommand! Tracked Telescope git_files\n\t\t\tcommand! Grep Telescope live_grep\n\t\t\tcommand! Help Telescope help_tags\n\t\t\t\" LSP lists\n\t\t\tcommand! Acts Telescope lsp_code_actions\n\t\t\tcommand! Defs Telescope lsp_definitions\n\t\t\tcommand! Doc Telescope lsp_document_diagnostics\n\t\t\tcommand! Imps Telescope lsp_implementations\n\t\t\tcommand! Refs Telescope lsp_references\n\t\t\bcmd\bvim\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\né\2\0\0\f\0\15\0\0316\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0016\0\0\0'\2\3\0B\0\2\0026\1\0\0'\3\4\0B\1\2\0026\2\5\0009\2\6\0029\2\a\0029\2\b\2B\2\1\0025\3\t\0006\4\n\0\18\6\3\0B\4\2\4X\a\6€8\t\b\0009\t\v\t5\v\f\0=\1\r\v=\2\14\vB\t\2\1E\a\3\3R\aøK\0\1\0\17capabilities\14on_attach\1\0\0\nsetup\vipairs\1\b\0\0\fpyright\18rust_analyzer\14sourcekit\vjsonls\rtsserver\veslint\vsvelte\29make_client_capabilities\rprotocol\blsp\bvim\20utils/on-attach\14lspconfig\30utils/lua-language-server\27utils/diagnostic-signs\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: vim-indexed-search
time([[Config for vim-indexed-search]], true)
try_loadstring("\27LJ\2\n>\0\0\2\0\3\0\0056\0\0\0009\0\1\0)\1\1\0=\1\2\0K\0\1\0!indexed_search_numbered_only\6g\bvim\0", "config", "vim-indexed-search")
time([[Config for vim-indexed-search]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\nt\0\0\3\0\a\0\n6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\4\0009\0\5\0'\2\6\0B\0\2\1K\0\1\0\27colorscheme tokyonight\17nvim_command\bapi\nnight\21tokyonight_style\6g\bvim\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\nZ\0\1\4\0\3\2\15\26\1\0\0*\2\1\0\3\2\1\0X\1\6€6\1\0\0009\1\1\1\18\3\0\0B\1\2\2\14\0\1\0X\2\4€6\1\0\0009\1\2\1\18\3\0\0B\1\2\2L\1\2\0\nfloor\tceil\tmath\2\1€€€ÿ\3ú\1\0\0\a\1\v\00206\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\t\0\0\0X\0\3€'\0\4\0L\0\2\0X\0%€6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0026\1\0\0009\1\1\0019\1\2\1'\3\5\0B\1\2\2\5\0\1\0X\0\3€'\0\6\0L\0\2\0X\0\22€6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\0026\1\0\0009\1\1\0019\1\2\1'\3\5\0B\1\2\2#\0\1\0\24\0\1\0006\1\a\0009\1\b\1'\3\t\0-\4\0\0\18\6\0\0B\4\2\0A\1\1\2'\2\n\0&\1\2\1L\1\2\0K\0\1\0\0À\a%%\t%02d\vformat\vstring\bbot\6$\btop\6.\tline\afn\bvim\2È\1Þ\2\1\0\b\0\21\0!6\0\0\0009\0\1\0)\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\1\0=\1\3\0003\0\4\0003\1\5\0006\2\6\0'\4\a\0B\2\2\0029\2\b\0025\4\14\0005\5\t\0005\6\n\0=\6\v\0055\6\f\0=\6\r\5=\5\15\0045\5\17\0004\6\3\0005\a\16\0>\a\1\6=\6\18\0054\6\3\0>\1\1\6=\6\19\5=\5\20\4B\2\2\0012\0\0€K\0\1\0\rsections\14lualine_y\14lualine_c\1\0\0\1\2\2\0\rfilename\16file_status\2\tpath\3\1\foptions\1\0\0\23section_separators\1\3\0\0\5\5\25component_separators\1\3\0\0\6|\6|\1\0\2\ntheme\tauto\18icons_enabled\1\nsetup\flualine\frequire\0\0\rshowmode\15laststatus\bopt\bvim\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown'}, { ft = "markdown" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/garrett/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/garrett/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/garrett/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
