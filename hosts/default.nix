{ config }:

let hosts = builtins.filterSource (path: type: type != "directory") .
                    in mapAttrs (path: type: path)
in {
  imports = hosts
    
