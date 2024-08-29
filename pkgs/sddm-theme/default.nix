{
  lib,
  formats,
  stdenvNoCC,
  fetchFromGitHub,
  qt6,
  libsForQt5,
  variants ? [ "qt6" ],
  /*
    An example of how you can override the background on the NixOS logo

      environment.systemPackages = [
        (pkgs.where-is-my-sddm-theme.override {
          themeConfig.General = {
            background = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            backgroundMode = "none";
          };
        })
      ];
  */
  themeConfig ? null,
}:

let
  user-cfg = (formats.ini { }).generate "theme.conf.user" themeConfig;
  validVariants = [
    "qt5"
    "qt6"
  ];
in

lib.checkListOfEnum "sddm-astronaut-them: variant" validVariants variants

stdenvNoCC.mkDerivation rec {
  pname = "sddm-astronaut-theme";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "Keyitdev";
    repo = pname;
    rev = "48ea0a792711ac0c58cc74f7a03e2e7ba3dc2ac0";
    sha256 = "0ga4jvw23vlj52vnfmzvkz16wybn9mrzlfmrnn62y1bprp7jyyli";
  };

  propagatedUserEnvPkgs =
    [ ]
    ++ lib.optional (lib.elem "qt5" variants) [ libsForQt5.qtgraphicaleffects ]
    ++ lib.optional (lib.elem "qt6" variants) [
      qt6.qt5compat
      qt6.qtsvg
    ];

  installPhase =
    ''
      mkdir -p $out/share/sddm/themes/
    ''
    + lib.optionalString (lib.elem "qt6" variants) (
      ''
        cp -aR $src $out/share/sddm/themes/$pname
      ''
      + lib.optionalString (lib.isAttrs themeConfig) ''
        ln -sf ${user-cfg} $out/share/sddm/themes/$pname/theme.conf.user
      ''
    );
    # + lib.optionalString (lib.elem "qt5" variants) (
    #   ''
    #     cp -r where_is_my_sddm_theme_qt5/ $out/share/sddm/themes/
    #   ''
    #   + lib.optionalString (lib.isAttrs themeConfig) ''
    #     ln -sf ${user-cfg} $out/share/sddm/themes/where_is_my_sddm_theme_qt5/theme.conf.user
    #   ''
    # );

  meta = with lib; {
    description = "Custom SDDM theme";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [ name-snrl ];
  };
}

