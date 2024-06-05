local actions = require("telescope.actions")

if true then
  return {
    -- Configure LazyVim to load gruvbox
    { "ayu-theme/ayu-vim" },
    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = {
        window = {
          position = "right",
        },
      },
    },
    {
      "projekt0n/github-nvim-theme",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        require("github-theme").setup({
          -- ...
        })

        vim.cmd("colorscheme github_dark_default")
      end,
    },
    -- change some telescope options and a keymap to browse plugin files
    {
      "nvim-telescope/telescope.nvim",
      keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      },
      -- change some options
      opts = {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          winblend = 0,
          mappings = {
            i = {
              ["<C-T>"] = false, -- Override prior <C-T> keymapping
              ["<C-T>"] = actions.select_tab,
            },
            n = {
              ["t"] = actions.select_tab,
            },
          },
        },
      },
    },
    {
      "ray-x/go.nvim",
      dependencies = { -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("go").setup()
      end,
      event = { "CmdlineEnter" },
      ft = { "go", "gomod" },
      build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    {
      "nvimdev/dashboard-nvim",
      event = "VimEnter",
      opts = function()
        local logo = require("anyaVim").randomAnya
        logo = string.rep("\n", 1) .. logo .. "\n\n"
        local opts = {
          theme = "doom",
          hide = {
            -- this is taken care of by lualine
            -- enabling this messes up the actual laststatus setting after loading a file
            statusline = false,
          },
          config = {
            header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
            { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
            { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
            { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
            { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
            -- { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
            -- { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
          },
            footer = function()
              local stats = require("lazy").stats()
              local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
              return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
            end,
          },
        }

        for _, button in ipairs(opts.config.center) do
          button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
          button.key_format = "  %s"
        end

        -- close Lazy and re-open when the dashboard is ready
        if vim.o.filetype == "lazy" then
          vim.cmd.close()
          vim.api.nvim_create_autocmd("User", {
            pattern = "DashboardLoaded",
            callback = function()
              require("lazy").show()
            end,
          })
        end
        return opts
      end,
    },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "ayu",
      },
    },
    {
      "akinsho/bufferline.nvim",
      opts = {
        options = {
          indicators = {
            style = "underline",
          },
          buffer_close_icon = "",
          separator_style = "slope",
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
        },
      },
    },
  }
end

-- !IMPORTANT! - These are default configurations
-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
-- return {
--   -- Configure LazyVim to load gruvbox
--   {
--     "LazyVim/LazyVim",
--     --     opts = {
--     --       colorscheme = "ayu",
--     --     },
--   },
--
--   -- change trouble config
--   {
--     "folke/trouble.nvim",
--     -- opts will be merged with the parent spec
--     opts = { use_diagnostic_signs = true },
--   },
--
--   -- disable trouble
--   { "folke/trouble.nvim", enabled = false },
--
--   -- add symbols-outline
--   {
--     "simrat39/symbols-outline.nvim",
--     cmd = "SymbolsOutline",
--     keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
--     config = true,
--   },
--
--   -- override nvim-cmp and add cmp-emoji
--   {
--     "hrsh7th/nvim-cmp",
--     dependencies = { "hrsh7th/cmp-emoji" },
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--       table.insert(opts.sources, { name = "emoji" })
--     end,
--   },
--
--   -- change some telescope options and a keymap to browse plugin files
--   {
--     "nvim-telescope/telescope.nvim",
--     keys = {
--       -- add a keymap to browse plugin files
--       -- stylua: ignore
--       {
--         "<leader>fp",
--         function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
--         desc = "Find Plugin File",
--       },
--     },
--     -- change some options
--     opts = {
--       defaults = {
--         layout_strategy = "horizontal",
--         layout_config = { prompt_position = "top" },
--         sorting_strategy = "ascending",
--         winblend = 0,
--         mappings = {
--           i = {
--             ["<C-T>"] = actions.select_tab,
--           },
--           n = {
--             ["<C-T>"] = actions.select_tab,
--           },
--         },
--       },
--     },
--   },
--
--   -- add telescope-fzf-native
--   {
--     "telescope.nvim",
--     dependencies = {
--       "nvim-telescope/telescope-fzf-native.nvim",
--       build = "make",
--       config = function()
--         require("telescope").load_extension("fzf")
--       end,
--     },
--   },
--
--   -- add pyright to lspconfig
--   {
--     "neovim/nvim-lspconfig",
--     ---@class PluginLspOpts
--     opts = {
--       ---@type lspconfig.options
--       servers = {
--         -- pyright will be automatically installed with mason and loaded with lspconfig
--         pyright = {},
--       },
--     },
--   },
--
--   -- add tsserver and setup with typescript.nvim instead of lspconfig
--   {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--       "jose-elias-alvarez/typescript.nvim",
--       init = function()
--         require("lazyvim.util").on_attach(function(_, buffer)
--           -- stylua: ignore
--           vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
--           vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
--         end)
--       end,
--     },
--     ---@class PluginLspOpts
--     opts = {
--       ---@type lspconfig.options
--       servers = {
--         -- tsserver will be automatically installed with mason and loaded with lspconfig
--         tsserver = {},
--       },
--       -- you can do any additional lsp server setup here
--       -- return true if you don't want this server to be setup with lspconfig
--       ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
--       setup = {
--         -- example to setup with typescript.nvim
--         tsserver = function(_, opts)
--           require("typescript").setup({ server = opts })
--           return true
--         end,
--         -- Specify * to use this function as a fallback for any server
--         -- ["*"] = function(server, opts) end,
--       },
--     },
--   },
--
--   -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
--   -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
--   { import = "lazyvim.plugins.extras.lang.typescript" },
--
--   -- add more treesitter parsers
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = {
--       ensure_installed = {
--         "bash",
--         "html",
--         "javascript",
--         "json",
--         "lua",
--         "markdown",
--         "markdown_inline",
--         "python",
--         "query",
--         "regex",
--         "tsx",
--         "typescript",
--         "vim",
--         "yaml",
--       },
--     },
--   },
--
--   -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
--   -- would overwrite `ensure_installed` with the new value.
--   -- If you'd rather extend the default config, use the code below instead:
--   {
--     "nvim-treesitter/nvim-treesitter",
--     opts = function(_, opts)
--       -- add tsx and treesitter
--       vim.list_extend(opts.ensure_installed, {
--         "tsx",
--         "typescript",
--       })
--     end,
--   },
--
--   -- the opts function can also be used to change the default opts:
--   {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     opts = function(_, opts)
--       table.insert(opts.sections.lualine_x, "😄")
--     end,
--   },
--
--   -- or you can return new options to override all the defaults
--   {
--     "nvim-lualine/lualine.nvim",
--     event = "VeryLazy",
--     opts = function()
--       return {
--         --[[add your custom lualine config here]]
--       }
--     end,
--   },
--
--   -- use mini.starter instead of alpha
--   { import = "lazyvim.plugins.extras.ui.mini-starter" },
--
--   -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
--   { import = "lazyvim.plugins.extras.lang.json" },
--
--   -- add any tools you want to have installed below
--   {
--     "williamboman/mason.nvim",
--     opts = {
--       ensure_installed = {
--         "stylua",
--         "shellcheck",
--         "shfmt",
--         "flake8",
--       },
--     },
--   },
--
--   -- Use <tab> for completion and snippets (supertab)
--   -- first: disable default <tab> and <s-tab> behavior in LuaSnip
--   {
--     "L3MON4D3/LuaSnip",
--     keys = function()
--       return {}
--     end,
--   },
--   -- then: setup supertab in cmp
--   {
--     "hrsh7th/nvim-cmp",
--     dependencies = {
--       "hrsh7th/cmp-emoji",
--     },
--     ---@param opts cmp.ConfigSchema
--     opts = function(_, opts)
--       local has_words_before = function()
--         unpack = unpack or table.unpack
--         local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--         return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--       end
--
--       local luasnip = require("luasnip")
--       local cmp = require("cmp")
--
--       opts.mapping = vim.tbl_extend("force", opts.mapping, {
--         ["<Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_next_item()
--             -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
--             -- this way you will only jump inside the snippet region
--           elseif luasnip.expand_or_jumpable() then
--             luasnip.expand_or_jump()
--           elseif has_words_before() then
--             cmp.complete()
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--           if cmp.visible() then
--             cmp.select_prev_item()
--           elseif luasnip.jumpable(-1) then
--             luasnip.jump(-1)
--           else
--             fallback()
--           end
--         end, { "i", "s" }),
--       })
--     end,
--   },
-- }
