{
  hostname,
  config,
  lib,
  ...
}:
{
  networking.hostName = "${hostname}";
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;
  
}
