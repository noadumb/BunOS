{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hw.nix
    ../../system
    ../../style
    ../../vim
  ];

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

#  hardware.bluetooth.enable = true;
#  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  services.asusd.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;

  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
      Experimental = true;
      FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

#  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts); //move somewhere with lib defined



  hardware.nvidia.prime = {
    amdgpuBusId = "PCI:101:0:0";
    nvidiaBusId = "PCI:100:0:0";

    sync.enable = true;
  };

  bunos.boot = {
    mode = "uefi";
  };

  bunos.desktop = {
    display = {
      wayland.enable = true;
      manager.plasma.enable = true;
    };

#    input.fcitx.enable = true;
    gaming.enable = true;
    fonts.useDefault = true;
  };

  users = {
    mutableUsers = true; #TEMPORARY
    users = {
      root = {

      };
      noa = {

        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "i2c"
          "video"
          "adbusers"
        ];
      };
    };
  };

}
