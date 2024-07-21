{ pkgs, ... }: {
  nix = {

    extraOptions = "experimental-features = nix-command flakes";

    settings = {
      trusted-users = [ "root" "lipranu" ];

      substituters = [
        "https://cache.nixos.org/"
        "https://nixcache.reflex-frp.org"
        "https://cache.iog.io"
      ];

      trusted-public-keys = [
        "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
    };
  };
}
