function rebuild --wraps='sudo nixos-rebuild switch -I nixos-config=/home/bayse/.dotfiles/nixos/configuration.nix --flake /home/bayse/.dotfiles/nixos' --wraps='sudo nixos-rebuild switch -I nixos-config=/home/bayse/.dotfiles/nixos/configuration.nix' --description 'alias rebuild=sudo nixos-rebuild switch -I nixos-config=/home/bayse/.dotfiles/nixos/configuration.nix'
  sudo nixos-rebuild switch -I nixos-config=/home/bayse/.dotfiles/nixos/configuration.nix $argv
        
end
