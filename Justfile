# https://nixos-and-flakes.thiscute.world/best-practices/simplify-nixos-related-commands

host := `hostname`

default: update system home

update:
    nix flake update  --flake '.' --extra-experimental-features 'nix-command flakes'

update-dotfile:
    nix flake lock --update-input dotfile

update-shared-sops:
    sops updatekeys secrets/shared.yaml

home:
    nix build ".?submodule=1#homeConfigurations.{{ host }}.activationPackage" --extra-experimental-features 'nix-command flakes' --show-trace && result/activate

system:
    sudo nixos-rebuild switch --flake ".?submodules=1#{{ host }}" --show-trace

fmt:
    nix fmt

hist:
    nix profile history --profile /nix/var/nix/profiles/system

clean-system d:
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than {{ d }}d --extra-experimental-features "nix-command flakes"

clean-user:
    sudo rm /nix/var/nix/gcroots/auto/*

gc:
    sudo nix-collect-garbage -d

op:
    nix store optimise
