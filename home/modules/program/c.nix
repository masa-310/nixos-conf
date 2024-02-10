{ lib, config, pkgs, dotfile, ... }:

with builtins;
with lib;
let self = config.modules.program.c;
in {
  imports = [];
  options.modules.program.c = {
    enable = mkEnableOption "c";
    use-clang = mkOption {
      type = types.bool;
      default = false;
      description = "Install clang and clang++ additionally";
    };
    /*
    use-clangd = mkOption {
      type = types.bool;
      default = false;
      description = "Use clangd instead of ccls";
    };
    */
  };
  config = mkIf self.enable {
    home.packages = with pkgs; [
      gcc
      ccls
    ]
    ++  (if self.use-clang then
          [llvmPackages.clangUseLLVM]
         else
          []
        );
    /*  
    ++  (if self.use-clangd then
          [clangd]
         else
          [ccls]
        );
    */
  };
}
