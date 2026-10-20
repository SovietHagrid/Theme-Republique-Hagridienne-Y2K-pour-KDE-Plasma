#!/usr/bin/env bash
# =============================================================================
#  République Hagridienne — thème global KDE Plasma 6
#  Installation dans ton profil (aucun droit root nécessaire, sauf pour SDDM).
#
#    ./install.sh                  copie tout dans ~/.local/share (n'applique rien)
#    ./install.sh --apply          copie puis applique le thème global
#    ./install.sh --apply --star-cursor   ... et active le curseur étoile ⭐
#    ./install.sh --sddm           installe aussi l'écran de connexion (sudo), SANS l'activer
#    ./install.sh --sddm-enable    ... et l'active (à faire seulement après l'avoir testé !)
# =============================================================================
#  © 2026 Soviet_Hagrid — Tous droits réservés. Reproduction et distribution interdites
#  sans l'accord de Soviet_Hagrid (voir LICENSE.md).
# =============================================================================
set -euo pipefail

ID="com.republiquehagridienne.zephyr"
HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SRC="$HERE/share"
DATA="${XDG_DATA_HOME:-$HOME/.local/share}"; : "${DATA:?}"
APPLY=0; STAR=0; SDDM=0; SDDM_ENABLE=0

say()  { printf '\033[1;36m▸\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!\033[0m %s\n' "$*" >&2; }
usage(){ sed -n '2,11p' "$0" | sed 's/^# \{0,1\}//'; }

for a in "$@"; do
  case "$a" in
    --apply) APPLY=1 ;;
    --star-cursor) STAR=1 ;;
    --sddm) SDDM=1 ;;
    --sddm-enable) SDDM=1; SDDM_ENABLE=1 ;;
    -h|--help) usage; exit 0 ;;
    *) warn "Option inconnue : $a"; usage; exit 1 ;;
  esac
done

[ -d "$SRC" ] || { warn "Dossier 'share' introuvable à côté du script."; exit 1; }

# --- vérification de l'environnement ---------------------------------------------------------
if command -v plasmashell >/dev/null 2>&1; then
  ver="$(plasmashell --version 2>/dev/null | grep -oE '[0-9]+(\.[0-9]+)*' | head -1 || true)"
  say "Plasma détecté : ${ver:-version inconnue}"
  case "${ver%%.*}" in 6|7|8|9) ;; *) warn "Ce thème est conçu pour Plasma 6 ; sur Plasma ${ver:-?}, certains éléments peuvent ne pas fonctionner." ;; esac
else
  warn "plasmashell est introuvable : j'installe quand même les fichiers."
fi

put() {  # put <dossier source> <dossier parent de destination>
  mkdir -p "${2:?}"; rm -rf "${2:?}/$(basename "${1:?}")"; cp -a "$1" "$2/"
}

# --- 1. copie des composants -----------------------------------------------------------------
say "Copie des composants dans $DATA"
put "$SRC/plasma/look-and-feel/$ID"                  "$DATA/plasma/look-and-feel"
put "$SRC/plasma/desktoptheme/republique-hagridienne" "$DATA/plasma/desktoptheme"
put "$SRC/aurorae/themes/RepubliqueHagridienne"      "$DATA/aurorae/themes"
put "$SRC/wallpapers/RepubliqueHagridienne"          "$DATA/wallpapers"
put "$SRC/icons/EtoileHagridienne"                   "$DATA/icons"
put "$SRC/icons/hagridienne-neon"                     "$DATA/icons"
mkdir -p "$DATA/color-schemes" "$DATA/konsole"
cp -f "$SRC/color-schemes/RepubliqueHagridienne.colors"     "$DATA/color-schemes/"
cp -f "$SRC/konsole/RepubliqueHagridienne.colorscheme"      "$DATA/konsole/"
cp -f "$SRC/konsole/RepubliqueHagridienne.profile"          "$DATA/konsole/"

say "Pack d'icônes « Hagridienne Néon » installé"
command -v gtk-update-icon-cache >/dev/null 2>&1 && gtk-update-icon-cache -q -t -f "$DATA/icons/hagridienne-neon" >/dev/null 2>&1 || true

# --- 2. polices (VT323, Orbitron, Press Start 2P — licence OFL) -------------------------------
say "Installation des polices"
put "$SRC/fonts/republique-hagridienne" "$DATA/fonts"
command -v fc-cache >/dev/null 2>&1 && fc-cache -f "$DATA/fonts" >/dev/null 2>&1 || true
if command -v fc-list >/dev/null 2>&1; then
  FONTS_SEEN="$(fc-list 2>/dev/null || true)"
  for f in "VT323" "Orbitron" "Press Start 2P"; do
    if grep -qi "$f" <<<"$FONTS_SEEN"; then echo "   ✓ $f"; else warn "   police « $f » non détectée par fontconfig (relance la session ?)"; fi
  done
