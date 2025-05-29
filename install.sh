#!/bin/bash

# Install yay if not already installed
install_Yay() {
  command -v yay &>/dev/null || { echo "Installing yay..."; sudo pacman -S --needed --noconfirm base-devel git && git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si --noconfirm && cd -; }
}

# Install required pacman packages
install_pacman_packages() {
  local REQUIRED_PKGS=("feh" "rofi" "nano" "ghostty" "thunar" "polybar" "fastfetch" "btop" "networkmanager" "flatpak" )
  for pkg in "${REQUIRED_PKGS[@]}"; do pacman -Q "$pkg" &>/dev/null || sudo pacman -S --noconfirm "$pkg"; done
}

# Install required yay (AUR) packages
install_yay_packages() {
  local AUR_PKGS=("vesktop" "zen-browser-bin")
  for pkg in "${AUR_PKGS[@]}"; do yay -Q "$pkg" &>/dev/null || yay -S --noconfirm "$pkg"; done
}

# Clone repo and copy configs
copy_configs() {
  git clone https://github.com/Syntr1x/dotfiles-sxwm /home/$USER/tempconf
  sudo cp -r /home/$USER/tempconf/* /home/$USER/.config/ 
  sudo cp /home/$USER/tempconf/Rofi-themes/*.rasi /usr/share/rofi/themes
  sudo cp /home/$USER/tempconf/Ghostty-themes/* /usr/share/ghostty/themes
  sudo cp /home/$USER/tempconf/.xinitrc /home/$USER/
  sudo cp /home/$USER/tempconf/.bash_profile /home/$USER/
  sudo cp /home/$USER/tempconf/polybar /etc/
  sudo chown -R "$USER":"$USER" ~/.config/rofi
}

# Main script
if [ "$(id -u)" -eq 0 ]; then echo "Do not run as root. Use sudo when prompted."; exit 1; fi
install_Yay
install_pacman_packages
install_yay_packages
copy_configs

echo "Cleaning up..."; sudo rm -rf /home/$USER/tempconf /home/$USER/.config/install.sh /home/$USER/.config/README.md /home/$USER/.config/LICENSE /home/$USER/.config/Ghostty-themes /home/$USER/.config/Rofi-themes
echo "Installation complete. Please restart your session."
