{pkgs, ...}: {
  wrappers.xdragon = {
    basePackage = pkgs.xdragon;
    flags = ["--and-exit" "--all"];
  };
}
