-- general
lvim.log.level = "warn"
lvim.format_on_save = {
  pattern = "*",
  timeout = 4000,
  filter = require("lvim.lsp.handlers").format_filter,
}

lvim.colorscheme = "gruvbox"
vim.opt.background = "dark"
vim.g.gruvbox_contrast_dark = "hard"
vim.opt.clipboard = ""
vim.opt.mouse = "n"
vim.opt.splitbelow = false
vim.opt.relativenumber = true

if os.getenv("COLORSCHEME") == 'light' or vim.g.colorscheme == 'light' then
  lvim.colorscheme = "github_light"
  vim.o.background = "light"
end

-- Additional Plugins
-- Configuration syntax: https://github.com/wbthomason/packer.nvim#the-startup-function
lvim.plugins = {
  -- theme
  "ellisonleao/gruvbox.nvim",
  "projekt0n/github-nvim-theme", -- for light theme
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      vim.g.indentLine_enabled = 1
      vim.g.indent_blankline_char_list = { '|', '¦', '┆', '┊' }
      vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard", "alpha" }
      vim.g.indent_blankline_buftype_exclude = { "terminal" }
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_first_indent_level = false
    end
  },
  -- git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        use_diagnostic_signs = true,
      }
    end
  },
  -- navigation
  "ThePrimeagen/harpoon",
  {
    'sindrets/diffview.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("diffview").setup {
        use_icons = true
      }
    end
  },
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require 'nvim-lastplace'.setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true
      }
    end
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    requires = {
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require('bqf').setup {
        auto_enable = true,
        auto_resize_height = true,
      }
    end
  },
  {
    "junegunn/fzf",
    run = function()
      vim.fn['fzf#install']()
    end
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    requires = {
      { "nvim-telescope/telescope.nvim" }
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  },
  {
    "nvim-telescope/telescope-fzy-native.nvim",
    requires = {
      { "nvim-telescope/telescope.nvim" }
    },
    config = function()
      require("telescope").load_extension("fzy_native")
    end
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    requires = {
      { "nvim-telescoe/telescope.nvim" },
      { "tami5/sqlite.lua" },
      { "kyazdani42/nvim-web-devicons" },
    },
    config = function()
      require("telescope").load_extension("frecency")
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    requires = {
      "nvim-telescoe/telescope.nvim"
    },
    config = function()
      require("telescope").load_extension("ui-select")
    end
  },
  {
    "stevearc/qf_helper.nvim", -- :Reject and :Keep for qfl, sync location
    config = function()
      require 'qf_helper'.setup()
    end
  },
  {
    "windwp/nvim-spectre", -- super duper search and replace
    config = function()
      require('spectre').setup()
    end
  },
  -- lsp addons
  "tpope/vim-surround",
  {
    "simrat39/symbols-outline.nvim"
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require 'treesitter-context'.setup {
        enable = true,
        throttle = true,
        max_lines = 10000,
        patterns = {
          default = {
            'class',
            'function',
            'method',
          },
        },
        exact_patterns = {}
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = {
      "nvim-treesitter/nvim-treesitter"
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require('refactoring').setup({})
      require("telescope").load_extension("refactoring")
    end
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
    requires = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    "windwp/nvim-ts-autotag",
    requires = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  { "p00f/nvim-ts-rainbow",
    requires = {
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = 10000
        }
      }
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup()
    end
  },
  {
    "Vimjas/vim-python-pep8-indent"
  },
  -- misc
  {
    "mfussenegger/nvim-ts-hint-textobject" -- expand selection (ctrl + s)
  },
  "folke/todo-comments.nvim",
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  "wsdjeg/vim-fetch", -- :e with line numbers
  "wakatime/vim-wakatime",
  {
    "windwp/nvim-projectconfig",
    config = function()
      require('nvim-projectconfig').setup()
    end
  },
  { "tpope/vim-unimpaired" },
  {
    "kazhala/close-buffers.nvim",
    config = function()
      require('close_buffers').setup({
        preserve_window_layout = { 'this', 'nameless' }, -- Types of deletion that should preserve the window layout
      })
    end
  },
  -- "thaerkh/vim-workspace",
  {
    "Shatur/neovim-session-manager",
    config = function()
      require("session_manager").setup {
        autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
        autosave_ignore_filetypes = {
          "gitcommit",
          "help",
          "terminal",
          "dashboard",
          "alpha",
          "fugitive"
        }
      }
    end
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require 'colorizer'.setup {
        css = {
          css = true
        },
        javascript = {
          css = true
        },
        typescript = {
          css = true
        }
      }
    end,
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "sass", "html" }
  },
  {
    "rcarriga/vim-ultest",
    requires = { "vim-test/vim-test" },
    run = ":UpdateRemotePlugins"
  },
  -- {
  --   "nvim-neotest/neotest",
  --    requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "antoinemadec/FixCursorHold.nvim"
  --   }
  -- },
  {
    "mtth/scratch.vim"
  }, {
    'nvim-orgmode/orgmode',
    requires = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require('orgmode').setup_ts_grammar()
      require('orgmode').setup {
        org_agenda_files = { "~/org/**/*" }
      }
    end
  },
  {
    "akinsho/git-conflict.nvim",
    config = function()
      require("git-conflict").setup({
        default_mappings = true
      })
    end
  },
  {
    "SidOfc/mkdx"
  },
  {
    "mracos/mermaid.vim",
    ft = { "mermaid" }
  }
}

