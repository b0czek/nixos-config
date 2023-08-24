{ pkgs, ... }:
let 
  automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
in 

{
  environment.systemPackages = [ pkgs.cifs-utils pkgs.nfs-utils ];
  services.rpcbind.enable = true;

  fileSystems."/mnt/dmajnert" = {
  	device = "192.168.1.62:/mnt/user/dmajnert";
  	fsType = "nfs";
  	options = [automount_opts];
  };
  fileSystems."/mnt/publicshares" = {
  	device = "192.168.1.62:/mnt/user/publicshares";
  	fsType = "nfs";
  	options = [automount_opts];
  };
  fileSystems."/mnt/isos" = {
  	device = "192.168.1.62:/mnt/user/isos";
  	fsType = "nfs";
  	options = [automount_opts];
  };
  fileSystems."/mnt/movies" = {
  	device = "192.168.1.62:/mnt/user/movies";
  	fsType = "nfs";
  	options = [automount_opts];
  };
  fileSystems."/mnt/kmajnert" = {
  	device = "192.168.1.62:/mnt/user/kmajnert";
  	fsType = "nfs";
  	options = [automount_opts];
  };
}
