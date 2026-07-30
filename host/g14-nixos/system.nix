{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hw.nix
    ../../system
  ];

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

}
