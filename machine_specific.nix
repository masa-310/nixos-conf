{ config, pkgs, ...}:

{
  programs.ssh = {
    matchBlocks = {
      "124.33.178.187" = {
        port = 63448;
      };
      "netgate0" = {
        hostname = "124.33.178.187";
        port = 63448;
        user = "masashi";
      };
      "netgate1" = {
        hostname = "124.33.178.186";
        port = 63448;
        user = "masashi";
      };
      "netgate2" = {
        hostname = "124.33.178.181";
        port = 63448;
        user = "narita";
      };
    };
  };
}
