{
  lib,
  formats,
  stdenvNoCC,
  fetchFromGitHub,
  qt6,
  libsForQt5,
  variants ? [ "qt5" "qt6" ],
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

lib.checkListOfEnum "sddm_theme: variant" validVariants variants

  stdenvNoCC.mkDerivation
  (finalAttrs: {
    pname = "sddm_theme";
    version = "6726b5e";

    src = fetchFromGitHub {
      owner = "totoro-ghost";
      repo = "sddm-astronaut";
      # rev = "refs/tags/v${finalAttrs.version}";
	  rev = "6726b5e";
	  hash = "sha256-j8pJvBml2LWxXNw1e/cSVXV+6w+K1lahv0uK1B9OYn0=";
    };

    propagatedUserEnvPkgs =
      [ ]
      ++ lib.optionals (lib.elem "qt5" variants) [ libsForQt5.qtgraphicaleffects ]
      ++ lib.optionals (lib.elem "qt6" variants) [
        qt6.qt5compat
        qt6.qtsvg
      ];

#    installPhase =
#      ''
#        mkdir -p $out/share/sddm/themes/
#      ''
#      + lib.optionalString (lib.elem "qt6" variants) (
#        ''
#          cp -r where_is_my_sddm_theme/ $out/share/sddm/themes/sddm_theme
#        ''
#        + lib.optionalString (lib.isAttrs themeConfig) ''
#          ln -sf ${user-cfg} $out/share/sddm/themes/sddm_theme/theme.conf.user
#        ''
#      )
#      + lib.optionalString (lib.elem "qt5" variants) (
#        ''
#          cp -r where_is_my_sddm_theme_qt5/ $out/share/sddm/themes/sddm_theme_qt5
#        ''
#        + lib.optionalString (lib.isAttrs themeConfig) ''
#          ln -sf ${user-cfg} $out/share/sddm/themes/sddm_theme_qt5/theme.conf.user
#        ''
#      );

	installPhase =
	''
		mkdir -p $out/share/sddm/themes/sddm_theme_qt5
	''
      + lib.optionalString (lib.elem "qt5" variants) (
        ''
          cp -r * $out/share/sddm/themes/sddm_theme_qt5
        ''
        + lib.optionalString (lib.isAttrs themeConfig) ''
          ln -sf ${user-cfg} $out/share/sddm/themes/sddm_theme_qt5/theme.conf.user
        ''
      );

    meta = {
      description = "A theme for the SDDM login manager made specifically for the Lubuntu distribution, but can also serve any other, that uses SDDM.";
      homepage = "https://github.com/totoro-ghost/sddm-astronaut.git";
      license = lib.licenses.lgpl3Only;
      platforms = lib.platforms.linux;
      maintainers = with lib.maintainers; [ name-snrl ];
    };
})
