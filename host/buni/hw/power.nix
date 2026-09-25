{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  services.power-profiles-daemon.enable = true;
  services.tlp.enable = false;

  services.asusd = {
    enable = true;


    asusdConfig.text = ''
      (
        charge_control_end_threshold: 80,
        base_charge_control_end_threshold: 0,
        disable_nvidia_powerd_on_battery: true,
        ac_command: "",
        bat_command: "",
        platform_profile_linked_epp: false,
        platform_profile_on_battery: Quiet,
        change_platform_profile_on_battery: false,
        platform_profile_on_ac: Performance,
        change_platform_profile_on_ac: false,
        profile_quiet_epp: Power,
        profile_balanced_epp: BalancePower,
        profile_custom_epp: Performance,
        profile_performance_epp: Performance,
        ac_profile_tunings: {
            Quiet: (
                enabled: false,
                group: {},
            ),
            Performance: (
                enabled: false,
                group: {},
            ),
        },
        dc_profile_tunings: {},
        armoury_settings: {},
      )
    '';

  };
  environment.etc."asusd/.keep".text = "";

  services.cardwired.enable = true;

  hardware.nvidia = {
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    modesetting.enable = true;
    nvidiaSettings = false;
    dynamicBoost.enable = true;
    powerManagement = {
      enable = true;
      finegrained = true;
    };
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      amdgpuBusId = "PCI:101@0:0:0";
      nvidiaBusId = "PCI:100@0:0:0";
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  services.fwupd.enable = true;
  services.upower.enable = true;
}
