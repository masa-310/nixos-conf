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

### Setup
1.  **Generate age public/secret keys**
    ```sh
    mkdir -p ~/.config/sops/age
    age-keygen -o ~/.config/sops/age/keys.txt
    ```
2.  **Add created public keys to `.sops.yaml`**
    2.1. Add your public key, paired with your hostname, to the `keys` entry.
    2.2. Add your hostname's key group to the `creation_rules[path_regex="secrets/shared.yaml"].key_groups.age` entry.
    2.3. For host-specific secrets, add the same key group to `creation_rules[path_regex="secrets/hosts/${YOUR_HOSTNAME}.yaml"]`.

3.  **Edit secrets**
    3.1. `sops secrets/shared.yaml` for shared secrets.
    3.2. `sops secrets/hosts/${YOUR_HOSTNAME}.yaml` for your host-specific secrets.

4.  **Add `sops.secrets` section**
    Add the `sops.secrets` section to your Home Manager or NixOS configuration (`home/default.nix` or `configuration.nix`) where you intend to use the secrets.

5.  **Use the secrets in your configuration**
    Reference the secrets in your configuration using `config.sops.secrets.XXX.path`.
