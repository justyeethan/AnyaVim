return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "basedpyright",
        "ruff",
        "debugpy",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "basic",
                autoImportCompletions = true,
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
        ruff = {},
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = {
                  -- pycodestyle's defaults plus E501 (line too long)
                  ignore = { "E121", "E123", "E126", "E226", "E24", "E704", "W503", "W504", "E501" },
                },
              },
            },
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format" },
      },
    },
  },
}
