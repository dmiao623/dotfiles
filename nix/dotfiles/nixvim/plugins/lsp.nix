{ ... }:

{
  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      bashls.enable    = true;
      clangd.enable    = true;
      cssls.enable     = true;
      html.enable      = true;
      jsonls.enable    = true;
      ltex.enable      = true;
      lua_ls = {
        enable = true;
        settings = {
          Lua.diagnostics.globals = [ "vim" ];
          Lua.completion.callSnippet = "Replace";
        };
      };
      marksman.enable  = true;
      pyright.enable   = true;
      yamlls.enable    = true;
    };

    keymaps = {
      lspBuf = {
        "gD"          = { action = "declaration"; desc = "(lsp) Go to declaration"; };
        "<leader>rn"  = { action = "rename";      desc = "(lsp) Smart rename"; };
      };
      diagnostic = {
        "<leader>d" = { action = "open_float"; desc = "(lsp) Show line diagnostics"; };
      };
      extra = [
        { mode = "n"; key = "gR"; action = "<cmd>Telescope lsp_references<CR>";  options.desc = "(telescope, lsp) Show LSP references"; }
        { mode = "n"; key = "gd"; action = "<cmd>Telescope lsp_definitions<CR>"; options.desc = "(lsp) Show LSP definitions"; }
      ];
    };

    preConfig = ''
      -- Diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    '';

    postConfig = ''
      -- Millet (SML) — installed via nix, not managed by nixvim's server list
      require("lspconfig").millet.setup({
        cmd = { "millet" },
        filetypes = { "sml", "fun" },
        root_dir = require("lspconfig.util").root_pattern(".git", ".millet_root"),
      })

      -- Clangd with custom compile-commands dir
      require("lspconfig").clangd.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        cmd = {
          "clangd",
          "--compile-commands-dir=" .. vim.fn.expand("/Users/dustinm/projects/cp/_library"),
          "--header-insertion=never",
        },
        root_dir = require("lspconfig.util").root_pattern(
          "compile_commands.json", "compile_flags.txt", ".git"
        ),
      })
    '';
  };
}
