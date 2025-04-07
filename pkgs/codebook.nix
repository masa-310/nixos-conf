{ pkgs }:

pkgs.rustPlatform.buildRustPackage rec {
  name = "codebook";
  pname = "codebook";
  version = "0.2.4";
  cargoSha256 = "";
  src = pkgs.fetchFromGitHub {
    owner= "blopker";
    repo = "codebook";
    rev = "v${version}";
    sha256 = "sha256-My22vLhPN5oPKQxWGYrEtODveGnDJ+8CdI2jQ2X5XOU=";
  };
  nativeBuildInputs = with pkgs; [
    perl
    bun
  ];
  buildInput = with pkgs; [
    cargo
    rustc
  ];
  buildPhase = ''
    make build-release
  '';
  buildType = "release";
  cargoHash = "sha256-3yd0P9OWvmeYgrujsXQ5kEEdsDyomOKd0Ylj7OY4ZRU=";
  checkType = "debug";
  doCheck = false;
  installPhase = ''
    mkdir -p $out/bin
    cp ./target/release/codebook-lsp $out/bin
  '';
}