-- keymappings [view all the defaults by pressing <leader>Lk]
-- Docs: https://www.lunarvim.org/configuration/02-keybindings.html#general-bindings
lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":lua require('tsht').nodes()<CR>"
lvim.keys.normal_mode["<M-w>"] = ":BDelete this<CR>"
lvim.keys.normal_mode["<leader>qa"] = ":BDelete hidden<CR>"
lvim.keys.normal_mode["<C-p>"] = ":Telescope find_files<CR>"

lvim.keys.visual_mode["<leader>y"] = '"+y'

lvim.builtin.which_key.mappings["S"] = {
  "<cmd>lua require('spectre').open()<CR>", "open spectre"
}

lvim.builtin.which_key.mappings["q"] = {
  name = "Quit",
  q = { "<cmd>q", "Quit vim" },
  a = { "<cmd>" }
}

lvim.builtin.which_key.mappings["y"] = {
  '"+y', "copy to clipboard"
}

lvim.builtin.which_key.mappings["x"] = {
  name = "Diagnostics",
  x = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
  K = { function() vim.diagnostic.open_float() end, "show line errors" }
}

vim.keymap.set("n", "T", function() vim.diagnostic.open_float() end)

lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
  k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
  l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
  p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
  r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
  R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
  u = {
    "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
    "Undo Stage Hunk",
  },
  o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
  b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  C = {
    "<cmd>Telescope git_bcommits<cr>",
    "Checkout commit(for current file)",
  },
  d = {
    "<cmd>Gitsigns diffthis HEAD<cr>",
    "Git Diff",
  },
  h = {
    name = "History",
    h = { "<cmd>GV<CR>", "History Tree" },
    f = { "<cmd>GV!<CR>", "File History Tree" }
  }
}

lvim.builtin.which_key.mappings["P"] = {
  name = "Packer",
  c = { "<cmd>PackerCompile<cr>", "Compile" },
  i = { "<cmd>PackerInstall<cr>", "Install" },
  r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
  s = { "<cmd>PackerSync<cr>", "Sync" },
  S = { "<cmd>PackerStatus<cr>", "Status" },
  u = { "<cmd>PackerUpdate<cr>", "Update" },
}

lvim.builtin.which_key.mappings["p"] = {
  name = "Project",
  p = { "<cmd>Telescope projects<CR>", "list all" },
  v = { "<cmd>NvimTreeToggle<CR>", "file tree" },
  f = { "<cmd>Telescope live_grep<CR>", "search files" },
  o = { "<cmd>Telescope buffers<CR>", "open files" },
  h = { "<cmd>Telescope oldfiles<CR>", "files history" },
  c = { "<cmd>SessionManager save_current_session<CR>", "save session" },
  ss = { "<cmd>SessionManager load_session<CR>", "list session" },
  sd = { "<cmd>SessionManager delete_session<CR>", "delete session" },
  O = { "<cmd>SymbolsOutline", "document outline" },
  d = { function() require("notify").dismiss() end, "Dismiss notifications" }
}

lvim.builtin.which_key.mappings["m"] = {
  name = "Harpoon",
  c = { function() require("harpoon.mark").add_file() end, "Add file" },
  a = { function() require("harpoon.ui").toggle_quick_menu() end, "List all files" },
  m = {
    name = "Open harpooned file",
    ["1"] = { function() require("harpoon.ui").nav_file(1) end, "Go to file no. 1" },
    ["2"] = { function() require("harpoon.ui").nav_file(2) end, "Go to file no. 2" },
    ["3"] = { function() require("harpoon.ui").nav_file(3) end, "Go to file no. 3" },
    ["4"] = { function() require("harpoon.ui").nav_file(4) end, "Go to file no. 4" },
    ["5"] = { function() require("harpoon.ui").nav_file(5) end, "Go to file no. 5" },
    ["6"] = { function() require("harpoon.ui").nav_file(6) end, "Go to file no. 6" },
    ["7"] = { function() require("harpoon.ui").nav_file(7) end, "Go to file no. 7" },
    ["8"] = { function() require("harpoon.ui").nav_file(8) end, "Go to file no. 8" },
    ["9"] = { function() require("harpoon.ui").nav_file(9) end, "Go to file no. 9" },
  },
}

