{
  lib,
  config,
  ...
}: {
  options = {
    kanata.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.kanata.enable {
    boot.kernelModules = ["uinput"];

    hardware.uinput.enable = true;

    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    users.groups.uinput = {};

    systemd.services.kanata-internalKeyboard.serviceConfig = {
      SupplementaryGroups = [
        "input"
        "uinput"
      ];
    };

    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          port = 6666;
          devices = [
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          ];
          extraDefCfg = "process-unmapped-keys yes concurrent-tap-hold yes";
          config = ''
            (defsrc
              esc   f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11   f12
              grv    1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab    q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps   a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft   z    x    c    v    b    n    m    ,    .    /      rsft
              lctl lmet  lalt         spc           ralt rctl
            )

            (deflayer ColemakCAWS
              esc   brdn brup  _    _    _    _   prev  pp  next mute vold volu
              grv    1    2    3    4    5    6    7    8    9    0    \    =    bspc
              tab    q    w    f    p    b    [    j    l    u    y    '    -    ;
              esc    a    r    s    t    g    ]    m    n    e    i    o    ret
              lsft   x    c    d    v    z    /    k    h    ,    .      rsft
              lctl lmet lalt        spc           ralt rctl
            )

            (deflayer extend
              XX    XX    XX   XX    XX    XX    XX    XX    XX    XX    XX    XX   XX
              XX    XX    XX   XX    XX    XX    XX    XX    XX    XX    XX    XX   XX   XX
              tab  esc  prev   pp    next  XX   pgup  home   XX    up    end   del  bck  fwd
              XX    XX  lctl  lsft   lalt  XX    XX   pgdn  left  down   rght  bspc    ret
              XX   M-x   M-c   XX    M-v   M-z   XX    XX    XX    XX    XX    XX
              XX    XX    XX                  XX            XX   XX
            )

            (deflayer QWERTY

              esc   f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11   f12
              grv    1    2    3    4    5    6    7    8    9    0    -    =    bspc
              tab    q    w    e    r    t    y    u    i    o    p    [    ]    \
              caps   a    s    d    f    g    h    j    k    l    ;    '    ret
              lsft   z    x    c    v    b    n    m    ,    .    /      rsft
              lctl lmet  lalt         spc           ralt rctl
            )

            (defchordsv2
              (lsft lalt 1) (layer-switch ColemakCAWS) 500 first-release ()
              (lsft lalt 2) (layer-switch QWERTY)      500 first-release ()
            )

          '';
        };
      };
    };
  };
}
