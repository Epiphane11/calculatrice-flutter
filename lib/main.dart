import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatriceApp());
}

class CalculatriceApp extends StatelessWidget {
  const CalculatriceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculatrice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const CalculatriceScreen(),
    );
  }
}

/// Écran principal de la calculatrice
/// Gère l'affichage et les interactions utilisateur
class CalculatriceScreen extends StatefulWidget {
  const CalculatriceScreen({super.key});

  @override
  State<CalculatriceScreen> createState() => _CalculatriceScreenState();
}

class _CalculatriceScreenState extends State<CalculatriceScreen> {
  // Variables d'état pour gérer les calculs
  String _affichage = '0'; // Valeur affichée à l'écran
  String _operation = ''; // Opération en cours (ex: "12 +")
  double _premierNombre = 0; // Premier opérande
  String _operateur = ''; // Opérateur sélectionné (+, -, ×, ÷, %)
  bool _nouvelleOperation = true; // Indique si on démarre une nouvelle saisie

  /// Gère l'appui sur les boutons chiffres (0-9)
  void _appuiChiffre(String chiffre) {
    setState(() {
      if (_nouvelleOperation) {
        _affichage = chiffre;
        _nouvelleOperation = false;
      } else {
        _affichage = _affichage == '0' ? chiffre : _affichage + chiffre;
      }
    });
  }

  /// Gère l'appui sur le bouton décimal (.)
  void _appuiDecimal() {
    setState(() {
      if (_nouvelleOperation) {
        _affichage = '0.';
        _nouvelleOperation = false;
      } else if (!_affichage.contains('.')) {
        _affichage += '.';
      }
    });
  }

  /// Gère l'appui sur les boutons opérateurs (+, -, ×, ÷)
  void _appuiOperateur(String op) {
    setState(() {
      _premierNombre = double.parse(_affichage);
      _operateur = op;
      _operation = '$_affichage $op';
      _nouvelleOperation = true;
    });
  }

  /// Gère le bouton % (pourcentage)
  /// Implémentation: divise le nombre par 100
  /// Exemple: 50% devient 0.5
  void _appuiPourcentage() {
    setState(() {
      double valeur = double.parse(_affichage);
      valeur = valeur / 100;
      _affichage = _formaterResultat(valeur);
      _nouvelleOperation = true;
    });
  }

  /// Calcule et affiche le résultat final (bouton =)
  void _calculerResultat() {
    setState(() {
      if (_operateur.isEmpty) return;

      double deuxiemeNombre = double.parse(_affichage);
      double resultat = 0;

      // Effectue le calcul selon l'opérateur
      switch (_operateur) {
        case '+':
          resultat = _premierNombre + deuxiemeNombre;
          break;
        case '-':
          resultat = _premierNombre - deuxiemeNombre;
          break;
        case '×':
          resultat = _premierNombre * deuxiemeNombre;
          break;
        case '÷':
          if (deuxiemeNombre != 0) {
            resultat = _premierNombre / deuxiemeNombre;
          } else {
            _affichage = 'Erreur';
            _operation = '';
            _nouvelleOperation = true;
            return;
          }
          break;
        case '%':
          // Modulo: reste de la division entière
          resultat = _premierNombre % deuxiemeNombre;
          break;
      }

      _affichage = _formaterResultat(resultat);
      _operation = '$_premierNombre $_operateur $deuxiemeNombre =';
      _operateur = '';
      _nouvelleOperation = true;
    });
  }

  /// Formate le résultat pour un affichage propre
  /// Supprime les zéros inutiles après la virgule
  String _formaterResultat(double valeur) {
    if (valeur == valeur.toInt()) {
      return valeur.toInt().toString();
    }
    return valeur.toStringAsFixed(8).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
  }

  /// Réinitialise toute la calculatrice (bouton C)
  void _reinitialiser() {
    setState(() {
      _affichage = '0';
      _operation = '';
      _premierNombre = 0;
      _operateur = '';
      _nouvelleOperation = true;
    });
  }

  /// Inverse le signe du nombre affiché (bouton +/-)
  void _inverserSigne() {
    setState(() {
      if (_affichage != '0' && _affichage != 'Erreur') {
        if (_affichage.startsWith('-')) {
          _affichage = _affichage.substring(1);
        } else {
          _affichage = '-$_affichage';
        }
      }
    });
  }