vim.keymap.set("n", "]r", "<Plug>(ultest-next-fail)")
vim.keymap.set("n", "[r", "<Plug>(ultest-prev-fail)")

lvim.builtin.which_key.mappings["t"] = {
  name = "Tests",
  T = { "<Plug>(ultest-run-file)", "run all in file" },
  t = { "<Plug>(ultest-run-nearest)", "run nearest" },
  r = { "<Plug>(ultest-run-last)", "run last test" },
  o = { "<Plug>(ultest-summary-jump)", "show summary" },
  l = { "<Plug>(ultest-output-show)", "show log" },
  i = { "<Plug>(ultest-debug-nearest)", "debug nearest" },
  I = { "<Plug>(ultest-debug)", "debug file" },
  h = { "<Plug>(ultest-stop-nearest)", "stop nearest test" },
  H = { "<Plug>(ultest-stop-file)", "stop tests in file" }
}

vim.api.nvim_set_keymap("n", "]h", '', {
  noremap = true,
  callback = function()
    require("harpoon.ui").nav_next()
  end,
  desc = "Go to next harpoon file"
})
vim.api.nvim_set_keymap("n", "[h", '', {
  noremap = true,
  callback = function()
    require("harpoon.ui").nav_prev()
  end,
  desc = "Go to previous harpoon file"
})

lvim.builtin.which_key.mappings["r"] = {
  name = "Refactoring",
  r = { function() require("telescope").extensions.refactoring.refactors() end, "Open menu" },
  b = { function() require('refactoring').refactor('Extract Block') end, "Extract block" },
  f = { function() require('refactoring').refactor('Extract Block To File') end, "Extract block to file" },
  i = { function() require('refactoring').refactor('Inline Variable') end, "Inline Variable" },
}
lvim.builtin.which_key.vmappings["r"] = {
  name = "Refactoring",
  r = { function() require("telescope").extensions.refactoring.refactors() end, "Open menu" },
  e = { function() require("refactoring").refactor('Extract Function') end, "Extract function" },
  f = { function() require("refactoring").refactor("Extract Function To File") end, "Extract function to file" },
  v = { function() require("refactoring").refactor("Extract Variable") end, "Extract variable" },
  i = { function() require('refactoring').refactor('Inline Variable') end, "Inline variable" },
}

vim.api.nvim_set_keymap("n", "<Esc>", "<cmd>noh<CR>", { noremap = true })

vim.api.nvim_create_user_command("CopyPath", "let @*=expand('%')", {
  nargs = 0, desc = "Copy current file path"
})
vim.api.nvim_create_user_command("CopyPathAbsolute", "let @*=expand('%:p')", {
  nargs = 0, desc = "Copy absolute path to current file"
})
vim.api.nvim_create_user_command("CopyPathLine", "let @* = expand('%') . ':' . line('.')", {
  nargs = 0, desc = "Copy current file path with line numbers"
})
lvim.builtin.which_key.mappings["bp"] = {
  "<cmd>CopyPath<CR>", "Copy current file path"
}
lvim.builtin.which_key.mappings["bP"] = {
  "<cmd>CopyPathLine<CR>", "Copy current file path + linenm"
}

vim.api.nvim_create_user_command("SetUsLayout", "silent set keymap=''", {
  nargs = 0, desc = "Set keyboard layout to US"
})
vim.api.nvim_create_user_command("SetPlLayout", "silent set keymap=polish-slash_utf-8", {
  nargs = 0, desc = "Set keyboard layout to PL"
})

vim.cmd([[
  " Fugitive
  let g:fugitive_pty = 0 " Fix for Fugitve + lint-staged
  nnoremap <leader>gh :GV<CR>
  nnoremap <leader>gf :GV!<CR>
  nnoremap <leader>gfl :0Gllog<CR>
  nnoremap <leader>gs :Git<CR>
  command! -nargs=0 Gp :Git push
  command! -nargs=0 Gpf :Git push --force-with-lease
  command! -nargs=1 Gco :Git checkout <f-args>
  command! -nargs=1 Gcb :Git checkout -b <f-args>
  command! -nargs=0 Gl :Git autopull

  " Use :close instead of :q
  cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>
]])

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.terminal.direction = "vertical"
lvim.builtin.terminal.size = function(term)
  if term.direction == "horizontal" then
    return 15
  elseif term.direction == "vertical" then
    return vim.o.columns * 0.4
  else
    return 20
  end
end
lvim.builtin.dap.active = true

