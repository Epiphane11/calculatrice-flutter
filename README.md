#  Calculatrice Mobile Flutter

##  Description
Application de calculatrice mobile développée avec Flutter dans le cadre du projet de Programmation Mobile.

**Institut :** IGIT (Institut du Génie Informatique et Télécommunications)  
**Date :** Décembre 2025  
**Langage :** Dart / Flutter

##  Fonctionnalités

-  **Opérations de base :** Addition (+), Soustraction (-), Multiplication (×), Division (÷)
-  **Pourcentage (%) :** Divise le nombre par 100 (ex: 50% = 0.5)
-  **Nombres décimaux :** Gestion complète des décimales
-  **Changement de signe (+/-)** : Inverse le signe du nombre
-  **Réinitialisation (C)** : Efface tout et recommence à zéro
-  **Interface responsive** : S'adapte à différentes tailles d'écran
-  **Design moderne** : Interface noire avec boutons orange et gris

##  Interface

L'interface respecte fidèlement la maquette fournie avec :
- Fond noir
- Affichage blanc en haut (résultat + opération en cours)
- Boutons circulaires gris pour les chiffres
- Boutons orange pour les opérateurs

##  Implémentation technique

### Bouton % (Pourcentage)
Le bouton % divise le nombre affiché par 100.
- **Exemple :** 50% → 0.5
- **Utilité :** Convertir un pourcentage en décimal

### Gestion des erreurs
- **Division par zéro :** Affiche "Erreur"
- **Valeurs décimales :** Formatage automatique (suppression des zéros inutiles)

##  Technologies utilisées

- **Framework :** Flutter 3.x
- **Langage :** Dart
- **Plateforme cible :** Android (émulateur et smartphone physique)
- **IDE :** Android Studio

##  Auteurs

- DABROGO Zalissa
- SAWADOGO Jean Epiphane 

**Enseignant :** COMPAORE MOCTAR

##  Installation et exécution

### Prérequis
- Flutter SDK installé
- Android Studio ou VS Code
- Émulateur Android ou smartphone physique

### Étapes
```bash
# Cloner le dépôt
git clone https://github.com/votre-username/calculatrice-flutter.git

# Entrer dans le dossier
cd calculatrice-flutter

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run
```


##  Licence

Projet académique - IGIT 2025S
