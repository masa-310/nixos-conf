{ ... }:

{
  modules = {
    service = {
      docker = {
        enable = true;
      };
      picom = {
        enable = true;
      };
      greetd = {
        enable = true;
      };
      mail = {
        enable = true;
      };
      _1password = {
        enable = true;
      };
    };
    display = {
      x = {
        enable =true;
      };
    };
    user = {
      masashi = {
        enable = true;
      };
    };
  };
}
