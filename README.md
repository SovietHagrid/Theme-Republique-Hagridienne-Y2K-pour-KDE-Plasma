<h1 align="center">⭐ République Hagridienne</h1>

<p align="center">
  <strong>Thème global KDE Plasma 6 néon rétro-futuriste</strong><br>
  couleurs · style Plasma · décorations de fenêtres · icônes · curseur · écrans de démarrage et de connexion
</p>

<p align="center">
  <img alt="KDE Plasma 6" src="https://img.shields.io/badge/KDE%20Plasma-6-1d99f3?logo=kde&logoColor=white">
  <img alt="Version a1.1" src="https://img.shields.io/badge/version-1.1-00f5ff">
  <img alt="Licence propriétaire" src="https://img.shields.io/badge/licence-propri%C3%A9taire-ff00cc">
</p>

<p align="center">
  <img src="apercu/bureau-maquette.jpg" alt="Maquette du bureau : Dolphin, Konsole, panneau et info-bulle aux couleurs néon" width="900">
</p>

> [!NOTE]
> Les images de ce dépôt sont des **maquettes** assemblées avec les vrais fichiers du thème (cadres Plasma, décorations de fenêtres, icônes), pas des captures d'écran d'une session Plasma.

> [!IMPORTANT]
> **Licence propriétaire — tous droits réservés.** La reproduction et la distribution de ce thème sont interdites sans l'accord préalable de Soviet_Hagrid. Détails et exceptions dans [`LICENSE.md`](LICENSE.md).

Thème construit à partir du site de la République Hagridienne : fond nuit `#020818`, cyan `#00f5ff`, rose `#ff00cc`, or `#ffd700`, lime `#00ff88`, traits de 2 px, ombre rose dure décalée (comme les boutons du site), polices **VT323**, **Orbitron** et **Press Start 2P**, et l'étoile ⭐ partout. L'accroche du site — « Bienvenue dans le futur ! » — se retrouve sur l'écran de démarrage et l'écran de connexion.

## Aperçu

<table>
  <tr>
    <td align="center"><img src="apercu/demarrage-splash.jpg" alt="Écran de démarrage : étoile, titre et chargeur pixel" width="440"><br><sub>Écran de démarrage</sub></td>
    <td align="center"><img src="apercu/connexion-sddm.jpg" alt="Écran de connexion SDDM : panneau néon avec ombre rose dure" width="440"><br><sub>Écran de connexion (SDDM)</sub></td>
  </tr>
  <tr>
    <td align="center"><img src="apercu/fenetres-decoration.jpg" alt="Décorations de fenêtres : fenêtre active et fenêtre inactive" width="440"><br><sub>Décorations de fenêtres (active et inactive)</sub></td>
    <td align="center"><img src="apercu/icones-hagridienne-neon.jpg" alt="Planche d'icônes du pack Hagridienne Néon" width="440"><br><sub>Pack d'icônes « Hagridienne Néon »</sub></td>
  </tr>
  <tr>
    <td colspan="2" align="center"><img src="apercu/curseurs.png" alt="Curseurs étoile : flèche or et main rose, en trois tailles" width="440"><br><sub>Curseur « Étoile Hagridienne » (facultatif)</sub></td>
  </tr>
</table>

## Contenu

| Composant | Dossier du dépôt | Installé dans |
|---|---|---|
| **Thème global** `com.republiquehagridienne.zephyr` — réglages par défaut et écran de démarrage animé | `share/plasma/look-and-feel/` | `~/.local/share/plasma/look-and-feel/` |
| **Schéma de couleurs** `RepubliqueHagridienne` | `share/color-schemes/` | `~/.local/share/color-schemes/` |
| **Style Plasma** `republique-hagridienne` — panneau, popups, info-bulles, widgets (variantes translucide, opaque, solide) | `share/plasma/desktoptheme/` | `~/.local/share/plasma/desktoptheme/` |
| **Décorations de fenêtres** (Aurorae) — barre de titre dégradée, trait néon, ombre rose dure, boutons pixel | `share/aurorae/themes/` | `~/.local/share/aurorae/themes/` |
| **Pack d'icônes** « Hagridienne Néon » — 733 icônes et environ 7 400 alias | `share/icons/hagridienne-neon/` | `~/.local/share/icons/` |
| **Curseur** « Étoile Hagridienne » *(facultatif)* | `share/icons/EtoileHagridienne/` | `~/.local/share/icons/` |
| **Fond d'écran** « Nuit hagridienne » — 7 résolutions dont 21:9 | `share/wallpapers/` | `~/.local/share/wallpapers/` |
| **Konsole** — jeu de couleurs et profil | `share/konsole/` | `~/.local/share/konsole/` |
| **Écran de connexion SDDM** *(facultatif)* | `share/sddm/themes/` | `/usr/share/sddm/themes/` |
| **Polices** VT323, Orbitron, Press Start 2P | `share/fonts/` | `~/.local/share/fonts/` |

