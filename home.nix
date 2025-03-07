{ config, pkgs, ... }:

{
  home.username = "lima";
  home.homeDirectory = "/home/lima";

  home.packages = with pkgs; [
    git
    vscode
  ];

  home.file.".bashrc".text = ''
    export PATH=$HOME/bin:$PATH
  '';

  home.activation.installMyProjects = pkgs.lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "Installing custom projects..."
    mkdir -p ~/gitrepo
    cd ~/gitrepo

    if [ ! -d "LIMA_data" ]; then
      git clone https://github.com/DanielRJohansen/LIMA_data.git
    fi

    if [ ! -d "LIMA" ]; then
      git clone https://github.com/DanielRJohansen/LIMA.git
    fi

    cd my-project
    chmod +x install.sh
    ./install.sh -none
  '';

  home.stateVersion = "23.11";
}
