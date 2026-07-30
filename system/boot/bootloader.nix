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
    };
  };
  config = {
    boot = {
      loader = lib.mkMerge [
        {
          systemd-boot.enable = (config.bunos.boot.mode == "uefi");
          systemd-boot.editor = false;
          grub.enable = false;
          efi = lib.mkIf (config.bunos.boot.mode == "uefi") {
            canTouchEfiVariables = true;
            efiSysMountPoint = lib.mkDefault config.bunos.boot.efi.mount;
          };
        }
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
    };
  };
}
