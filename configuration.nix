{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfi = true;

  networking.hostName = "lima-laptop";  # Change this
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Copenhagen";  # Adjust to your timezone

  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "dk";
  
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
    layout = "dk";  # Danish keyboard layout
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    vim
    htop
    neofetch
    vscode
    gromacs
    cmake
    ninja
    gcc
    gnumake
    clang
    llvm
    cudaPackages.cudatoolkit
    python3
    python311Packages.numpy
    python311Packages.scipy
    tbb
    glm
    glfw
    libGL
    mesa
  ];

  users.users.your-username = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "docker" ];
    shell = pkgs.fish; # Change to bash or zsh if preferred
  };

  services.openssh.enable = true;

  system.stateVersion = "23.11";
}
