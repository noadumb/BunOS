{
  pkgs,
  config,
  osConfig,
  ...
}:
{
  imports = [
    ./hw
    ../../system
    ../../style
    ../../vim
    ./persistence
    ./services
  ];

  nixpkgs.config.allowUnfree = true;

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.kernelModules = [
    "i2c-dev"
  ];
  hardware.i2c.enable = true;

  services.blueman.enable = false; #TODO: fix

  boot.kernel.sysctl."kernel.sysrq" = 502;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    ntfs3g
    xfs
    xfsprogs
    asusctl
    brightnessctl
    pkgs.mesa-demos
    sbctl

    deskflow
  ];

  networking.firewall = {
    allowedTCPPorts = [ 24800 ];
    allowedUDPPorts = [ 24800 ];
  };

  bunos.net.ssh.enableJump = true;

#  programs.k3b.enable = true;
  # optical drive access for k3b
/*  services.udev.extraRules = ''
    KERNEL=="sr[0-9]*", GROUP="cdrom", MODE="0660"
  ''; */



/*  services.rkvm = {
    server = {
      enable = false;
      settings = {
        key = "/etc/rkvm/key.pem";
        certificate = "/etc/rkvm/certificate.pem";

        listen = "0.0.0.0:5258";
        password = "1234"; #TODO: change
        switch-keys = [
          "left-alt"
          "left-ctrl"
        ];
      };
    };
  }; */
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

  # Fixes clock offset with dualboot with windows
  time.hardwareClockInLocalTime = true;

  bunos.boot = {
    mode = "uefi";
    secureboot.enable = false;
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

/*  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server"; #(?)
    authKeyFile = config.age.secrets.tailscale.path;
  };
  networking.nftables.enable = true;
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ]; */

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  #TODO: hibernation?

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

/*  age.identityPaths = [
    "/silly/etc/ssh/ssh_host_ed25519_key"
  ];
  age.secrets.root = {
    file = ./secrett/root.age;
    mode = "400";
    owner = "root";
    group = "root";
  };
  age.secrets.noelle = {
    file = ./secrett/noelle.age;
    mode = "400";
    owner = "root";
    group = "root";
  };
  age.secrets.sync = {
    file = ./secrett/sync.age;
    mode = "400";
    owner = "noelle";
    group = "root";
  };
  age.secrets.synck = {
    file = ./secrett/synck.age;
    mode = "400";
    owner = "noelle";
    group = "root";
  };
  age.secrets.irc = {
    file = ./secrett/irc.age;
    mode = "400";
    owner = "noelle";
    group = "root";
  };
  age.secrets.tailscale = {
    file = ./secrett/tailscale.age;
    mode = "400";
    owner = "noelle";
    group = "root";
  }; */

  users = {
    mutableUsers = false;
    users = {
      root = {
#        hashedPasswordFile = config.age.secrets.root.path;
        password = "abcd";
      };
      noelle = {
#        hashedPasswordFile = config.age.secrets.noelle.path;
        password = "abcd"; #TODO: CHANGE ASAP
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
          "cdrom"
        ];
      };
    };
  };

}
