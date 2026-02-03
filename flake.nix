{
  description = "NixOS config";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    wezterm-flake = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-flake = {
      url = "github:masa-310/helix/personal";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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
    nur = {
      url = "github:charmbracelet/nur";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      dotfile,
      xid-gen,
      nixos-hardware,
      xmonad-config,
      wezterm-flake,
      helix-flake,
      sops-nix,
      geminicommit-custom,
      nur,
      ...
    }:
    let
      overlay = final: prev: { };
      overlays = [ overlay ];
      system = "x86_64-linux";

      config = {
        allowUnfree = true;
        permittedInsecurePackages = [ "electron-25.9.0" ];
      };
      pkgs = import nixpkgs { inherit system overlays config; } // {
        outPath = nixpkgs.outPath;
        lib = nixpkgs.lib;
      };
      unstable = import nixpkgs-unstable { inherit system overlays config; } // {
        outPath = nixpkgs-unstable.outPath;
        lib = nixpkgs-unstable.lib;
      };

      codebook = import ./pkgs/codebook.nix { pkgs = unstable; };
      coderabbit = pkgs.callPackage ./pkgs/coderabbit.nix { };
      extra = {
        inherit
          dotfile
          nixos-hardware
          xmonad-config
          xid-gen
          wezterm-flake
          helix-flake
          codebook
          coderabbit
          sops-nix
          geminicommit-custom
          nur
          ;
      };

      confByHost = import ./hosts {
        inherit
          system
          home-manager
          pkgs
          unstable
          extra
          ;
      };
      nixosConfigurations = builtins.mapAttrs (_: conf: conf.nixosConfigurations) confByHost;
      homeConfigurations = builtins.mapAttrs (_: conf: conf.homeConfigurations) confByHost;
    in
    {
      inherit nixosConfigurations homeConfigurations;
    };
}
