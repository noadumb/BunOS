{
  config,
  lib,
  modulesPath,
  ...
}:
{

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  services.fstrim.enable = true;


  disko.devices = {
    disk = {
      nvme = {
        device = "/dev/disk/by-id/nvme-CT4000P3PSSD8_2334E86EFD15";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "2G";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "buni";
                settings = {
                  #aaaa
                  allowDiscards = true;
                };
                extraFormatArgs = [
                  "--iter-time 2137"
                ];
                content = {
                  type = "btrfs";
                  extraArgs = [
                    "-L"
                    "bunie"
                  ];
                  subvolumes = {
                    "/bunos-nix" = { mountpoint = "/nix"; mountOptions = [ "subvol=bunos-nix" "compress=zstd" "noatime" ]; };
                    "/bunos-silly" = { mountpoint = "/silly"; mountOptions = [ "subvol=bunos-silly" "compress=zstd" "relatime" ]; };
                    "/bunos-home" = { mountpoint = "/home"; mountOptions = [ "subvol=bunos-home" "compress=zstd" "relatime" ]; };
                    "/bunos-log" = { mountpoint = "/var/log"; mountOptions = [ "subvol=bunos-log" "compress=zstd" "noatime" ]; };
                    "/awawa" = { mountpoint = "/awawa"; swap.swapfile.size = "48G"; };
                    "/shared" = { mountpoint = "/shared"; mountOptions = [ "subvol=shared" "compress=zstd" "noatime" ]; };
                  };
                };
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "mode=755"
          "uid=0"
          "gid=0"
        ];
      };
    };
  };

  fileSystems."/silly".neededForBoot = true;
  fileSystems."/home/noelle/shared" = {
    device = "/shared";
    fsType = "none";
    options = [ "bind" "nofail" ];
    depends = [ "/shared" "/home" ];
  };
  environment.etc.adjtime.source = lib.mkForce "/silly/etc/adjtime";
}
