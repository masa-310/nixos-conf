# NixOS Configuration

## Sync latest inputs
```bash
./scripts/update
```

## Configure system
```bash
./scripts/switch-system ${HOST_NAME}
```

## Configure home
```bash
./scripts/switch-home ${HOST_NAME}
```

## Manage secrets using sops-nix
Please refer to [Mic92/sops-nix](https://github.com/Mic92/sops-nix) or [Managing secrets in NixOS & Home-Manager with sops-nix](https://zohaib.me/managing-secrets-in-nixos-home-manager-with-sops/).

### Setup for the new host
1. **Store identities from Yubikey using age-plugin-yubikey**
    `age-plugin-yubikey --identity > ~/.config/sops/age/keys.txt`

2.  **Edit secrets**
    3.1. `sops secrets/shared.yaml` for shared secrets.
    3.2. `sops secrets/hosts/${YOUR_HOSTNAME}.yaml` for your host-specific secrets.

3.  **Add `sops.secrets` section**
    Add the `sops.secrets` section to your Home Manager or NixOS configuration (`home/default.nix` or `configuration.nix`) where you intend to use the secrets.

4.  **Use the secrets in your configuration**
    Reference the secrets in your configuration using `config.sops.secrets.XXX.path`.
