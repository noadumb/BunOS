{
  config,
  lib,
  ...
}:

{
  options = with lib; {
    bunos.boot = {
      mode = mkOption {
        type = types.strMatching "^(uefi|legacy)$";
        default = "uefi";
        description = "option describing the boot mode (UEFI or legacy).";
      };
      bootloader = mkOption {
        type = types.strMatching "^(grub|systemd-boot|limine)$";
        default = "systemd-boot";
        description = "option describing the bootloader to use (GRUB, systemd-boot, limine).";
      };
      efi = {
        mount = mkOption {
          type = types.str;
          default = "/boot";
          description = "the EFI mount point.";
        };
      };
      legacy = {
        devices = mkOption {
          type = types.listOf types.str;
          default = [ ];
          description = "list of devices to install GRUB to in legacy mode";
        };
      };
      secureboot = {
        enable = mkEnableOption "secure-boot";
      };
    };
  };
  config = {
    boot = {
      loader = lib.mkMerge [
        {

          systemd-boot.enable = ((config.bunos.boot.bootloader == "systemd-boot") && (config.bunos.boot.mode == "uefi") && (config.bunos.boot.secureboot.enable == false));
          systemd-boot.editor = false;
          grub.enable = false;
          efi = lib.mkIf (config.bunos.boot.mode == "uefi") {
            canTouchEfiVariables = true;
            efiSysMountPoint = lib.mkDefault config.bunos.boot.efi.mount;
          };

        }
        (lib.mkIf ((config.bunos.boot.bootloader == "limine") && (config.bunos.boot.mode == "uefi")) {
          limine = {
            enable = true;
            secureBoot.enable = lib.mkDefault config.bunos.boot.secureboot.enable;
            maxGenerations = lib.mkDefault 10;
          };
        })
        (lib.mkIf ((config.bunos.boot.bootloader == "grub") && (config.bunos.boot.mode == "uefi")) {
          grub = {
            enable = true;
            version = 2;
            efiSupport = true;
            useOSProber = true;
            enableCryptodisk = lib.mkDefault true;
            backgroundColor = "#d164ec";
            devices = lib.mkDefault [ ];
          };
        })
        (lib.mkIf (config.bunos.boot.mode != "uefi") {
          grub = {
            enable = true;
            efiSupport = false;
            enableCryptodisk = lib.mkDefault false;
            backgroundColor = "#198342";
            devices = lib.mkDefault config.bunos.boot.legacy.devices;
          };
        })
      ];

      lanzaboote = lib.mkIf ((config.bunos.boot.bootloader == "systemd-boot") && (config.bunos.boot.secureboot.enable) && (config.bunos.boot.mode == "uefi")) {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
        configurationLimit = 10;
        autoGenerateKeys.enable = true;
        autoEnrollKeys = {
          enable = true;
          includeFirmwareBuiltinKeys = true;
          autoReboot = false;
        };
      };
    };
    bunos.boot.secureboot.enable = lib.mkDefault false;
  };
}
