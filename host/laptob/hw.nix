{
  config,
  lib,
  pkgs,
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
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  hardware.graphics = {
    enable = true;
  };


  disko.devices = {
    disk = {
      nvme = {
        device = "/dev/disk/by-id/nvme-ADATA_LEGEND_710_2032291E52UY";
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
                name = "kibity";
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
                    "/awawa" = {
                      mountpoint = "/awawa";
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
  networking.useDHCP = lib.mkDefault true;
  environment.etc.adjtime.source = lib.mkForce "/silly/etc/adjtime";


  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
