{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" "zenpower" ];
  boot.blacklistedKernelModules = [ "k10temp" "nouveau" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.zenpower ];
  boot.kernelParams = [ "amd_pstate=active" ];

  environment.systemPackages = with pkgs; [
    powertop
  ];


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
    fanCurvesConfig.text = ''
      (
        profiles: (
            balanced: [
                (
                    fan: CPU,
                    pwm: (2, 20, 33, 45, 56, 81, 99, 135),
                    temp: (47, 62, 65, 68, 70, 72, 74, 76),
                    enabled: false,
                ),
                (
                    fan: GPU,
                    pwm: (2, 20, 33, 45, 56, 81, 99, 135),
                    temp: (47, 59, 62, 65, 67, 69, 71, 73),
                    enabled: false,
                ),
                (
                    fan: MID,
                    pwm: (2, 40, 40, 71, 89, 119, 173, 206),
                    temp: (47, 62, 65, 68, 70, 72, 74, 76),
                    enabled: false,
                ),
            ],
            performance: [
                (
                    fan: CPU,
                    pwm: (33, 45, 81, 99, 135, 147, 183, 219),
                    temp: (64, 66, 68, 70, 72, 74, 76, 78),
                    enabled: false,
                ),
                (
                    fan: GPU,
                    pwm: (33, 45, 81, 99, 135, 147, 183, 219),
                    temp: (57, 60, 63, 66, 68, 70, 72, 74),
                    enabled: false,
                ),
                (
                    fan: MID,
                    pwm: (40, 71, 119, 173, 206, 206, 255, 255),
                    temp: (64, 66, 68, 70, 72, 74, 76, 78),
                    enabled: false,
                ),
            ],
            quiet: [
                (
                    fan: CPU,
                    pwm: (2, 15, 20, 33, 45, 56, 81, 81),
                    temp: (43, 68, 70, 72, 74, 76, 78, 255),
                    enabled: false,
                ),
                (
                    fan: GPU,
                    pwm: (2, 15, 20, 33, 45, 56, 81, 81),
                    temp: (43, 67, 68, 70, 70, 70, 70, 255),
                    enabled: false,
                ),
                (
                    fan: MID,
                    pwm: (2, 2, 40, 40, 71, 89, 119, 119),
                    temp: (43, 68, 70, 72, 74, 76, 78, 255),
                    enabled: false,
                ),
            ],
            custom: [],
        ),
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
      amdgpuBusId = "PCI:101:0:0";
      nvidiaBusId = "PCI:100:0:0";
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  services.fwupd.enable = true;
  services.upower.enable = true;
}
