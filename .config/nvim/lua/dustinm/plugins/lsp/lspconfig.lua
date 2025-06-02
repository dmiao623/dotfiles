return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "(telescope, lsp) Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "(lsp) Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "(lsp) Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "(lsp) Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "(lsp) Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
      ["clangd"] = function()
        lspconfig.clangd.setup({
          capabilities = capabilities,
          cmd = {
            "clangd",
            "--compile-commands-dir=" .. vim.fn.expand("/Users/dustinm/projects/cp/_library"),
            "--header-insertion=never",
          },
          root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
          settings = {
            includePath = {
              vim.fn.expand("~/projects/cp/_library"),
            },
          },
        })
      end,

      -- Manual millet config
      lspconfig.millet.setup({
        cmd = { "millet" },
        filetypes = { "sml", "fun" },
        root_dir = lspconfig.util.root_pattern(".git", ".millet_root"),
      })
    })
  end,
}
