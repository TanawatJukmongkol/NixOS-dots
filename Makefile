HOST		=nixos

NIX_FLAGS	= --extra-experimental-features "nix-command flakes"
NIXOS_FLAGS	= -j 4 --cores 6
HOME_FLAGS	= -j 4 --cores 6

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

upgrade: update
	sudo nixos-rebuild $(NIXOS_FLAGS) switch --upgrade --flake .#$(HOST)

rescue:
	nixos-rebuild --option sandbox false $(NIXOS_FLAGS) boot --install-bootloader --flake .#$(HOST)

boot:
	sudo nixos-rebuild $(NIXOS_FLAGS) boot --install-bootloader --flake .#$(HOST)

home:
	home-manager $(HOME_FLAGS) --flake .#$(USER)@$(HOST) switch -b backup

PHONY: all lock update test switch rescue boot home
