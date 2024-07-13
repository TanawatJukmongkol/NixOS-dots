USERNAME	=airgeddon1337
HOST		=nixos

NIX_FLAGS = --extra-experimental-features "nix-command flakes"

all: flake.lock switch home

lock: flake.lock

flake.lock:
	nix $(NIX_FLAGS) flake lock

update: flake.lock
	nix $(NIX_FLAGS) flake update

test:
	sudo nixos-rebuild test --flake .#$(HOST)

switch:
	sudo nixos-rebuild switch --flake .#$(HOST)

home:
	home-manager --flake .#$(USERNAME)@$(HOST) switch

PHONY: lock update test switch home
