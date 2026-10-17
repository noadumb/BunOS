{
  config,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  boot.kernelParams = [ "i915.enable_rc6=7" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "usbhid" "uas" "sd_mod" "sr_mod" "sdhci_pci" ];
  hardware.intelgpu.vaapiDriver = "intel-vaapi-driver";
}