fi

# --- 3. choix du plugin Aurorae (v2 récent, sinon v1) -----------------------------------------
detect_aurorae() {
  local base d lib
  local -a dirs=()
  command -v qtpaths6 >/dev/null 2>&1 && dirs+=("$(qtpaths6 --plugin-dir 2>/dev/null || true)")
  dirs+=(/usr/lib/qt6/plugins /usr/lib64/qt6/plugins /usr/lib/x86_64-linux-gnu/qt6/plugins /usr/lib/aarch64-linux-gnu/qt6/plugins)
  for lib in org.kde.kwin.aurorae.v2 org.kde.kwin.aurorae; do
    for base in "${dirs[@]}"; do
      [ -n "$base" ] || continue
      for d in org.kde.kdecoration3 org.kde.kdecoration2; do
        [ -e "$base/$d/$lib.so" ] && { echo "$lib"; return; }
      done
    done
  done
  echo "org.kde.kwin.aurorae.v2"
}
LIB="$(detect_aurorae)"
sed -i "s|^library=.*|library=$LIB|" "$DATA/plasma/look-and-feel/$ID/contents/defaults"
say "Décorations de fenêtres : plugin $LIB"

command -v kbuildsycoca6 >/dev/null 2>&1 && kbuildsycoca6 >/dev/null 2>&1 || true

# --- 4. application (facultative) -------------------------------------------------------------
if [ "$APPLY" = 1 ]; then
  command -v plasma-apply-lookandfeel >/dev/null 2>&1 || { warn "plasma-apply-lookandfeel est introuvable : applique le thème depuis Paramètres système."; exit 1; }
  say "Application du thème global (couleurs, style Plasma, décorations, polices, splash, fond d'écran)"
  plasma-apply-lookandfeel -a "$ID"
  command -v plasma-apply-wallpaperimage >/dev/null 2>&1 && plasma-apply-wallpaperimage "$DATA/wallpapers/RepubliqueHagridienne" >/dev/null 2>&1 || true
  if [ "$STAR" = 1 ]; then
    command -v plasma-apply-cursortheme >/dev/null 2>&1 && plasma-apply-cursortheme EtoileHagridienne || warn "plasma-apply-cursortheme introuvable : choisis « Étoile Hagridienne » dans Paramètres système → Curseurs."
  fi
  command -v qdbus6 >/dev/null 2>&1 && qdbus6 org.kde.KWin /KWin reconfigure >/dev/null 2>&1 || true
else
  say "Fichiers installés. Pour appliquer : Paramètres système → Apparence et style → Thème global → « République Hagridienne »"
  echo "   (ou relance ce script avec --apply)"
fi

# --- 5. écran de connexion SDDM (facultatif, droits root) -------------------------------------
if [ "$SDDM" = 1 ]; then
  SD="/usr/share/sddm/themes"
  say "Installation de l'écran de connexion SDDM (sudo)"
  sudo mkdir -p "$SD"
  sudo rm -rf "$SD/republique-hagridienne"
  sudo cp -a "$SRC/sddm/themes/republique-hagridienne" "$SD/"
  GREETER="$(command -v sddm-greeter-qt6 || command -v sddm-greeter || true)"
  echo
  echo "   Teste-le d'abord dans une fenêtre (sans rien changer) :"
  echo "     ${GREETER:-sddm-greeter-qt6} --test-mode --theme $SD/republique-hagridienne"
  if [ "$SDDM_ENABLE" = 1 ]; then
    say "Activation de l'écran de connexion"
    sudo mkdir -p /etc/sddm.conf.d
    printf '[Theme]\nCurrent=republique-hagridienne\n' | sudo tee /etc/sddm.conf.d/10-republique-hagridienne.conf >/dev/null
    echo "   Activé. Pour revenir en arrière : sudo rm /etc/sddm.conf.d/10-republique-hagridienne.conf"
    echo "   (en cas d'écran noir au démarrage : Ctrl+Alt+F3, connecte-toi, puis lance cette commande)"
  else
    echo "   Si le test est concluant, active-le avec :  ./install.sh --sddm-enable"
  fi
fi

say "Terminé. ⭐ Bienvenue dans le futur !"
