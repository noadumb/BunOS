{
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
}
