# https://nixos-and-flakes.thiscute.world/best-practices/simplify-nixos-related-commands
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


hist:
  nix profile history --profile /nix/var/nix/profiles/system

clean-system d:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than {{d}}d

clean-user:
  sudo rm /nix/var/nix/gcroots/auto/*

gc:
  sudo nix-collect-garbage -d
