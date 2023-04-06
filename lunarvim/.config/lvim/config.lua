-- general
lvim.log.level = "warn"
local formatTimeout = 2000
-- lvim.format_on_save = false
lvim.format_on_save = {
  enabled = true,
  pattern = "*",
  timeout = formatTimeout,
  filter = require("lvim.lsp.handlers").format_filter,
}
lvim.builtin.dap.active = true

lvim.colorscheme = "gruvbox"
vim.opt.background = "dark"
vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_contrast_light = "hard"
vim.opt.clipboard = ""
vim.opt.mouse = "n"
vim.opt.splitbelow = false
vim.opt.relativenumber = true
vim.g.markdown_fenced_languages = {
  "ts=typescript"
}

-- filetype.lua
-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0

if os.getenv("COLORSCHEME") == 'light' or vim.g.colorscheme == 'light' then
  -- lvim.colorscheme = "github_light"
  vim.o.background = "light"
end

-- Additional Plugins
-- Configuration syntax: https://github.com/wbthomason/packer.nvim#the-startup-function
lvim.plugins = {
  -- theme
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = true,
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,    -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        overrides = {},
      })
      vim.cmd("colorscheme gruvbox")
    end
  },
  "projekt0n/github-nvim-theme", -- for light theme
  -- git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  -- {
  --   "folke/trouble.nvim",
  --   config = function()
  --     require("trouble").setup {
  --       use_diagnostic_signs = true,
  --     }
  --   end
  -- },
  -- navigation
  "ThePrimeagen/harpoon",
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
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
    dependencies = {
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
    build = function()
      vim.fn['fzf#install']()
    end
  },
  {
    "ggandor/leap.nvim", -- super duper fast motions (s + {n1}{n2})
    -- S -> backwards
    dependencies = {
      "tpope/vim-repeat"
    },
    config = function()
      require("leap").add_default_mappings()
    end
  },
  {
    "folke/zen-mode.nvim",
    dependencies = {
      "folke/twilight.nvim"
    },
    config = function()
      require("zen-mode").setup {
        plugins = {
          options = {
            enabled = true,
            ruler = true,                -- disables the ruler text in the cmd line area
            showcmd = true,              -- disables the command in the last line of the screen
          },
          twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
          kitty = {
            enabled = true,
            font = "+2", -- font size increment
          },
        }
      }
    end
  },
  {
    "folke/twilight.nvim", -- zen mode (dim unused parts of code)
    config = function()
      require("twilight").setup()
    end
  },
  {
    "AckslD/nvim-neoclip.lua", -- register yanks
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'kkharji/sqlite.lua',           module = 'sqlite' },
    },
    config = function()
      require('neoclip').setup({
        history = 1000,
        enable_persistent_history = true,
        length_limit = 1048576,
        db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
      })
      require("telescope").load_extension("neoclip")
    end,
  },
  -- {
  --   "karb94/neoscroll.nvim",
  --   config = function()
  --     require('neoscroll').setup({
  --       performance_mode = true
  --     })
  --   end
  -- },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  },
  {
    "nvim-telescope/telescope-fzy-native.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" }
    },
    config = function()
      require("telescope").load_extension("fzy_native")
    end
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "kkharji/sqlite.lua" },
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      require("telescope").load_extension("frecency")
    end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim"
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
  {
    "chrisgrieser/nvim-genghis", -- file utils
    dependencies = "stevearc/dressing.nvim"
  },
  -- {
  --   "beauwilliams/focus.nvim", -- easier window management
  --   config = function()
  --     require("focus").setup()
  --   end
  -- },
  -- snippets
  {
    "avneesh0612/react-nextjs-snippets"
  },
  -- lsp addons
  "tpope/vim-surround",
  "tpope/vim-abolish",
  {
    "tpope/vim-dispatch",
    cmd = { "Dispatch", "Make", "Copen", "Focus", "Start" },
  },
  {
    "stevearc/overseer.nvim",
    config = function()
      require("overseer").setup()
    end
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = {
          enabled = true,
          auto_refresh = true,
          layout = {
            position = "right",
            ration = 0.4
          }
        }
      })
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua"
    },
    config = function()
      require("copilot_cmp").setup()
    end
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("null-ls").register({
        require("typescript.extensions.null-ls.code-actions")
      })
    end
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup({
        library = {
          plugins = { "neotest" },
          types = true,
        }
      })
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim", -- auto configure DAP from mason
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim"
    },
    config = function()
      require("mason-nvim-dap").setup({
        automatic_setup = {
          configurations = function(default)
            table.insert(default["node2"], {
              name = "Attach Next.js",
              type = "node2",
              request = "attach",
              address = "127.0.0.1",
              port = 9230
            })
            return default;
          end
        }
      })
    end
  },
  -- "simrat39/symbols-outline.nvim",
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
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    },
    config = function()
      require('refactoring').setup({})
      require("telescope").load_extension("refactoring")
    end
  },
  {
    "andymass/vim-matchup", -- language specific %
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    }
  },
  {
    "p00f/nvim-ts-rainbow",
    dependencies = {
      "nvim-treesitter/nvim-treesitter"
    },
    config = function()
      require("nvim-treesitter.configs").setup {
        rainbow = {
          enable = true,
          -- extended_mode = true,
          max_file_lines = 10000
        }
      }
    end
  },
  "gpanders/editorconfig.nvim",
  "Vimjas/vim-python-pep8-indent",
  "jxnblk/vim-mdx-js",
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup()
    end
  },
  {
    'Wansmer/sibling-swap.nvim',
    dependencies = { 'nvim-treesitter' },
    config = function()
      require('sibling-swap').setup({})
    end,
  },
  -- misc
  {
    "witoszekdev/nvim-treehopper", -- expand selection (ctrl + s),
    branch = "fix-missing-filetype"
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
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
  "tpope/vim-unimpaired",
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
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      -- test runners
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-python"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          -- require("neotest-jest"),
          require("neotest-vitest"),
          require("neotest-python"),
        },
        consumers = {

        },
        summary = {
          animated = true,
          enabled = true,
          expand_erros = true,
          follow = true,
          mappings = {
            attach = "a",
            clear_marked = "M",
            clear_target = "T",
            debug = "d",
            debug_marked = "D",
            expand = { "<CR>", "<2-LeftMouse>" },
            expand_all = "e",
            jumpto = "i",
            mark = "m",
            next_failed = "J",
            output = "o",
            prev_failed = "K",
            run = "t",
            run_marked = "T",
            short = "O",
            stop = "h",
            target = "t"
          },
        }
      })
    end
  },
  {
    "mtth/scratch.vim"
  },
  -- {
  --   'nvim-orgmode/orgmode',
  --   dependencies = { "nvim-treesitter/nvim-treesitter" },
  --   config = function()
  --     require('orgmode').setup_ts_grammar()
  --     require('orgmode').setup {
  --       org_agenda_files = { "~/org/**/*" }
  --     }
  --   end
  -- },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup({
        default_mappings = true
      })
    end
  },
  "SidOfc/mkdx",
  {
    "mracos/mermaid.vim",
    ft = { "mermaid" }
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require "octo".setup()
    end
  },
  {
    "mrjones2014/legendary.nvim", -- search commands + which_key
    dependencies = {
      "kkharji/sqlite.lua",
    },
    config = function()
      require("legendary").setup({
        which_key = {
          auto_register = true
        }
      })
    end
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

vim.keymap.set('i', '<C-A>', '<Plug>copilot#Accept("<CR>")', { noremap = true })

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

-- lvim.builtin.which_key.mappings["P"] = {
--   name = "Packer",
--   c = { "<cmd>PackerCompile<cr>", "Compile" },
--   i = { "<cmd>PackerInstall<cr>", "Install" },
--   r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
--   s = { "<cmd>PackerSync<cr>", "Sync" },
--   S = { "<cmd>PackerStatus<cr>", "Status" },
--   u = { "<cmd>PackerUpdate<cr>", "Update" },
-- }

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
  t = { "<cmd>TodoTelescope<CR>", "todo list - telescope" },
  T = { "<cmd>TodoQuickFix<CR>", "todo list - quickfix" },
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

lvim.builtin.which_key.mappings["t"] = {
  name = "Tests",
  T = { function() require("neotest").run.run(vim.fn.expand("%")) end, "run all tests in file" },
  t = { function() require("neotest").run.run() end, "run nearest" },
  a = { function() require("neotest").run.attach() end, "attach to nearest test" },
  d = { function() require("neotest").run.run({ strategy = "dap" }) end, "run nearest + debug" },
  h = { function() require("neotest").run.stop() end, "stop nearest test" },
  H = { function() require("neotest").run.run(vim.fn.expand("%")) end, "stop all test in file" },
  o = { function() require("neotest").output.open({ enter = true }) end, "show test output" },
  s = { function() require("neotest").summary.toggle() end, "toggle show summary" },
  r = { function() require("neotest").run.run_last() end, "run last test" },
  l = { function() require("neotest").output_panel.toggle() end, "show output panel" },
}

vim.api.nvim_set_keymap("n", "]r", '', {
  noremap = true,
  callback = function()
    require("neotest").jump.next({ status = "failed" })
  end,
  desc = "Go to next failed test"
})
vim.api.nvim_set_keymap("n", "[r", '', {
  noremap = true,
  callback = function()
    require("neotest").jump.prev({ status = "failed" })
  end,
  desc = "Go to prev failed test"
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
lvim.builtin.which_key.mappings["h"] = { function() require("telescope").extensions.neoclip.default() end,
  "Yanks history" }

lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = formatTimeout }
  end,
  "Format",
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
-- lvim.builtin.notify.active = false
-- lvim.builtin.notify.opts.stages = "fade_in_slide_out"

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

lvim.builtin.nvimtree.setup.respect_buf_cwd = true
lvim.builtin.nvimtree.setup.update_cwd = false
lvim.builtin.nvimtree.setup.update_focused_file = { enable = false, update_cwd = false }

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
-- lvim.builtin.notify.active = true
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

lvim.builtin.luasnip.sources.friendly_snippets = true

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

vim.filetype.add({
  extension = {
    har = "json",
  }
})

-- require 'lspconfig'.eslint.setup {}
-- require 'lspconfig'.tailwindcss.setup {}
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { name = 'eslint_d' },
--   { name = 'prettierd' },
--   -- { name = "eslint" },
--   -- { name = "prettier" }
-- }

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