Le style d'applications reste **Breeze** (couleurs reprises du schéma) et l'écran de verrouillage garde l'interface Breeze.

### Palette

| Rôle | Couleur |
|---|---|
| Zones de saisie, terminal | `#020818` |
| Fenêtres | `#0a1628` |
| Texte | `#cce0ff` |
| Cyan — traits, titres, liens, focus | `#00f5ff` |
| Rose — survol, ombre dure, accent | `#ff00cc` |
| Rose de sélection (texte blanc, contraste 4,8:1) | `#d400a8` |
| Or — étoile, bouton « réduire » | `#ffd700` |
| Lime — bouton « agrandir », succès | `#00ff88` |

## Prérequis

- **KDE Plasma 6**, avec **Breeze** (fourni avec Plasma) : les icônes absentes du pack retombent sur *Breeze Sombre*.
- `plasma-apply-lookandfeel` (fourni avec Plasma) pour l'option `--apply`.
- Pour l'écran de connexion *(facultatif)* : **SDDM** avec Qt 6.

## Installation

```bash
git clone https://github.com/SovietHagrid/Theme-Republique-Hagridienne-Y2K-pour-KDE-Plasma.git
cd republique-hagridienne-plasma

./install.sh --apply                  # copie tout dans ~/.local/share et applique le thème global
./install.sh --apply --star-cursor    # idem, avec le curseur étoile ⭐
```

Si `install.sh` n'est pas exécutable, lancer `bash install.sh --apply`.

Sans `--apply`, le script copie seulement les fichiers : choisir ensuite *Paramètres système → Apparence et style → Thème global → République Hagridienne*. Se déconnecter puis se reconnecter pour que les polices, le curseur et l'écran de démarrage soient pris en compte partout.

| Option | Effet |
|---|---|
| *(aucune)* | Copie les fichiers dans `~/.local/share`, sans rien appliquer. |
| `--apply` | Applique couleurs, style Plasma, décorations, icônes, polices (VT323 14 pt, titres en Orbitron), écran de démarrage et fond d'écran. |
| `--star-cursor` | Avec `--apply` : active le curseur ⭐. |
| `--sddm` | Installe l'écran de connexion dans `/usr/share/sddm/themes` (sudo), **sans l'activer**. |
| `--sddm-enable` | Active l'écran de connexion (à faire seulement après l'avoir testé). |

### Écran de connexion (SDDM) — en deux temps

Un thème SDDM défectueux peut donner un écran noir au démarrage : le tester d'abord, sans rien changer.

```bash
./install.sh --sddm       # copie le thème dans /usr/share/sddm/themes, sans l'activer
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/republique-hagridienne
./install.sh --sddm-enable    # seulement si le test est concluant
```

Retour arrière : `sudo rm /etc/sddm.conf.d/10-republique-hagridienne.conf` (depuis un TTY, `Ctrl+Alt+F3`, en cas de souci).

## Réglages et personnalisation

