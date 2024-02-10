{ lib, config, pkgs, dotfile, ... }:

with builtins;
with lib;
let self = config.modules.program.haskell;
    hls = pkgs.haskell-language-server.override {
      supportedGhcVersions = [ "92" ];
    };
in {
  imports = [];
  options.modules.program.haskell = {
    enable = mkEnableOption "haskell";
    ghc = mkOption {
      type = types.attrs;
      default = {
        enable = false;
      };
      description = ''
        Specify GHC version if necessary

        Example: {
          enable = true;
          version = 924;
          binary = true;
        }
      '';
    };
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      stack
      hls
    ]  ++ (if self.ghc.enable then [ haskell.compiler.${"ghc${toString self.ghc.version}${if self.ghc.binary then "Binary" else ""}"} ] else []);
  };
}