-- notification
lvim.builtin.notify.active = false
lvim.builtin.notify.opts.stages = "fade_in_slide_out"

-- nvimtree
lvim.builtin.nvimtree.setup.view.side = "left"
local customFilters = vim.list_extend({
  ".undodir",
  ".DS_Store",
  ".git"
}, lvim.builtin.nvimtree.setup.filters.custom)
lvim.builtin.nvimtree.setup.filters.custom = customFilters
lvim.builtin.nvimtree.setup.update_focused_file.ignore_list = { "fugitive", "fugitive_blame" }
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false
lvim.builtin.nvimtree.setup.actions.change_dir.restrict_above_cwd = false
lvim.builtin.nvimtree.setup.actions.change_dir.enable = false
lvim.builtin.nvimtree.setup.disable_netrw = false

-- treesitter
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "java",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.matchup.enabled = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.context_commentstring.enable = true
lvim.builtin.treesitter.textobjects = {
  select = {
    enable = true,
    lookahead = true
  },
  move = {
    enabled = true,
    set_jumps = true,
    goto_next_start = {
      ["]m"] = "@function.outer",
      ["]]"] = "@class.outer",
    },
    goto_next_end = {
      ["]M"] = "@function.outer",
      ["]["] = "@class.outer",
    },
    goto_previous_start = {
      ["[m"] = "@function.outer",
      ["[["] = "@class.outer",
    },
    goto_previous_end = {
      ["[M"] = "@function.outer",
      ["[]"] = "@class.outer",
    },
  },
  swap = {
    enable = true
  }
}
lvim.builtin.treesitter.incremental_selection = {
  enable = true
}

-- telescope
lvim.builtin.project.active = true
lvim.builtin.notify.active = true
lvim.builtin.telescope.extensions.fzf = true
lvim.builtin.telescope.extensions["ui-select"] = {
  require("telescope.themes").get_dropdown {}
}
lvim.builtin.telescope.extensions.frecency = {
  db_root = get_config_dir(),
  show_unindexed = true,
  ignore_patterns = {
    "*.git/*",
    "*/tmp/*",
    "*/node_modules/*",
    "*/.undodir/*",
    "**/.DS_Store",
    "*.snap",
  },
  workspaces = {
    ["conf"] = "~/dotfiles",
    ["data"] = "~/.local/share",
    ["project"] = "~/PROJECTS",
    ["wiki"] = "~/wiki"
  }
}
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  "node_modules",
  "*.generated.*",
  ".sessions/*",
  ".DS_Store",
  "*.snap",
}
lvim.builtin.telescope.defaults.layout_config = {
  width = 0.87,
  height = 0.80,
  preview_cutoff = 120,
  horizontal = {
    prompt_position = "top",
    preview_width = function(_, cols, _)
      if cols < 120 then
        return math.floor(cols * 0.5)
      end
      return math.floor(cols * 0.6)
    end,
    results_width = 0.8
  },
  vertical = { mirror = false },
}
-- lvim.builtin.telescope.defaults.prompt_prefix = "   "
-- lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
-- lvim.builtin.telescope.defaults.use_less = true
-- lvim.builtin.telescope.defaults.path_display = "smart"

local components = require("lvim.core.lualine.components")
local filenameComponent = {
  "filename",
  path = 1, -- relative path
  shorting_target = 40,
  -- from lvim.core.lueline.components.filename
  color = {},
  cond = nil,
}
lvim.builtin.lualine.style = "lvim"
lvim.builtin.lualine.sections.lualine_b = {
  components.branch,
  filenameComponent
}

vim.api.nvim_set_var("workspace_session_directory", "~/.config/lvim/sessions")
vim.api.nvim_set_var("workspace_undodir", ".undodir")
vim.api.nvim_set_var("workspace_session_disable_on_args", 1)
vim.api.nvim_set_var("workspace_autosave", 0)
-- generic LSP settings

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
-- vim.tbl_map(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
lvim.lsp.on_attach_callback = function(client, bufnr)
  -- local function buf_set_option(...)
  --   vim.api.nvim_buf_set_option(bufnr, ...)
  -- end

  --Enable completion triggered by <c-x><c-o>
  -- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Linters & Formatters
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "prettier", filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" } }
-- }

-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   {
--     name = "eslint_d"
--   }
-- }

-- use lostlist instead of quickfixlsit
local on_references = vim.lsp.handlers["textDocument/references"]
vim.lsp.handlers["textDocument/references"] = vim.lsp.with(
  on_references, {
  loclist = true,
}
)
local on_definition = vim.lsp.handlers["textDocument/definition"]
vim.lsp.handlers["textDocument/definition"] = vim.lsp.with(
  on_definition, {
  loclist = true
}
)

require 'lspconfig'.tailwindcss.setup {}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
