{
  networking = {

    hostName = "inspiron";

    wireless = {
      enable = true;
      networks.Lipranu.pskRaw =
        "104b0802bfb3dd8db0cca89fac8775988a5625fc3b45bfbf4ebdfa0a4e589e7c";
    };

    interfaces = {
      enp1s0.useDHCP = true;
      wlp2s0.useDHCP = true;
    };

  };
}
