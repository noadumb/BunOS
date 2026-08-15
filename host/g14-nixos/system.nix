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

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.kernelModules = [
    "12c-dev"
    "ddcci_backlight"
  ];

  environment.systemPackages = [
    pkgs.ddcutil
    pkgs.lact
  ];
  services.udev.packages = [ pkgs.ddcutil ];
  hardware.i2c.enable = true;


  services.blueman.enable = true;

  boot.kernel.sysctl."kernel.sysrq" = 502;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    extraPackages = with pkgs; [
      libva-vdpau-driver
      rocmPackages.clr.icd
    ];
  };

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  bunos.net.ssh.enableJump = true;

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
      manager = {
        plasma.enable = true;
      };
    };

#    input.fcitx.enable = true;
    gaming.enable = true;
    fonts.useDefault = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  age.identityPaths = [
    "/etc/ssh/ssh_host_ed25519_key" #TODO: change after implementing impermanence
  ];
  age.secrets.root = {
    file = ./secrett/root.age;
    mode = "400";
    owner = "root";
    group = "root";
  };
  age.secrets.noa = {
    file = ./secrett/noa.age;
    mode = "400";
    owner = "root";
    group = "root";
  };
  age.secrets.sync = {
    file = ./secrett/sync.age;
    mode = "400";
    owner = "noa";
    group = "root";
  };
  age.secrets.synck = {
    file = ./secrett/synck.age;
    mode = "400";
    owner = "noa";
    group = "root";
  };
  age.secrets.irc = {
    file = ./secrett/irc.age;
    mode = "400";
    owner = "noa";
    group = "root";
  };


  users = {
    mutableUsers = true; #TEMPORARY
    users = {
      root = {
#        hashedPasswordFile = config.age.secrets.root.path; TESTING: ENABLE IN A BIT
      };
      noa = {
        hashedPasswordFile = config.age.secrets.noa.path;
        isNormalUser = true;
        openssh = {
          authorizedKeys.keys = (import ../ssh.nix { inherit pkgs; }).getAllKeys;
        };
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
