require("telescope").setup({
    defaults = {
        color_devicons = true,
        file_ignore_patterns = {
            "node_modules",
            "*.generated.*"
        },
        path_display={"smart"},
        use_less = true
    },
    pickers = {
        find_files = {
            theme = "dropdown",
            hidden = true
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
})

require('telescope').load_extension('fzy_native')
require("telescope").load_extension('harpoon')
require("telescope").load_extension("live_grep_raw")
require("telescope").load_extension("frecency")
