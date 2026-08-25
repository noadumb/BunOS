{
  pkgs,
  ...
}:
{
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      vhostUserPackages = [ pkgs.virtiofsd ];
    };
  };

  programs.virt-manager.enable = true;
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  users.users.noelle.extraGroups = [ "libvirtd" ];

}
