args:

let dir = builtins.readDir ./.;
    hosts = builtins.foldl' (acc: name: let type = builtins.getAttr name dir; in if type == "directory" then acc++[name] else acc ) [] (builtins.attrNames dir);
in builtins.listToAttrs (builtins.map (hostname: {
  name  = hostname;
  value = import (./. + "/${hostname}")  (args // { inherit hostname; });
}) hosts)
