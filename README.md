# ⭐ République Hagridienne — thème global KDE Plasma 6

Thème néon construit à partir de ton `index.html` : fond `#020818`, cyan `#00f5ff`, rose `#ff00cc`, or `#ffd700`,
lime `#00ff88`, traits de 2 px, ombre dure rose décalée (comme tes boutons), polices **VT323** / **Orbitron** /
**Press Start 2P**, et l'étoile ⭐ partout. L'accroche de la page — « Bienvenue dans le futur ! » — se retrouve
sur l'écran de démarrage et l'écran de connexion.

## Contenu

| Pièce | Où elle va | Ce qu'elle fait |
|---|---|---|
| Thème global `com.republiquehagridienne.zephyr` | `plasma/look-and-feel/` | Regroupe tout le reste (réglages par défaut + écran de démarrage animé) |
| Schéma de couleurs `RepubliqueHagridienne` | `color-schemes/` | Palette complète (fenêtres, boutons, sélection rose, info-bulles…) |
| Style Plasma `republique-hagridienne` | `plasma/desktoptheme/` | Panneau, fenêtres flottantes, info-bulles et widgets : cadre cyan/rose avec lueur (variantes translucide, opaque, solide) |
| Décorations de fenêtres Aurorae | `aurorae/themes/` | Barre de titre dégradée, trait néon, ombre rose dure, boutons pixel (⭐ menu, réduire or, agrandir lime, fermer rose) |
| Fond d'écran « Nuit hagridienne » | `wallpapers/` | Étoiles aux couleurs du canvas de ton site ; 7 résolutions dont 21:9 (3440×1440, 2560×1080, 3840×1600, 5120×2160) |
| Curseur « Étoile Hagridienne » *(facultatif)* | `icons/` | Pointeur ⭐ or, main ⭐ rose ; le reste vient de Breeze |
| Konsole | `konsole/` | Jeu de couleurs + profil (VT323 16 pt) |
| Écran de connexion SDDM *(facultatif, sudo)* | `/usr/share/sddm/themes/` | Panneau néon, horloge Press Start 2P, boutons d'alimentation |
| Polices | `fonts/` | VT323, Orbitron, Press Start 2P (licence OFL) |

Les icônes restent **breeze-dark** et le style d'applications reste **Breeze** (couleurs reprises du schéma).

## Installation

```bash
tar xzf republique-hagridienne-plasma.tar.gz
cd republique-hagridienne-plasma
./install.sh --apply                 # copie tout dans ~/.local/share et applique le thème
./install.sh --apply --star-cursor   # idem + curseur étoile
```

Sans `--apply`, le script copie seulement les fichiers ; choisis ensuite *Paramètres système → Apparence et style →
Thème global → République Hagridienne*. Déconnecte-toi puis reconnecte-toi pour que les polices, le curseur et
l'écran de démarrage soient pris en compte partout.

## Écran de connexion (SDDM) — en deux temps

Un thème SDDM défectueux peut donner un écran noir au démarrage : teste-le d'abord, sans rien changer.

```bash
./install.sh --sddm      # copie le thème dans /usr/share/sddm/themes (sudo), sans l'activer
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/republique-hagridienne
./install.sh --sddm-enable   # seulement si le test est bon
```

Retour arrière : `sudo rm /etc/sddm.conf.d/10-republique-hagridienne.conf` (depuis un TTY, Ctrl+Alt+F3, en cas de souci).

## Réglages utiles

- **Taille du texte** : VT323 est réglée à 14 pt (équivalent visuel de ton site). Plus net à 12 pt ou 24 pt (multiples de 16 px) :
  *Paramètres système → Apparence et style → Polices*.
- **Bordures des fenêtres** : garde « Normal » (réglage appliqué par le thème). « Aucune bordure latérale » supprime le trait néon sur les côtés.
- **Boutons de la barre de titre** : le thème ne touche pas à ta disposition (*Décorations de fenêtres → Configurer les boutons*).
- **Rester sur les polices d'origine** : après `--apply`, remets tes polices dans *Polices*.
- **Écran de verrouillage** : l'interface reste celle de Breeze ; choisis le fond « Nuit hagridienne » dans *Paramètres système → Verrouillage de l'écran → Apparence*.
- **Revenir à Breeze Sombre** : `plasma-apply-lookandfeel -a org.kde.breezedark`.

## Ce qui a été vérifié — et ce qui ne l'a pas été

Écrit d'après les sources actuelles de KDE (mi-octobre 2026 : Aurorae v2, KSvg, gestionnaire de thèmes globaux).
Vérifié ici : validité des fichiers (JSON, INI, XML), assemblage et rendu des SVG avec un simulateur de `FrameSvg`,
exécution du QML du splash et de SDDM dans Qt 6.12 (hors écran, avec des objets SDDM simulés), scripts passés à
shellcheck et testés dans un HOME temporaire.
**Non vérifié** : le thème n'a jamais tourné dans une vraie session Plasma (aucun KDE dans mon environnement) ;
les images de `apercu/` sont des **maquettes** assemblées avec les vrais SVG du thème, pas des captures d'écran.
Si quelque chose cloche au premier essai, c'est probablement un réglage fin à ajuster.

## Désinstallation

```bash
./uninstall.sh            # retire les fichiers de ~/.local/share
./uninstall.sh --sddm     # retire aussi l'écran de connexion (sudo)
```

Licences : voir `LICENSE.md`.
