build:
	nixos-rebuild build --flake .

switch:
	sudo nixos-rebuild switch --flake .

test:
	sudo nixos-rebuild test --flake .
