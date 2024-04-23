{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim 
    wget
    firefox
    
    git	  
    zsh
  ];
}

