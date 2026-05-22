-- LSP, Mason tools and Treesitter parsers for all supported languages.
-- LazyVim extras handle the heavy lifting; this file fills gaps and ensures
-- formatters / linters are always installed via Mason.
return {

  -- ─── Mason: ensure extra tools are installed ────────────────────────────────
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Lua
        "stylua",
        -- Shell
        "shellcheck",
        "shfmt",
        -- Python
        "pyright",
        "ruff",
        "black",
        "isort",
        -- Go
        "gopls",
        "goimports",
        "golangci-lint",
        -- Terraform / HCL
        "terraform-ls",
        "tflint",
        -- C / C++
        "clangd",
        "clang-format",
        -- C# (.NET)
        "omnisharp",
        "csharpier",
        -- Java
        "jdtls",
        "google-java-format",
        -- YAML / JSON / TOML
        "yamllint",
        "jsonlint",
        -- Docker
        "hadolint",
        -- Markdown
        "markdownlint",
        "prettierd",
      },
    },
  },

  -- ─── nvim-lspconfig: fine-tune individual servers ───────────────────────────
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Global diagnostic display settings
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      },
      -- inlay hints are opt-in per-language
      inlay_hints = { enabled = false },
      servers = {
        -- ── Python ──────────────────────────────────────────────────────────
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },

        -- ── Go ──────────────────────────────────────────────────────────────
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.venv", "-node_modules" },
              semanticTokens = true,
            },
          },
        },

        -- ── Terraform ───────────────────────────────────────────────────────
        terraformls = {},

        -- ── C / C++ (clangd is set up via lazyvim extras.lang.clangd) ───────
        clangd = {
          keys = {
            { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },

        -- ── C# (OmniSharp is set up via lazyvim extras.lang.omnisharp) ──────
        omnisharp = {
          -- Enable Roslyn analysers
          enable_roslyn_analyzers = true,
          organize_imports_on_format = true,
          enable_import_completion = true,
        },
      },
    },
  },

  -- ─── Treesitter: ensure parsers for all languages ───────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed or {}, {
        "c",
        "cpp",
        "c_sharp",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "java",
        "python",
        "terraform",
        "hcl",
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "json",
        "jsonc",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "dockerfile",
        "gitcommit",
        "gitignore",
        "diff",
        "regex",
        "query",
      })
    end,
  },

  -- ─── conform.nvim: formatters per filetype ──────────────────────────────────
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "goimports", "gofmt" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        cs = { "csharpier" },
        java = { "google-java-format" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd", "markdownlint" },
      },
    },
  },
}
