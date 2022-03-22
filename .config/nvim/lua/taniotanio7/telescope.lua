require("telescope").setup({
    defaults = {
        color_devicons = true
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
