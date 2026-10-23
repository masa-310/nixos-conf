# nixpkgs に適用する共通オーバーレイ一覧。
# flake.nix の `overlays` と NixOS モジュールの `nixpkgs.overlays` の両方から読む。
[
  (import ./mozc-uic-class-name.nix)
]
