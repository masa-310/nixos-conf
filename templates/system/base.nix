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
      printer = {
        enable = true;
      };
      greetd = {
        enable = true;
      };
      mail = {
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
