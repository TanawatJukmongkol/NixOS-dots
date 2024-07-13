USERNAME	=airgeddon1337
HOST		=nixos

NIX_FLAGS	= --extra-experimental-features "nix-command flakes"
NIXOS_FLAGS	= --cores 6
HOME_FLAGS	=

all: flake.lock switch home

lock: flake.lock

flake.lock:
	nix $(NIX_FLAGS) flake lock

update: flake.lock
	nix $(NIX_FLAGS) flake update

test:
	sudo nixos-rebuild $(NIXOS_FLAGS) test --flake .#$(HOST)

switch:
	sudo nixos-rebuild $(NIXOS_FLAGS) switch --flake .#$(HOST)

boot:
	sudo nixos-rebuild $(NIXOS_FLAGS) boot --install-bootloader --flake .#$(HOST)

home:
	home-manager $(HOME_FLAGS) --flake .#$(USERNAME)@$(HOST) switch

PHONY: all lock update test switch boot home
