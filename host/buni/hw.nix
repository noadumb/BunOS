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

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

/*  fileSystems."/" = { #TODO:remove these and replace with disko
    device = "/dev/disk/by-uuid/e626a254-bb8e-45ca-a55c-df2c77a5ddc1";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/56A7-3E48";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  }; */

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
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "subvol=nix"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/silly" = {
                      mountpoint = "/silly";
                      mountOptions = [
                        "subvol=silly"
                        "compress=zstd"
                        "relatime"
                      ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "subvol=home"
                        "compress=zstd"
                        "relatime"
                      ];
                    };
                    "/log" = {
                      mountpoint = "/var/log";
                      mountOptions = [
                        "subvol=log"
                        "compress=zstd"
                        "noatime"
                      ];
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "48G";
                    };
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

#  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
