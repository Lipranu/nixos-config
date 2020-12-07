{ pkgs, ... }: {
  nix = {

    package = pkgs.nixUnstable;
    extraOptions = "experimental-features = nix-command flakes";

    trustedUsers = [ "root" "lipranu" ];

    binaryCaches = [
      "https://cache.nixos.org/"
      "https://nixcache.reflex-frp.org"
    ];

    binaryCachePublicKeys = [
      "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
    ];

  };
}
