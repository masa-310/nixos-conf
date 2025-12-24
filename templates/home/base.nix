{ ... }:

{
  modules = {
    program = {
      nodejs = {
        enable = true;
        version = 22;
      };
      starship = {
        enable = true;
        shell = "zsh";
      };
      rofi = {
        enable = true;
      };
      polybar = {
        enable = true;
      };
      elm = {
        enable = true;
      };
      go = {
        enable = true;
      };
      rust = {
        enable = true;
      };
      c = {
        enable = true;
        # build clang failed for some reason
        # use-clang = true;
      };
      sql = {
        enable = true;
      };
    };
    windowManager.xmonad = {
      enable = true;
    };
    editor.neovim = {
      enable = true;
    };
    terminal.wezterm = {
      enable = true;
    };
    shell.zsh = {
      enable = true;
    };
    tool = {
      newsboat = {
        enable = true;
      };
    };
    tool.unixporn = {
      enable = true;
    };
    tool.codebook = {
      enable = true;
    };
    tool.coderabbit = {
      enable = true;
    };
    tool.broot = {
      enable = true;
    };
    ai.opencode.enable = true;
    #program.texlive = {
    #  enable = true;
    #  scheme = "japanese";
    #};
    # program.haskell = {
    #   enable = true;
    # };
  };
}
