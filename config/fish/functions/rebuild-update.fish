function rebuild-update --wraps='sudo nixos-rebuild switch --upgrade -I nixos-config=/home/bayse/.dotfiles/nixos/configuration.nix' --description 'alias rebuild-update=sudo nixos-rebuild switch --upgrade -I nixos-config=/home/bayse/.dotfiles/nixos/configuration.nix'
  sudo nixos-rebuild switch --upgrade -I nixos-config=/home/bayse/.dotfiles/nixos/configuration.nix $argv
        
end
