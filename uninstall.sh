#!/usr/bin/env bash
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
