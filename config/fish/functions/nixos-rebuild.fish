function nixos-rebuild --wraps='sudo nixos-rebuild switch --flake /etc/nixos#default' --wraps='sudo nixos-rebuild switch --flake ~/.dotfiles/nixos/flake.nix' --wraps='sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#default' --description 'alias nixos-rebuild=sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#default'
  sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#default $argv
        
end
