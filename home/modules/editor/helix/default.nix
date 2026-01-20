{
  lib,
  config,
  pkgs,
  extra,
  ...
}:

with builtins;
with lib;
let
  self = config.modules.editor.helix;
in
{
  imports = [ ];
  options.modules.editor.helix = {
    enable = mkEnableOption "helix";
    use-yazi = mkOption {
      type = types.bool;
      default = true;
    };
    use-aider = mkOption {
      type = types.bool;
      default = true;
    };
  };
  config = mkIf self.enable {
    programs.helix = {
      enable = true;
      package = extra.helix-flake.packages."${pkgs.system}".default;
      defaultEditor = true;
      settings = {
        theme = "monokai";
        editor = {
          mouse = false;
          line-number = "relative";
          continue-comments = false;
          idle-timeout = 300;
          completion-timeout = 5;
          completion-trigger-len = 1;
          end-of-line-diagnostics = "hint";
          soft-wrap = {
            enable = true;
          };
          inline-diagnostics = {
            cursor-line = "warning";
          };
          file-picker = {
            hidden = false;
          };
          inline-completion-timeout = 150;
        };
        keys = {
          insert = {
            C-o = "inline_completion_accept";
            C-e = "inline_completion_dismiss";
          };
          normal = {
            ${if self.use-yazi then "space" else null} = {
              "e" = [
                '':sh rm -f /tmp/unique-file''
                '':insert-output yazi "%{buffer_name}" --chooser-file=/tmp/unique-file''
                '':sh printf "\x1b[?1049h\x1b[?2004h" > /dev/tty''
                '':open %sh{cat /tmp/unique-file}''
                '':redraw''
              ];
            };
            # <C-a>: pass buffer files to aider
            ${if self.use-aider then "C-p" else null} = {
              "a" = ":sh ~/.config/helix/scripts/aider-add-files.sh %{all_buffer_paths}";
              "s" = ":sh ~/.config/helix/scripts/aider-send-selection.sh '%{selection}'";
              "c" = ":sh ~/.config/helix/scripts/aider-commit.sh";
              "v" = {
                "b" = ":sh ~/.config/helix/scripts/aider-begin-voice.sh";
                "c" = ":sh ~/.config/helix/scripts/aider-commit-voice.sh";
              };
            };
          };
        };
      };
      languages = {
        auto-format = true;
        language-server = with pkgs; {
          buf = {
            command = "${pkgs.buf}/bin/buf";
            args = [
              "lsp"
              "serve"
            ];
          };
          tailwindcss-language-server = {
            command = "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
            args = [ "--stdio" ];
          };
          eslint = {
            # NOTE: v4.10.0 is not working on helix.
            #command = "${pkgs.vscode-langservers-extracted}/bin/vscode-eslint-language-server";
            # NOTE: Assuing vscode-eslint-language-server@v4.8.0 is installed via npm
            command = "vscode-eslint-language-server";
            args = [ "--stdio" ];
            config = {
              validate = "on";
              experimental = {
                useFlatConfig = false;
              };
              rulesCustomizations = [ ];
              run = "onType";
              problems = {
                shortenToSingleLine = false;
              };
              nodePath = "";

              codeAction = {
                disableRuleComment = {
                  enable = true;
                  location = "separateLine";
                };
                showDocumentation = {
                  enable = true;
                };
              };

              codeActionOnSave = {
                enable = true;
                mode = "fixAll";
              };

              workingDirectory = {
                mode = "auto";
              };
            };
          };
          copilot-language-server = {
            command = "${pkgs.copilot-language-server}/bin/copilot-language-server";
            args = [ "--stdio" ];
            config = {
              editorInfo = {
                name = "Helix";
                version = "25.01";
              };
              editorPluginInfo = {
                name = "helix-copilot";
                version = "0.1.0";
              };
            };
          };
          eslint_d = {
            command = "${pkgs.eslint_d}/bin/eslint_d";
            args = [ "--stdin" ];
          };
          codebook = {
            command = "${pkgs.codebook}/bin/codebook-lsp";
            args = [ "serve" ];
          };
          emmet-language-server = {
            command = "${emmet-language-server}/bin/emmet-language-server";
            args = [ "--stdio" ];
          };
          golangci-lint-lsp = {
            command = "${golangci-lint-langserver}/bin/golangci-lint-langserver";
            config = {
              command = "${golangci-lint}/bin/golangci-lint run --output.json.path stdout --show-stats=false --issues-exit-code=1";
            };
          };
          sqls = {
            command = "${sqls}/bin/sqls";
            # args = ["-config $HOME/.config/sqls/config.yml"];
          };
          hcl = {
            command = "${terraform-ls}/bin/terraform-ls";
          };
          markdown-oxide = {
            command = "${pkgs.markdown-oxide}/bin/markdown-oxide";
          };
        };
        language = [
          {
            name = "cpp";
            auto-format = true;
            language-servers = [
              "ccls"
              "codebook"
              "copilot-language-server"
            ];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "python";
            auto-format = true;
            language-servers = [
              "pyright"
              "codebook"
              "copilot-language-server"
            ];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "go";
            auto-format = true;
            language-servers = [
              "gopls"
              "golangci-lint-lsp"
              "codebook"
              "copilot-language-server"
            ];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "typescript";
            auto-format = true;
            language-servers = [
              "typescript-language-server"
              "tailwindcss-language-server"
              "eslint"
              "codebook"
              "copilot-language-server"
            ];
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "tsx";
            auto-format = true;
            file-types = [ "tsx" ];
            language-servers = [
              "typescript-language-server"
              "emmet-language-server"
              "tailwindcss-language-server"
              "eslint"
              "codebook"
              "copilot-language-server"
            ];
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "elm";
            language-servers = [
              "elm-language-server"
              "codebook"
              "copilot-language-server"
            ];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "protobuf";
            language-servers = [
              "buf"
              "codebook"
              "copilot-language-server"
            ];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "sql";
            language-servers = [
              "sqls"
              "codebook"
              "copilot-language-server"
            ];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "hcl";
            language-servers = [
              "terraform-ls"
              "copilot-language-server"
            ];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "markdown";
            language-servers = [
              "markdown-oxide"
              "codebook"
              "copilot-language-server"
            ];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
        ];
      };
    };
    xdg.configFile = {
      "helix/ignore" = {
        enable = true;
        text = ''
          .cursor/
          .devin/
          .kiro/
        '';
      };
      "helix/scripts" = {
        source = ./scripts;
        enable = true;
      };
      "sqls/config.yml" = {
        enable = true;
        text = ''
          lowercaseKeywords: false
          connections:
            - alias: id_local
              driver: mysql
              proto: tcp
              user: root
              passwd: root
              host: 127.0.0.1
              port: 3306
              dbName: id_local
              params:
                autocommit: "true"
                tls: skip-verify
            - alias: release_local
              driver: mysql
              proto: tcp
              user: root
              passwd: root
              host: 127.0.0.1
              port: 3306
              dbName: release_local
              params:
                autocommit: "true"
                tls: skip-verify
        '';
      };
    };
  };
}
