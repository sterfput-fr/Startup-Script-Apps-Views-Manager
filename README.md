# Startup Script Apps Views Manager

Ce script PowerShell permet de lancer des applications spécifiques et de les déplacer vers des moniteurs définis en utilisant l'outil MultiMonitorTool.

## Fonctionnalités

- Crée un fichier de configuration par défaut si aucun n'existe.
- Lit la configuration à partir d'un fichier JSON.
- Lance les applications spécifiées avec les arguments et le style de fenêtre définis.
- Déplace les fenêtres des applications vers les moniteurs spécifiés.

## Prérequis

- PowerShell
- [MultiMonitorTool](https://www.nirsoft.net/utils/multi_monitor_tool.html)

## Installation

1. Téléchargez et installez MultiMonitorTool.
2. Placez `MultiMonitorTool.exe` dans le chemin spécifié dans le fichier de configuration (par défaut `C:\Tools\MultiMonitorTool.exe`).
3. Clonez ce dépôt ou téléchargez les fichiers du script.

## Utilisation

1. Modifiez le fichier `config.json` pour ajouter ou modifier les applications et leurs paramètres.
2. Exécutez le script PowerShell `ssavm.ps1`.

## Configuration

Le fichier de configuration `config.json` doit être au format suivant :
```
{
    "MultiMonitorToolPath": "C:\\Tools\\MultiMonitorTool.exe",
    "Applications": [
        {
            "Name": "notepad",
            "Arguments": "",
            "WindowStyle": "Normal",
            "Delay": 2,
            "Monitor": 1
        },
        {
            "Name": "calc",
            "Arguments": "/m",
            "WindowStyle": "Normal",
            "Delay": 2,
            "Monitor": 2
        }
    ]
}
```