- **Taille du texte** : VT323 est réglée à 14 pt (équivalent visuel du site). Elle est plus nette à 12 pt ou 24 pt (multiples de 16 px) : *Paramètres système → Apparence et style → Polices*.
- **Bordures des fenêtres** : le thème applique « Normal ». « Aucune bordure latérale » supprime le trait néon sur les côtés.
- **Boutons de la barre de titre** : la disposition n'est pas modifiée (*Décorations de fenêtres → Configurer les boutons*).
- **Écran de verrouillage** : choisir le fond « Nuit hagridienne » dans *Paramètres système → Verrouillage de l'écran → Apparence*.
- **Revenir aux icônes Breeze** : *Paramètres système → Apparence et style → Icônes → Breeze Sombre*.
- **Revenir à Breeze Sombre** : `plasma-apply-lookandfeel -a org.kde.breezedark`.

## Désinstallation

```bash
./uninstall.sh            # retire les fichiers de ~/.local/share
./uninstall.sh --sddm     # retire aussi l'écran de connexion (sudo)
```

Si le thème est appliqué, appliquer d'abord un autre thème global (voir ci-dessus). Les polices restent dans `~/.local/share/fonts/republique-hagridienne` : supprimer ce dossier pour les retirer.

## Comment c'est fait

- **Style Plasma** : cadres au format `FrameSvg` de Plasma (toile de 157×64 : 9 tranches, masque de flou, ombre), avec les mêmes noms d'éléments que Breeze et un dessin entièrement original — trait néon de 2 px, lueur cyan et rose.
- **Décorations de fenêtres** : thème Aurorae en SVG, compatible avec le nouveau moteur (v2) et l'ancien (v1) ; `install.sh` détecte celui qui est présent et règle `library=` en conséquence. La marge de 12 px autour de la fenêtre sert d'ombre : lueur cyan et décalage rose de 4 px.
- **Icônes** : SVG simples (dégradés linéaires uniquement), `Inherits=breeze-dark,breeze,hicolor` pour tout ce que le pack ne couvre pas.
- **Écrans de démarrage et de connexion** : QML pur (QtQuick), sans dépendance à un style de contrôles.

## État de la version

Version 1.1, validée hors session : fichiers (JSON, INI, XML — dont les 733 SVG des icônes, sans alias cassé), rendu des SVG avec un simulateur de `FrameSvg`, QML du splash et de SDDM exécuté dans Qt 6.12 avec des objets SDDM simulés, scripts passés à `shellcheck` et testés dans un `HOME` temporaire. Le thème a été écrit d'après les sources de KDE de mi-octobre 2026.

**Pas encore éprouvée dans une vraie session Plasma** : un réglage fin peut être nécessaire au premier essai. Pour signaler un problème, joindre la version de Plasma (`plasmashell --version`) et la sortie de `./install.sh`.

## Historique

- **1.1** — pack d'icônes « Hagridienne Néon » intégré (icônes par défaut du thème global) ; licence propriétaire.
- **1.0** — première version : couleurs, style Plasma, décorations de fenêtres, écran de démarrage, écran de connexion, fond d'écran, curseur, Konsole, polices.

## Licence

© 2026 Soviet_Hagrid — **tous droits réservés**. La reproduction et la distribution de ce thème, du pack d'icônes « Hagridienne Néon » et des scripts sont interdites sans l'accord préalable de Soviet_Hagrid. L'installation et l'usage privé d'un exemplaire reçu de l'auteur ou avec son accord restent permis. Texte complet : [`LICENSE.md`](LICENSE.md).

Pour une demande d'autorisation, contacter Soviet_Hagrid via [soviet@republiquehagridienne.com](mailto:soviet@republiquehagridienne.com?subject=Demande%20d'autorisation%20de%20license%20de%20RSH%20Plasma).

## Crédits

- Polices **VT323**, **Orbitron** et **Press Start 2P**, sous [licence SIL OFL 1.1](https://openfontlicense.org/) (textes dans `share/fonts/republique-hagridienne/`) : © The VT323 Project Authors, © The Orbitron Project Authors, © The Press Start 2P Project Authors.
- **Breeze**, **KDE Plasma** et **SDDM** ne sont pas inclus et appartiennent à leurs auteurs. KDE et Plasma sont des marques de KDE e.V. ; ce projet est indépendant et n'est pas affilié à KDE.
- Les marques, noms et logos de tiers stylisés dans les icônes d'applications (Firefox, Steam, Discord, etc.) restent la propriété de leurs titulaires.
