{ lib, ... }:

{
  programs.nixvim.plugins = {
    cmp = {
      enable = true;

      settings = {
        completion.completeopt = "menu,menuone,preview,noselect";

        snippet.expand = { __raw = "function(args) require('luasnip').lsp_expand(args.body) end"; };

        mapping = {
          "<C-k>"     = { __raw = "require('cmp').mapping.select_prev_item()"; };
          "<C-j>"     = { __raw = "require('cmp').mapping.select_next_item()"; };
          "<C-Space>" = { __raw = "require('cmp').mapping.complete()"; };
          "<C-e>"     = { __raw = "require('cmp').mapping.abort()"; };
          "<CR>"      = { __raw = "require('cmp').mapping.confirm({ select = false })"; };
        };

        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];

        formatting.format = lib.mkForce { __raw = ''
          require("lspkind").cmp_format({ maxwidth = 50, ellipsis_char = "..." })
        ''; };

        # Disabled by default; toggled via CmpToggle user command
        enabled = { __raw = "function() return vim.g.cmp_enabled end"; };
      };
    };

    luasnip = {
      enable = true;
      fromVscode = [ {} ];
    };

    friendly-snippets.enable = true;

    lspkind = {
      enable = true;
      settings.mode = "symbol_text";
    };

    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable   = true;
    cmp-path.enable     = true;
    cmp_luasnip.enable  = true;

    nvim-autopairs = {
      enable = true;
      settings = {
        check_ts = true;
        ts_config.lua = [ "string" ];
      };
    };
  };

  programs.nixvim.extraConfigLua = ''
    -- Wire autopairs into cmp confirm
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
  '';
}
