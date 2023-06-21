{ config, lib, pkgs, ... }

{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/uuid";
      fsType = "btrfs";
    };
    
}
    
