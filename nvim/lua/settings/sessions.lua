vim.api.nvim_create_user_command("Save", "mksession!", {})
vim.api.nvim_create_user_command("Load", "silent! source Session.vim", {})
