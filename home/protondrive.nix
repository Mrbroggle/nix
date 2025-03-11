{pkgs, ...}: {
  systemd.user.services.pdrive-mounts = {
    Unit = {
      Description = "Pdrive mount";
      After = ["network-online.target"];
    };
    Service = {
      Type = "notify";
      ExecStartPre = "/usr/bin/env mkdir -p /home/gradyb/netdrive/pdrive";
      ExecStart = "${pkgs.rclone}/bin/rclone --config=%h/.config/rclone/rclone.conf --vfs-cache-mode writes --ignore-checksum mount \"pdrive:\" \"/home/gradyb/netdrive/pdrive\"";
      ExecStop = "/bin/fusermount -u %h/home/gradyb/netdrive/pdrive%i";
    };
    Install.WantedBy = ["default.target"];
  };
}
