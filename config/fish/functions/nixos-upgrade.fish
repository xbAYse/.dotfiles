function nixos-upgrade --wraps='sudo nixos-rebuild switch --upgrade --flake /etc/nixos#default' --description 'alias nixos-upgrade=sudo nixos-rebuild switch --upgrade --flake /etc/nixos#default'
  sudo nixos-rebuild switch --upgrade --flake /etc/nixos#default $argv
        
end
