{ allowBroken = true;
  allowUnfree = true;
  android_sdk.accept_license = true;
  packageOverrides = pkgs: rec {
    canvascli = import ./canvas {pkgs=pkgs;};
    haskellPackages = pkgs.haskellPackages.override {
      overrides = haskellPackagesNew: haskellPackagesOld: rec {
      };
    };
  };
}
