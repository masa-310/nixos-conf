# https://github.com/numtide/nix-ai-tools/blob/main/packages/coderabbit-cli/package.nix
{
  lib,
  stdenv,
  fetchurl,
  unzip,
  autoPatchelfHook,
}:

stdenv.mkDerivation rec {
  pname = "coderabbit-cli";
  version = "0.3.4";

  src = fetchurl {
    url = "https://cli.coderabbit.ai/releases/${version}/coderabbit-linux-x64.zip";
    hash = "sha256-pppu5Ej5ZbNqSWtO9zqcvYeYIKLZPGEyOfMY9mnVIEs=";
  };

  nativeBuildInputs = [ unzip ] ++ lib.optionals stdenv.isLinux [ autoPatchelfHook ];

  unpackPhase = ''
    unzip $src
  '';

  dontStrip = true; # to no mess with the bun runtime

  installPhase = ''
    runHook preInstall

    install -Dm755 coderabbit $out/bin/coderabbit
    ln -s $out/bin/coderabbit $out/bin/cr

    runHook postInstall
  '';

  meta = with lib; {
    description = "AI-powered code review CLI tool";
    homepage = "https://coderabbit.ai";
    license = licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
    ];
    mainProgram = "coderabbit";
  };
}
