{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager/release-25.05";

    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager, ... }:
  let
    configuration = { pkgs, config, ... }: {

      system.primaryUser = "dustinm";

      ids.gids.nixbld = 350;

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      environment.systemPackages = with pkgs; [
        bat
        cowsay
        discord
        eza
        fzf
        gcc
        git
        htop
        kitty
        lf
        millet
        mkalias
        neofetch
        neovim
        obsidian
        python3Full
        riffdiff
        skimpdf
        spotify
        texliveFull
        texlivePackages.enumitem
        tmux
        yadm
        zsh-syntax-highlighting
      ];

      homebrew = {
        enable = true;
        brews = [
          "python@3.9"
          "koekeishiya/formulae/skhd"
          "koekeishiya/formulae/yabai"
        ];
        casks = [
          "bitwarden"
          "karabiner-elements"
          "qutebrowser"
          "smlnj"
        ];
        masApps = {
          "amphetamine" = 937984704;
          "goodnotes" = 1444383602;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];
      
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';

      system = {
        defaults = {
          dock = {
            autohide = true;
            persistent-apps = [
              "/Applications/qutebrowser.app"
              "${pkgs.kitty}/Applications/kitty.app"
              "${pkgs.spotify}/Applications/spotify.app"
            ];
            show-recents = false;
            wvous-bl-corner = 1;
            wvous-br-corner = 1;
            wvous-tl-corner = 1;
            wvous-tr-corner = 1;
          };
          finder = {
            _FXShowPosixPathInTitle        = true;
            _FXSortFoldersFirst            = true;
            AppleShowAllExtensions         = true;
            FXEnableExtensionChangeWarning = false;
            FXRemoveOldTrashItems          = false;
            ShowPathbar                    = true;
            QuitMenuItem                   = true;
            ShowStatusBar                  = true;
          };
          NSGlobalDomain.AppleICUForce24HourTime = true;
        };

        startup.chime = false;
      };


      nix.settings.experimental-features = "nix-command flakes";
      nix.settings.trusted-users = [ "root" "dustinm" ];
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 3;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild switch --flake ~/nix#dustinm
    darwinConfigurations."dustinm" = nix-darwin.lib.darwinSystem {
      modules = [
        ./users.nix

        configuration

        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable        = true;
            enableRosetta = true;
            user          = "dustinm";
            autoMigrate   = true;
          };
        }

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs   = true;
          home-manager.useUserPackages = true;
          home-manager.users.dustinm   = ./home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
