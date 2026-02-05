# PWM Module FPGA

Ce projet implémente un **module PWM (Pulse Width Modulation)** personnalisé sur FPGA Zynq-7000, avec un design matériel développé sous Vivado et une application logicielle embarquée sous Vitis.

---

## 1. Organisation du code

L'arborescence du dépôt est organisée comme suit :

```
.
├── Vivdao/
│   ├── pwm.xpr                     # Fichier projet Vivado principal
│   ├── pwm.srcs/
│   │   ├── sources_1/              # Sources HDL du module PWM
│   │   ├── constrs_1/              # Contraintes de placement et timing
│   │   └── sim_1/                  # Sources de simulation
│   ├── pwm.cache/                  # Cache des IPs et synthèses
│   ├── pwm.gen/                    # Fichiers générés automatiquement
│   ├── pwm.runs/                   # Résultats de synthèse et implémentation
│   └── pwm.hw/                     # Configuration matérielle exportée
│
├── Vitis/
│   ├── app_component/              # Application principale embarquée
│   │   ├── src/
│   │   │   ├── pwm.c               # Code d'utilisation du module PWM
│   │   │   └── pwm.h               # Interface du driver
│   │   └── build/                  # Binaires compilés
│   │
│   └── platform/                   # Configuration de la plateforme Zynq
│       ├── zynq_fsbl/              # First Stage Boot Loader
│       └── ps7_cortexa9_0/         # Configuration du processeur ARM
│
└── README.md                       # Présentation générale du projet
```

---

## 2. Architecture du système

Le système repose sur une architecture hybride **PS (Processing System) + PL (Programmable Logic)** :

- **PL (FPGA)** : Module PWM matériel avec interface AXI-Lite
- **PS (ARM Cortex-A9)** : Application de contrôle et configuration du PWM
- **Interconnexion** : Bus AXI pour la communication PS ↔ PL

### Fonctionnalités du module PWM

- Génération de signaux PWM configurables
- Contrôle de la période et du rapport cyclique
- Interface AXI-Lite pour configuration par logiciel
- Registres accessibles en lecture/écriture depuis le processeur ARM

---

## 3. Prérequis

### Logiciels requis

- **Xilinx Vivado Design Suite** (version 2020.2 ou supérieure)
- **Xilinx Vitis IDE** (version 2020.2 ou supérieure)
- **Carte de développement** : Zynq-7000 (ex: PYNQ-Z2, Zybo Z7, ZedBoard)

### Installation

1. Installer Vivado et Vitis depuis le site de Xilinx
2. Cloner ce dépôt :
   ```bash
   git clone https://github.com/abdennour-GUESSOUM/pwm-module-FPGA.git
   cd pwm-module-FPGA
   ```

---

## 4. Compilation et utilisation

### 4.1 Génération du bitstream (Vivado)

Pour ouvrir et compiler le projet matériel :

```bash
cd Vivdao
vivado pwm.xpr
```

Dans Vivado :
1. Cliquer sur **Generate Bitstream** pour synthétiser et implémenter le design
2. Exporter le hardware : **File → Export → Export Hardware** (inclure le bitstream)
3. Le fichier `.xsa` généré sera utilisé par Vitis

### 4.2 Compilation de l'application (Vitis)

Pour compiler l'application embarquée :

```bash
cd Vitis
vitis -workspace .
```

Dans Vitis :
1. Importer la plateforme depuis le fichier `.xsa` exporté
2. Builder le projet `app_component`
3. Générer le fichier `.elf` exécutable

### 4.3 Programmation de la carte

1. Connecter la carte Zynq via USB/JTAG
2. Dans Vitis : **Run → Run Configurations**
3. Créer une configuration **System Debugger**
4. Programmer le FPGA et exécuter l'application

---

## 5. Exemple d'utilisation

L'application `app_component` démontre l'utilisation du module PWM :

```c
#include "pwm.h"

int main() {
    // Initialisation du module PWM
    PWM_Init();

    // Configuration : période et rapport cyclique
    PWM_SetPeriod(1000);      // Période en cycles d'horloge
    PWM_SetDutyCycle(50);     // Rapport cyclique à 50%

    // Activation du signal PWM
    PWM_Enable();

    return 0;
}
```

---

## 6. Tests et validation

Le projet inclut :
- **Simulations comportementales** : testbenches dans `pwm.srcs/sim_1/`
- **Tests matériels** : validation sur carte
- **Tests logiciels** : vérification des registres et signaux de sortie

