{
  modulesPath,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ../../system
    ../../style
    ../../vim
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  boot.supportedFilesystems = [
    "btrfs"
    "zfs"
    "reiserfs"
    "vfat"
    "f2fs"
    "xfs"
    "ntfs"
    "cifs"
  ];

  environment.systemPackages = with pkgs; [
    nixos-generators
    nixos-anywhere
    nixos-install-tools
  ];

  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  users.users.root.openssh.authorizedKeys.keys = (import ../ssh.nix { inherit pkgs; }).getAllKeys;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  bunos.desktop = {
    display = {
      wayland.enable = true;
      manager.plasma.enable = true;
    };

    fonts.useDefault = true;
  };

  networking.wireless.enable = true;
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  bunos.boot = {
    mode = "legacy";
    secureboot.enable = false;
  };

  isoImage = {
    isoBaseName = lib.mkForce "bunos-image-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}";
  };
}