  /// Crée un bouton circulaire de la calculatrice
  Widget _construireBouton({
    required String texte,
    required VoidCallback onTap,
    Color couleur = const Color(0xFF505050),
    Color couleurTexte = Colors.white,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: AspectRatio(
          aspectRatio: 1,
          child: Material(
            color: couleur,
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onTap,
              child: Center(
                child: Text(
                  texte,
                  style: TextStyle(
                    fontSize: 32,
                    color: couleurTexte,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Crée le bouton = qui s'étend sur 2 lignes
  Widget _construireBoutonEgal() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: const Color(0xFFFF9F0A),
        borderRadius: BorderRadius.circular(50),
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: _calculerResultat,
          child: const Center(
            child: Text(
              '=',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Zone d'affichage en haut
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Affichage de l'opération en cours
                    if (_operation.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          _operation,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white70,
                            fontWeight: FontWeight.w300,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    // Affichage du résultat principal
                    Text(
                      _affichage,
                      style: const TextStyle(
                        fontSize: 64,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ],
                ),
              ),
            ),
            // Clavier de la calculatrice
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  children: [
                    // Ligne 1: C, %, ÷, ×
                    Expanded(
                      child: Row(
                        children: [
                          _construireBouton(
                            texte: 'C',
                            onTap: _reinitialiser,
                            couleur: const Color(0xFF505050),
                          ),
                          _construireBouton(
                            texte: '%',
                            onTap: _appuiPourcentage,
                            couleur: const Color(0xFF505050),
                          ),
                          _construireBouton(
                            texte: '÷',
                            onTap: () => _appuiOperateur('÷'),
                            couleur: const Color(0xFFFF9F0A),
                          ),
                          _construireBouton(
                            texte: '×',
                            onTap: () => _appuiOperateur('×'),
                            couleur: const Color(0xFFFF9F0A),
                          ),
                        ],
                      ),
                    ),
                    // Ligne 2: 7, 8, 9, -
                    Expanded(
                      child: Row(
                        children: [
                          _construireBouton(texte: '7', onTap: () => _appuiChiffre('7')),
                          _construireBouton(texte: '8', onTap: () => _appuiChiffre('8')),
                          _construireBouton(texte: '9', onTap: () => _appuiChiffre('9')),
                          _construireBouton(
                            texte: '-',
                            onTap: () => _appuiOperateur('-'),
                            couleur: const Color(0xFFFF9F0A),
                          ),
                        ],
                      ),
                    ),
                    // Ligne 3: 4, 5, 6, +
                    Expanded(
                      child: Row(
                        children: [
                          _construireBouton(texte: '4', onTap: () => _appuiChiffre('4')),
                          _construireBouton(texte: '5', onTap: () => _appuiChiffre('5')),
                          _construireBouton(texte: '6', onTap: () => _appuiChiffre('6')),
                          _construireBouton(
                            texte: '+',
                            onTap: () => _appuiOperateur('+'),
                            couleur: const Color(0xFFFF9F0A),
                          ),
                        ],
                      ),
                    ),
                    // Lignes 4 et 5 combinées avec le bouton = étendu
                    Expanded(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Grille 3x2 pour les chiffres 1-3 et +/-, 0, .
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                // Ligne 4: 1, 2, 3
                                Expanded(
                                  child: Row(
                                    children: [
                                      _construireBouton(texte: '1', onTap: () => _appuiChiffre('1')),
                                      _construireBouton(texte: '2', onTap: () => _appuiChiffre('2')),
                                      _construireBouton(texte: '3', onTap: () => _appuiChiffre('3')),
                                    ],
                                  ),
                                ),
                                // Ligne 5: +/-, 0, .
                                Expanded(
                                  child: Row(
                                    children: [
                                      _construireBouton(
                                        texte: '+/-',
                                        onTap: _inverserSigne,
                                        couleur: const Color(0xFF505050),
                                      ),
                                      _construireBouton(texte: '0', onTap: () => _appuiChiffre('0')),
                                      _construireBouton(texte: '.', onTap: _appuiDecimal),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Bouton = qui s'étend sur les lignes 4 et 5
                          Expanded(
                            child: _construireBoutonEgal(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}