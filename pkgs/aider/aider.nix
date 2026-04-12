{
  pkgs,
  uv2nix,
  pyproject-nix,
  pyproject-build-systems,
}:

let
  python = pkgs.python312;

  src = pkgs.fetchFromGitHub {
    owner = "aider-ai";
    repo = "aider";
    rev = "v0.86.2";
    hash = "sha256-jaXXBMPUxX1dTeKuwA864hhlhdYLJfvtFdAIGmaqoGI=";
  };

  workspaceSrc = pkgs.runCommand "aider-workspace-src" { } ''
    cp -r ${src} $out
    chmod -R u+w $out
    sed -i "s/setuptools_scm\[toml\]>=8/setuptools_scm>=8/" "$out/pyproject.toml"
    cp ${./uv.lock} $out/uv.lock
  '';

  workspace = uv2nix.lib.workspace.loadWorkspace {
    workspaceRoot = workspaceSrc;
  };

  overlay = workspace.mkPyprojectOverlay {
    sourcePreference = "wheel";
  };

  pythonSet =
    (pkgs.callPackage pyproject-nix.build.packages {
      inherit python;
    }).overrideScope
      (pkgs.lib.composeManyExtensions [
        pyproject-build-systems.overlays.default
        overlay
      ]);

  deps = workspace.deps.default // (workspace.deps.playwright or { });

  venv = pythonSet.mkVirtualEnv "aider" deps;
in
pkgs.symlinkJoin {
  name = "aider";
  paths = [ venv ];
  nativeBuildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    libPath="${pkgs.lib.makeLibraryPath [
      pkgs.portaudio
      pkgs.libsndfile
      pkgs.alsa-lib
      pkgs.libpulseaudio
      pkgs.stdenv.cc.cc.lib
    ]}"

    for prog in "$out/bin/aider" "$out/bin/aider-chat"; do
      if [ -x "$prog" ]; then
        wrapProgram "$prog" --prefix LD_LIBRARY_PATH : "$libPath"
      fi
    done
  '';
}
