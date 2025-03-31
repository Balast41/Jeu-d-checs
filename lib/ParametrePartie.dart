import 'package:flutter/material.dart';

import 'main.dart';


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
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, // Couleur de fond par défaut
            foregroundColor: Colors.white, // Couleur du texte par défaut
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const Parametrepartie(),
    );
  }
}



class Parametrepartie extends StatefulWidget {
  const Parametrepartie({super.key});

  @override
  State<Parametrepartie> createState() => _ParametrePartieState();
}

class _ParametrePartieState extends State<Parametrepartie> {

final List<String> choixPionsJ1=[
  'assets/ChoixPions/Joueur1/PB.png',
  'assets/ChoixPions/Joueur1/CP.png',
];

final List<String> choixPionsJ2=[
  'assets/ChoixPions/Joueur2/PN.png',
  'assets/ChoixPions/Joueur2/CP.png',
];

final List<String> choixPlateaux=[
  'assets/Plateau/plateau 1.png',
  'assets/Plateau/plateau2.png',
];

int indexJ1=0;
int indexJ2=0;
int indexPlateau=0;
int timerValue = 1000;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        TextEditingController minutesController = TextEditingController(
          text: (timerValue ~/ 60).toString().padLeft(2, '0'),
        );
        TextEditingController secondsController = TextEditingController(
          text: (timerValue % 60).toString().padLeft(2, '0'),
        );
        return AlertDialog(
          title: const Center(child: Text('Modifier le Timer')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Champ pour les minutes
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: minutesController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'MM',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      ':',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Champ pour les secondes
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: secondsController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '00',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Ferme la boîte de dialogue sans sauvegarder
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Met à jour la valeur du timer
                  final minutes = int.tryParse(minutesController.text) ?? 0;
                  final seconds = int.tryParse(secondsController.text) ?? 0;
                  timerValue = (minutes * 60) + seconds;
                });
                Navigator.pop(context); // Ferme la boîte de dialogue
              },
              child: const Text('Valider'),
            ),
          ],
        );
      },
    );
              },
              style:ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Timer'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context){
                    return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                    return AlertDialog(
                      title: const Center(child:Text('Plateaux'),),
                      
                      content:Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon:const Icon(Icons.arrow_left),
                                onPressed: () {
                                  setState(() {
                                    indexPlateau = (indexJ1 - 1) % choixPlateaux.length;
                                    if (indexPlateau < 0) indexJ1 = choixPlateaux.length - 1;
                                  });
                                },
                              ),
                              Image.asset(choixPlateaux[indexPlateau],width: 100,height: 100,errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error, size: 50); // Affiche une icône d'erreur
                                  },),
                              IconButton(
                                icon:const Icon(Icons.arrow_right),
                                onPressed: () {
                                  setState(() {
                                    indexPlateau = (indexPlateau + 1) % choixPlateaux.length;
                                    
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Ferme la boîte de dialogue
                        },
                        child: const Text('Fermer'),
                      ),
                    ],
                    );
                  },
                );
              },
            );
              },
                style:ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Plateau'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context){
                    return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                    return AlertDialog(
                      title: const Center(child:Text('Pions'),),
                      
                      content:Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Joueur 1'),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon:const Icon(Icons.arrow_left),
                                onPressed: () {
                                  setState(() {
                                    indexJ1 = (indexJ1 - 1) % choixPionsJ1.length;
                                    if (indexJ1 < 0) indexJ1 = choixPionsJ1.length - 1;
                                  });
                                },
                              ),
                              Image.asset(choixPionsJ1[indexJ1],width: 50,height: 50,errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error, size: 50); // Affiche une icône d'erreur
                                  },),
                              IconButton(
                                icon:const Icon(Icons.arrow_right),
                                onPressed: () {
                                  setState(() {
                                    indexJ1 = (indexJ1 + 1) % choixPionsJ1.length;
                                    
                                  });
                                  print(indexJ1);
                                },
                              ),
                            ],
                          ),
                          const Text('Joueur 2',),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon:const Icon(Icons.arrow_left),
                                onPressed: () {
                                  setState(() {
                                    indexJ2 = (indexJ2 - 1) % choixPionsJ2.length;
                                    if (indexJ2 < 0) indexJ2 = choixPionsJ2.length - 1;
                                  });
                                },
                              ),
                              Image.asset(choixPionsJ2[indexJ2],width: 50,height: 50,errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error, size: 50); // Affiche une icône d'erreur
                                    },),
                              IconButton(
                                icon:const Icon(Icons.arrow_right),
                                onPressed: () {
                                  setState(() {
                                    indexJ2 = (indexJ2 + 1) % choixPionsJ2.length;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Ferme la boîte de dialogue
                        },
                        child: const Text('Fermer'),
                      ),
                    ],
                    );
                  },
                );
              },
            );
          },
                style:ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Pions'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(indexJ1:indexJ1,indexJ2:indexJ2,indexPlateau:indexPlateau,)),
                  );
              },
              style:ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Jouer'),
            ),
          ],
      ),
      
      ),

    );
  }
}
