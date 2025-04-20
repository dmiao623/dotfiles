{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, ... }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      environment.systemPackages = with pkgs; [
        bat
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
        nodejs_23
        obsidian
        onefetch
        python3Full
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

      fonts.packages = [
        pkgs.nerd-fonts.jetbrains-mono
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

      system.defaults = {
        dock.autohide = true;
        dock.persistent-apps = [
          "/Applications/qutebrowser.app"
          "${pkgs.kitty}/Applications/kitty.app"
          "${pkgs.spotify}/Applications/spotify.app"
        ];
        NSGlobalDomain.AppleICUForce24HourTime = true;
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Dustins-MacBook-Pro
    darwinConfigurations."dustinm" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "dustinm";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
      ];
    };
  };
}
