#!/usr/bin/env bash
# Désinstalle le thème « République Hagridienne » (fichiers copiés par install.sh).
#   ./uninstall.sh            retire les fichiers de ~/.local/share
#   ./uninstall.sh --sddm     retire aussi l'écran de connexion SDDM (sudo)
# Remarque : si le thème est actuellement appliqué, réapplique d'abord un autre thème global, par ex. :
#   plasma-apply-lookandfeel -a org.kde.breezedark
# © 2026 Soviet_Hagrid — Tous droits réservés. Reproduction et distribution interdites
# sans l'accord de Soviet_Hagrid (voir LICENSE.md).
set -euo pipefail
DATA="${XDG_DATA_HOME:-$HOME/.local/share}"; : "${DATA:?}"
say() { printf '\033[1;36m▸\033[0m %s\n' "$*"; }

rm -rf "$DATA/plasma/look-and-feel/com.republiquehagridienne.zephyr" \
       "$DATA/plasma/desktoptheme/republique-hagridienne" \
       "$DATA/aurorae/themes/RepubliqueHagridienne" \
       "$DATA/wallpapers/RepubliqueHagridienne" \
       "$DATA/icons/EtoileHagridienne" \
       "$DATA/icons/hagridienne-neon" \
       "$DATA/color-schemes/RepubliqueHagridienne.colors" \
       "$DATA/konsole/RepubliqueHagridienne.colorscheme" \
       "$DATA/konsole/RepubliqueHagridienne.profile"
say "Thème retiré de $DATA (les polices restent dans $DATA/fonts/republique-hagridienne ; supprime ce dossier si tu n'en veux plus)."

if [ "${1:-}" = "--sddm" ]; then
  sudo rm -f /etc/sddm.conf.d/10-republique-hagridienne.conf
  sudo rm -rf /usr/share/sddm/themes/republique-hagridienne
  say "Écran de connexion SDDM retiré."
fi
command -v kbuildsycoca6 >/dev/null 2>&1 && kbuildsycoca6 >/dev/null 2>&1 || true
