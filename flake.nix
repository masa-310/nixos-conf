{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    wezterm-flake = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dotfile = {
      url = "github:masa-310/dotfiles";
      flake = false;
    };
    xid-gen = {
      url = "github:masa-310/xid-gen";
      flake = true;
    };
    geminicommit-custom = {
      url = "github:masa-310/geminicommit";
      flake = true;
    };
    xmonad-config.url = "github:masa-310/xmonad-conf";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, nixpkgs, nixpkgs-unstable, home-manager, dotfile, xid-gen, nixos-hardware, xmonad-config, wezterm-flake, sops-nix, geminicommit-custom, ... }: 
    let
      overlay = final: prev: {};
      overlays = [overlay];
      system = "x86_64-linux";

      config = {
        allowUnfree = true;
        permittedInsecurePackages = [ "electron-25.9.0" ];
      };
      pkgs = import nixpkgs { inherit system overlays config; } // { outPath = nixpkgs.outPath; lib = nixpkgs.lib;};
      unstable = import nixpkgs-unstable { inherit system overlays config; } // { outPath = nixpkgs-unstable.outPath; lib = nixpkgs-unstable.lib;};

      codebook = import ./pkgs/codebook.nix { pkgs = unstable; };
      extra = { inherit dotfile nixos-hardware xmonad-config xid-gen wezterm-flake codebook sops-nix geminicommit-custom; };

      confByHost = import ./hosts { inherit system home-manager pkgs unstable extra; };
      nixosConfigurations = builtins.mapAttrs (_: conf: conf.nixosConfigurations) confByHost;
      homeConfigurations = builtins.mapAttrs (_: conf: conf.homeConfigurations) confByHost;
    in {
      inherit nixosConfigurations homeConfigurations;
    };
}
