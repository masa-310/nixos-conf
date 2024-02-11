host := `hostname`

default: update system home

update:
  nix flake update '.' --extra-experimental-features 'nix-command flakes'

update-dotfile:
  nix flake lock --update-input dotfile

home:
  nix build ".?submodule=1#homeConfigurations.{{host}}.activationPackage" --extra-experimental-features 'nix-command flakes' && result/activate

system:
  sudo nixos-rebuild switch --flake ".?submodules=1#{{host}}"

fmt:
  nix fmt
