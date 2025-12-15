{ lib, config, pkgs, extra, ... }:

with builtins;
with lib;
let self = config.modules.editor.helix;
in {
  imports = [];
  options.modules.editor.helix = {
    enable = mkEnableOption "helix";
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
        };
      };
      languages = {
        auto-format = true;
        language-server = with pkgs; {
          buf = {
            command = "${pkgs.buf}/bin/buf";
            args = ["beta" "lsp"];
          };
          tailwindcss-language-server = {
            command = "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
            args = ["--stdio"];
          };
          eslint = {
            # NOTE: v4.10.0 is not working on helix.
            #command = "${pkgs.vscode-langservers-extracted}/bin/vscode-eslint-language-server";
            # NOTE: Assuing vscode-eslint-language-server@v4.8.0 is installed via npm
            command = "vscode-eslint-language-server";
            args = ["--stdio"];
            config = {
               validate = "on";
               experimental = {
                 useFlatConfig = false;
               };
               rulesCustomizations = [];
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
            args = ["--stdio"];
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
            args = ["--stdin"];
          };
          codebook = {
            command = "${extra.codebook}/bin/codebook-lsp";
            args = ["serve"];
          };
          emmet-language-server = {
            command = "${emmet-language-server}/bin/emmet-language-server";
            args =  ["--stdio"];
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
          tabby = {
            command = "${pkgs.tabby-agent}/bin/tabby-agent";
            args = ["--lsp" "--stdio"];
          };
          markdown-oxide = {
            command = "${pkgs.markdown-oxide}/bin/markdown-oxide";
          };
          lsp-ai = {
            command = "${lsp-ai}/bin/lsp-ai";
            timeout = 60;
            config = {
              memory = {
                file_store = {};
              };
              models = {
                gemini = {
                  type = "gemini";
                  completions_endpoint = "https://generativelanguage.googleapis.com/v1beta/models/";
                  chat_endpoint = "https://generativelanguage.googleapis.com/v1beta/models/";
                  model = "gemini-2.5-pro";
                  auth_token_env_var_name = "GEMINI_API_KEY";
                };
                mistral = {
                  type = "mistral_fim";
                  fim_endpoint = "https://api.mistral.ai/v1/fim/completions";
                  model = "codestral-latest";
                  auth_token_env_var_name = "MISTRAL_API_KEY";
                };
                openai = {
                  type = "open_ai";
                  chat_endpoint = "https://api.openai.com/v1/chat/completions";
                  model =  "gpt-3.5-turbo";
                  auth_token_env_var_name = "OPENAI_API_KEY";
                };
                copilot = {
                  type = "open_ai";
                  chat_endpoint = "https://api.githubcopilot.com/chat/completions";
                  model =  "";
                  auth_token_env_var_name = "COPILOT_API_KEY";
                };
                groq = {
                  type = "open_ai";
                  chat_endpoint = "https://api.groq.com/openai/v1/chat/completions";
                  model =  "llama-3.2-3b-preview";
                  auth_token_env_var_name = "GROQ_API_KEY";
                };
                qwen3 = {
                  type = "ollama";
                  model =  "SimonPu/Qwen3-Coder:30B-Instruct_Q4_K_XL";
                  chat_endpoint = "http://192.168.1.9:11434/api/chat";
                };
              };
              chat= [
                {
                  trigger = "!C";
                  action_display_name = "Chat";
                  model = "gemini";
                  parameters = {
                    max_context = 4096;
                    max_tokens = 1024;
                    system = "You are a code assistant chatbot. The user will ask you for assistance coding and you will do your best to answer succinctly and accurately";
                  };
                }
                {
                  trigger = "!CC";
                  action_display_name = "Chat with context";
                  model = "gemini";
                  parameters = {
                    max_context = 4096;
                    max_tokens = 1024;
                    system = "You are a code assistant chatbot. The user will ask you for assistance coding and you will do your best to answer succinctly and accurately given the code context:\n\n{CONTEXT}";
                  };
                }
              ];
              actions = [
    #             {
    #               action_display_name = "lsp-ai:complete";
    #               model = "gemini";
    #               parameters = {
    #                 max_context = 4096;
    #                 max_tokens = 4096;
    #                 contents = [{
    #                   role = "user";
    #                   parts = [{
    #                     text = "{CONTEXT} and {CODE}";
    #                   }];
    #                 }];
    #                 systemInstruction = {
    #                   role = "system";
    #                   parts = [{
    #                       text = ''
    # You are an AI coding assistant. Your task is to complete code snippets. The user's cursor position is marked by \"<CURSOR>\".
    # Follow these steps:

    # 1. Analyze the code context and the cursor position.
    # 2. Provide your chain of thought reasoning, wrapped in <reasoning> tags.
    #  Include thoughts about the cursor position, what needs to be completed, and any necessary formatting.
    # 3. Determine the appropriate code to complete the current thought, including finishing partial words or lines.
    # 4. Replace \"<CURSOR>\" with the necessary code, ensuring proper formatting and line breaks.
    # 5. Wrap your code solution in <answer> tags.

    # Your response should always include both the reasoning and the answer.
    # Pay special attention to completing partial words or lines before adding new lines of code.

    # <examples>
    # <example>
    # User input:
    # --main.py--
    # # A function that reads in user inpu<CURSOR>

    # Response:
    # <reasoning>
    # 1. The cursor is positioned after \"inpu\" in a comment describing a function that reads user input.
    # 2. We need to complete the word \"input\" in the comment first.
    # 3. After completing the comment, we should add a new line before defining the function.
    # 4. The function should use Python's built-in `input()` function to read user input.
    # 5. We'll name the function descriptively and include a return statement.
    # </reasoning>

    # <answer>
    # def read_user_input():
    #   user_input = input(\"Enter your input: \")
    #   return user_input
    # </answer>
    # </example>

    # <example>
    # User input:
    # --main.py--
    # def fibonacci(n):
    #   if n <= 1:
    #       return n
    #   else:
    #       re<CURSOR>


    # Response:
    # <reasoning>
    # 1. The cursor is positioned after \"re\" in the 'else' clause of a recursive Fibonacci function.
    # 2. We need to complete the return statement for the recursive case.
    # 3. The \"re\" already present likely stands for \"return\", so we'll continue from there.
    # 4. The Fibonacci sequence is the sum of the two preceding numbers.
    # 5. We should return the sum of fibonacci(n-1) and fibonacci(n-2).
    # </reasoning>

    # <answer>turn fibonacci(n-1) + fibonacci(n-2)</answer>
    # </example>
    # </examples>'';
    #                   }];
    #                 };
    #               };
    #               post_process = {
    #                 extractor = "(?s)```\w+(.*?)```";
    #                 replace = [["\\\\n" "\n"]];
    #               };
    #             }
                
                {
                  action_display_name = "lsp-ai:complete";
                  model = "qwen3";
                  parameters = {
                    max_context = 8192;
                    max_tokens = 8192;
                    messages = [
                    {
                      role = "system";
                      content = ''
You are an AI coding assistant. Your task is to complete code snippets. The user's cursor position is marked by \"<CURSOR>\".
Follow these steps:

1. Analyze the code context and the cursor position.
2. Provide your chain of thought reasoning, wrapped in <reasoning> tags.
   Include thoughts about the cursor position, what needs to be completed, and any necessary formatting.
3. Determine the appropriate code to complete the current thought, including finishing partial words or lines.
4. Replace \"<CURSOR>\" with the necessary code, ensuring proper formatting and line breaks.
5. Wrap your code solution in <answer> tags.

Your response should always include both the reasoning and the answer.
Pay special attention to completing partial words or lines before adding new lines of code.

<examples>
<example>
User input:
--main.py--
# A function that reads in user inpu<CURSOR>

Response:
<reasoning>
1. The cursor is positioned after \"inpu\" in a comment describing a function that reads user input.
2. We need to complete the word \"input\" in the comment first.
3. After completing the comment, we should add a new line before defining the function.
4. The function should use Python's built-in `input()` function to read user input.
5. We'll name the function descriptively and include a return statement.
</reasoning>

<answer>
def read_user_input():
    user_input = input(\"Enter your input: \")
    return user_input
</answer>
</example>

<example>
User input:
--main.py--
def fibonacci(n):
    if n <= 1:
        return n
    else:
        re<CURSOR>


Response:
<reasoning>
1. The cursor is positioned after \"re\" in the 'else' clause of a recursive Fibonacci function.
2. We need to complete the return statement for the recursive case.
3. The \"re\" already present likely stands for \"return\", so we'll continue from there.
4. The Fibonacci sequence is the sum of the two preceding numbers.
5. We should return the sum of fibonacci(n-1) and fibonacci(n-2).
</reasoning>

<answer>turn fibonacci(n-1) + fibonacci(n-2)</answer>
</example>
</examples>'';
                    }
                      {
                        role =  "user";
                        content = "{CODE}";
                      }
                    ];
                  };
                  post_process = {
                    extractor = "(?s)<answer>(.*?)</answer>";
                  };
                }
              ];
              completion = {
                model = "qwen3";
                parameters = {
                  max_context = 8192;
                  max_tokens = 8192;
                  messages = [
                      {
                        role = "system";
                        content = ''
                          Instructions:
                          - You are an AI programming assistant.
                          - Given a piece of code with the cursor location marked by "<CURSOR>", replace "<CURSOR>" with the correct code or comment.
                          - First, think step-by-step.
                          - Describe your plan for what to build in pseudocode, written out in great detail.
                          - Then output the code replacing the "<CURSOR>"
                          - Ensure that your completion fits within the language context of the provided code snippet (e.g., Python, JavaScript, Rust).

                          Rules:
                          - Only respond with code or comments.
                          - Only replace "<CURSOR>"; do not include any previously written code.
                          - Never include "<CURSOR>" in your response
                          - If the cursor is within a comment, complete the comment meaningfully.
                          - Handle ambiguous cases by providing the most contextually appropriate completion.
                          - Be consistent with your responses.
                        '';
                      }
                      {
                        role = "user";
                        content = ''
                          def greet(name):
                              print(f"Hello, {<CURSOR>}")
                        '';
                      }

                      {
                        role = "assistant";
                        content = "name";
                      }

                      {
                        role = "user";
                        content = ''
                          function sum(a, b) {
                              return a + <CURSOR>;
                          }
                        '';
                      }

                      {
                        role = "assistant";
                        content = "b";
                      }

                      {
                        role = "user";
                        content = ''
                          fn multiply(a: i32, b: i32) -> i32 {
                              a * <CURSOR>
                          }
                        '';
                      }

                      {
                        role = "assistant";
                        content = "b";
                      }

                      {
                        role = "user";
                        content = ''
                          # <CURSOR>
                          def add(a, b):
                              return a + b
                        '';
                      }

                      {
                        role = "assistant";
                        content = "Adds two numbers";
                      }

                      {
                        role = "user";
                        content = ''
                          # This function checks if a number is even
                          <CURSOR>
                        '';
                      }

                      {
                        role = "assistant";
                        content = ''
                          def is_even(n):
                              return n % 2 == 0
                        '';
                      }

                      {
                        role = "user";
                        content = "{CODE}";
                      }
                    ];
                };
              };
            };
            # chat= [
            #   {
            #     trigger = "!C";
            #     action_display_name = "Chat";
            #     model = "gemini";
            #     parameters = {
            #       max_context = 4096;
            #       max_tokens = 1024;
            #       system = "You are a code assistant chatbot. The user will ask you for assistance coding and you will do your best to answer succinctly and accurately";
            #     };
            #   }
            #   {
            #     trigger = "!CC";
            #     action_display_name = "Chat with context";
            #     model = "gemini";
            #     parameters = {
            #       max_context = 4096;
            #       max_tokens = 1024;
            #       system = "You are a code assistant chatbot. The user will ask you for assistance coding and you will do your best to answer succinctly and accurately given the code context:\n\n{CONTEXT}";
            #     };
            #   }
            # ];
            # actions = [
            #   {
            #     action_display_name = "lsp-ai:complete";
            #     model = "gemini";
            #     parameters = {
            #       max_context = 4096;
            #       max_tokens = 4096;
            #       contents = [{
            #         role = "user";
            #         parts = [{
            #           text = "{CONTEXT} and {CODE}";
            #         }];
            #         systemInstruction = [{
            #           role = "system";
            #           parts = [{
            #             text = "You are an AI coding assistant. Your task is to complete code snippets. The user's cursor position is marked by \"<CURSOR>\". Follow these steps:\n\n1. Analyze the code context and the cursor position.\n2. Provide your chain of thought reasoning, wrapped in <reasoning> tags. Include thoughts about the cursor position, what needs to be completed, and any necessary formatting.\n3. Determine the appropriate code to complete the current thought, including finishing partial words or lines.\n4. Replace \"<CURSOR>\" with the necessary code, ensuring proper formatting and line breaks.\n5. Wrap your code solution in <answer> tags.\n\nYour response should always include both the reasoning and the answer. Pay special attention to completing partial words or lines before adding new lines of code.\n\n<examples>\n<example>\nUser input:\n--main.py--\n# A function that reads in user inpu<CURSOR>\n\nResponse:\n<reasoning>\n1. The cursor is positioned after \"inpu\" in a comment describing a function that reads user input.\n2. We need to complete the word \"input\" in the comment first.\n3. After completing the comment, we should add a new line before defining the function.\n4. The function should use Python's built-in `input()` function to read user input.\n5. We'll name the function descriptively and include a return statement.\n</reasoning>\n\n<answer>t\ndef read_user_input():\n    user_input = input(\"Enter your input: \")\n    return user_input\n</answer>\n</example>\n\n<example>\nUser input:\n--main.py--\ndef fibonacci(n):\n    if n <= 1:\n        return n\n    else:\n        re<CURSOR>\n\n\nResponse:\n<reasoning>\n1. The cursor is positioned after \"re\" in the 'else' clause of a recursive Fibonacci function.\n2. We need to complete the return statement for the recursive case.\n3. The \"re\" already present likely stands for \"return\", so we'll continue from there.\n4. The Fibonacci sequence is the sum of the two preceding numbers.\n5. We should return the sum of fibonacci(n-1) and fibonacci(n-2).\n</reasoning>\n\n<answer>turn fibonacci(n-1) + fibonacci(n-2)</answer>\n</example>\n</examples>";
            #           }];
            #         }];
            #       }];
            #     };
            #     post_process = {
            #       extractor = "(?s)<answer>(.*?)</answer>";
            #     };
            #   }
            #   {
            #     action_display_name = "lsp-ai:refactor";
            #     model = "gemini";
            #     parameters = {
            #       max_context = 4096;
            #       max_tokens = 4096;
            #       system = "You are an AI coding assistant specializing in code refactoring. Your task is to analyze the given code snippet and provide a refactored version. Follow these steps:\n\n1. Analyze the code context and structure.\n2. Identify areas for improvement, such as code efficiency, readability, or adherence to best practices.\n3. Provide your chain of thought reasoning, wrapped in <reasoning> tags. Include your analysis of the current code and explain your refactoring decisions.\n4. Rewrite the entire code snippet with your refactoring applied.\n5. Wrap your refactored code solution in <answer> tags.\n\nYour response should always include both the reasoning and the refactored code.\n\n<examples>\n<example>\nUser input:\ndef calculate_total(items):\n    total = 0\n    for item in items:\n        total = total + item['price'] * item['quantity']\n    return total\n\n\nResponse:\n<reasoning>\n1. The function calculates the total cost of items based on price and quantity.\n2. We can improve readability and efficiency by:\n   a. Using a more descriptive variable name for the total.\n   b. Utilizing the sum() function with a generator expression.\n   c. Using augmented assignment (+=) if we keep the for loop.\n3. We'll implement the sum() function approach for conciseness.\n4. We'll add a type hint for better code documentation.\n</reasoning>\n<answer>\nfrom typing import List, Dict\n\ndef calculate_total(items: List[Dict[str, float]]) -> float:\n    return sum(item['price'] * item['quantity'] for item in items)\n</answer>\n</example>\n\n<example>\nUser input:\ndef is_prime(n):\n    if n < 2:\n        return False\n    for i in range(2, n):\n        if n % i == 0:\n            return False\n    return True\n\n\nResponse:\n<reasoning>\n1. This function checks if a number is prime, but it's not efficient for large numbers.\n2. We can improve it by:\n   a. Adding an early return for 2, the only even prime number.\n   b. Checking only odd numbers up to the square root of n.\n   c. Using a more efficient range (start at 3, step by 2).\n3. We'll also add a type hint for better documentation.\n4. The refactored version will be more efficient for larger numbers.\n</reasoning>\n<answer>\nimport math\n\ndef is_prime(n: int) -> bool:\n    if n < 2:\n        return False\n    if n == 2:\n        return True\n    if n % 2 == 0:\n        return False\n    \n    for i in range(3, int(math.sqrt(n)) + 1, 2):\n        if n % i == 0:\n            return False\n    return True\n</answer>\n</example>\n</examples>";
            #       messages = [
            #         {
            #           role =  "user";
            #           content = "{SELECTED_TEXT}";
            #         }
            #       ];
            #     };
            #     post_process = {
            #       extractor = "(?s)<answer>(.*?)</answer>";
            #     };
            #   }
            # ];
            # completion = {
            #   model = "mistral";
            #   parameters = [{
            #     max_tokens = 64;
            #     max_context = 1024;
            #   }];
            # };
          };
        };
        language = [
          {
            name = "cpp";
            auto-format = true;
            language-servers = ["ccls" "lsp-ai" "codebook" "copilot-language-server"];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "python";
            auto-format = true;
            language-servers = ["pyright" "lsp-ai" "codebook" "copilot-language-server"];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "go";
            auto-format = true;
            language-servers = ["gopls" "golangci-lint-lsp" "lsp-ai" "codebook" "tabby" "copilot-language-server"];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "typescript";
            auto-format = true;
            language-servers = ["typescript-language-server" "lsp-ai" "tailwindcss-language-server" "eslint" "codebook" "tabby" "copilot-language-server"];
            formatter = {
              command = "prettier";
              args = [ "--parser" "typescript"];
            };
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "tsx";
            auto-format = true;
            file-types = ["tsx"];
            language-servers = ["typescript-language-server" "lsp-ai" "emmet-language-server" "tailwindcss-language-server" "eslint" "codebook" "tabby" "copilot-language-server"];
            formatter = {
              command = "prettier";
              args = [ "--parser" "typescript"];
            };
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "elm";
            language-servers = ["elm-language-server" "lsp-ai" "codebook" "copilot-language-server"];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "protobuf";
            language-servers = ["buf" "lsp-ai" "codebook" "copilot-language-server"];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "sql";
            language-servers = ["sqls" "lsp-ai" "codebook" "copilot-language-server"];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "hcl";
            language-servers = ["terraform-ls" "copilot-language-server"];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
          {
            name = "markdown";
            language-servers = ["markdown-oxide" "lsp-ai" "codebook" "copilot-language-server"];
            indent = {
              tab-width = 2;
              unit = " ";
            };
          }
        ];
      };
    };
    home.packages = with pkgs; [
      lsp-ai
      tabby
    ];
    xdg.configFile = {
      "helix/ignore" = {
        enable = true;
        text = ''
.cursor/
.devin/
.kiro/
'';
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
