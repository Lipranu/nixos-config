{
  networking = {

    hostName = "inspiron";

    wireless = {
      enable = true;
      interfaces = [ "enp1s0" "wlp2s0" ];
      networks = {
        Lipranu.pskRaw = "104b0802bfb3dd8db0cca89fac8775988a5625fc3b45bfbf4ebdfa0a4e589e7c";
        Focus.pskRaw = "7fed4b95db04399f3d83e2fb79161cff379f7d7f154114e614fec744617f5125";
      };
    };

    interfaces = {
      enp1s0.useDHCP = true;
      wlp2s0.useDHCP = true;
    };

  };
}
