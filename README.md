# PWM Module FPGA

Module PWM (Pulse Width Modulation) implémenté sur FPGA Zynq-7000 avec Vivado et Vitis.

## Description

Ce projet implémente un module PWM personnalisé pour FPGA avec:
- Design matériel en VHDL/Verilog
- Driver logiciel pour processeur ARM Cortex-A9
- Interface AXI-Lite pour la communication
- Application de test et démonstration

## Structure du projet

```
.
├── Vivdao/          # Projet Vivado (design matériel)
│   ├── pwm.xpr      # Fichier projet Vivado
│   ├── pwm.srcs/    # Sources du design
│   └── pwm.runs/    # Résultats de synthèse et implémentation
│
└── Vitis/           # Projet Vitis (logiciel embarqué)
    ├── app_component/     # Application principale
    └── platform/          # Configuration de la plateforme
```

## Technologies utilisées

- **Vivado Design Suite** - Conception et synthèse matérielle
- **Vitis IDE** - Développement logiciel embarqué
- **FPGA Zynq-7000** - Plateforme cible
- **AXI-Lite Protocol** - Bus de communication

## Utilisation

### Ouverture du projet Vivado
```bash
cd Vivdao
vivado pwm.xpr
```

### Compilation du logiciel
```bash
cd Vitis
# Ouvrir avec Vitis IDE
```

## Auteur

Abdennour GUESSOUM

## License

Projet académique
