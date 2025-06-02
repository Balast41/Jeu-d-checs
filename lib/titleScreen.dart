import 'package:echec/ParametrePartie.dart';
import 'package:flutter/material.dart';
import 'package:echec/PopUpParametre.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Chess.fr',
      home: const EcranTitre(),
    );
  }
}

class EcranTitre extends StatefulWidget {
  const EcranTitre({super.key});

  @override
  State<EcranTitre> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<EcranTitre> {
  double currentVolume = 0.5; // Valeur initiale du volume
  bool isOn = true; // Valeur initiale du switch

@override
Widget build(BuildContext context) {

  return Scaffold(
    body: Stack(
      children: [
        // Image en fond
        Positioned.fill(
          child: Container(
            margin: const EdgeInsets.only(top: 250), // Descend l'image de fond
            child: Image.asset(
              'assets/Plateau.png', // Remplacez par le chemin de votre image de fond
              fit: BoxFit.cover, // Adapte l'image pour couvrir tout l'écran
            ),
          ),
        ),
        // Contenu principal
        Column(
          children: [
            // Espace flexible pour pousser l'image un peu plus bas
            const Spacer(flex: 2),
            // Image centrée horizontalement
            Padding(
              padding: const EdgeInsets.only(bottom: 20), // Espacement entre l'image et le bouton
              child: Center(
                child: Image.asset(
                  'assets/logo2.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            // Bouton "Commencer" centré verticalement
            const Spacer(flex: 1),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Parametrepartie(currentVolume: currentVolume, isOn: isOn)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE7CD78),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                  minimumSize: const Size(120, 120),
                ),
                child: Image.asset(
                  'assets/Icon.png', // Remplacez par le chemin de votre image
                  width: 120, // Ajustez la largeur de l'image
                  height: 120, // Ajustez la hauteur de l'image
                ),
              ),
            ),
            // Espace flexible pour pousser le bouton "Paramètres" vers le bas
            const Spacer(flex: 3),
            // Bouton "Paramètres" en bas à gauche
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // Aligne le bouton à gauche
              children: [
                Padding(
                  padding: const EdgeInsets.all(20), // Espacement par rapport au bord
                  child: ElevatedButton(
                    onPressed: () {
                      showPopupParametres(
                        context,
                        currentVolume,
                        isOn,
                        (value) => setState(() => currentVolume = value),
                        (value) => setState(() => isOn = value),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE7CD78),
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                      minimumSize: const Size(80, 80), // Taille minimale du bouton
                    ),
                    child: Image.asset(
                      'assets/Settings.png', // Remplacez par le chemin de votre image
                      width: 50, // Ajustez la largeur de l'image
                      height: 50, // Ajustez la hauteur de l'image
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
}
