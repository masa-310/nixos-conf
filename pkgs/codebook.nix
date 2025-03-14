{ pkgs }:pkgs.stdenv.mkDerivation {
  name = "codebook";
  src = fetchTarball {
    name = "codebook";
    url  = "https://github.com/blopker/codebook/releases/download/v0.2.4/codebook-lsp-x86_64-unknown-linux-gnu.tar.gz";
    sha256 = "sha256:08j96ybjlx90kfz5fk23lmgg1ww2bz38kmnjvav35mrx50z7dx1j";
  };
  phases = ["installPhase"];
  installPhase = "mkdir -p $out/bin; cp -r $src $out/bin";
}
