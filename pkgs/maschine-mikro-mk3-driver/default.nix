{
	pkgs,
	stdenv,
	fetchFromGitHub,
	rustPlatform,
	pkg-config,
	...
}:
let
	pkg_version = "b4a7031";
in
rustPlatform.buildRustPackage rec {
	pname = "maschine-mikro-mk3-driver";
	version = pkg_version;
	src = fetchFromGitHub {
		owner = "r00tman";
		repo = "maschine-mikro-mk3-driver";
		rev = pkg_version;
		sha256 = "sha256-uTZ+x5NjiDT5s4+fgfjTXf04WH9RiKvcGwSAYEG5YXo=";
	};
	cargoHash = "sha256-vPQS4lLJhKJTbQ7kGJp8BDlEgytqLjX4GxuhHByzeis=";
	buildInputs = with pkgs; [
		dbus
		webkitgtk
		openssl
		cargo
		alsa-lib
		libusb1
	];
	nativeBuildInputs = with pkgs; [
		pkg-config
		hidapi
	];
	dbus = pkgs.dbus;
	buildPhase = ''
		cargo build --release
	'';
	installPhase = ''
		mkdir -p $out/bin
		mkdir -p $out/etc/udev/rules.d/
		cp target/release/maschine-mikro-mk3-driver $out/bin
		cp 98-maschine.rules $out/etc/udev/rules.d/
	'';
}
