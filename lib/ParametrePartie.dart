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
  'assets/ChoixPions/Joueur1/PO.png',
  'assets/ChoixPions/Joueur1/PA.png',

];

final List<String> choixPionsJ2=[
  'assets/ChoixPions/Joueur2/PN.png',
  'assets/ChoixPions/Joueur2/CP.png',
  'assets/ChoixPions/Joueur2/PO.png',
  'assets/ChoixPions/Joueur2/PA.png',
];

final List<String> choixPlateaux=[
  'assets/Plateau/plateau 1.png',
  'assets/Plateau/plateau2.png',
  'assets/Plateau/plateau3.png',
  'assets/Plateau/plateau4.png',
  'assets/Plateau/plateau5.png',
  'assets/Plateau/plateau6.png',
];

int indexJ1=0;
int indexJ2=0;
int indexPlateau=0;
int timerValue = 1000;


  @override
  Widget build(BuildContext context) {
    double _currentVolume=0;
    bool isOn=true;


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      //Barre de parametre de l'application 
      appBar: AppBar(
      title: const Text('Paramètres de la Partie',style:TextStyle(color: Colors.white)),
      backgroundColor: Colors.black, // Couleur de l'AppBar
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: Colors.white), // Icône blanche
          onPressed: () {

                                 showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context){
                    return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                    return AlertDialog(
                      title: const Center(child:Text('Parametres',style : TextStyle(color:Colors.white)),),
                      backgroundColor: const Color.fromARGB(255, 158, 158, 158),
                      content:Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          Text("Musique",style: TextStyle(fontSize: 20, color: Colors.white) ),
                          Row(
                            
                            mainAxisAlignment: MainAxisAlignment.center, // Centre les éléments
                            children: [
                              Icon(Icons.volume_off, size: 30, color: Colors.white),
                              Expanded(child:Slider(
                                  value: _currentVolume,
                                  onChanged: (value) {
                                  //FlutterVolumeController.setVolume(value);
                                  setState(() {
                                   _currentVolume = value;                      
                                   });                                   
                                  },

                                  activeColor: const Color.fromARGB(255, 32, 111, 34)
                              ),),
                              Icon(Icons.volume_up, size: 30, color:Colors.white),

                            ],
                          ),
                           Row(
                            
                            mainAxisAlignment: MainAxisAlignment.center, // Centre les éléments
                            children: [
                              Text("Mode assisté",style: TextStyle(fontSize: 20, color:Colors.white) ),
                              Switch(
                                value: isOn, // État du switch                              
                                onChanged: (value) {
                                  setState(() {
                                    isOn = value;
                                    });
                                  },
                                  activeColor: const Color.fromARGB(255, 32, 111, 34),
                                )
                              ]
                            )

                        ],

                      ),
                      actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Ferme la boîte de dialogue
                        },
                        child: const Text('Fermer',style: TextStyle(fontSize: 20, color:Colors.white) ),
                      ),
                    ],
                    );
                  },
                );
              },
            ); // Ouvre le popup des paramètres
           
          },
        ),
      ],
    ),

    //Paramatre de la partie
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
                                      indexPlateau = (indexPlateau - 1 + choixPlateaux.length) % choixPlateaux.length;
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
                                    do {
                                        indexJ1 = (indexJ1 - 1 + choixPionsJ1.length) % choixPionsJ1.length;
                                      } while (indexJ1 != 0 && indexJ1 == indexJ2);
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
                                    do {
                                      indexJ1 = (indexJ1 + 1) % choixPionsJ1.length;
                                    } while (indexJ1 != 0 && indexJ1 == indexJ2);
                                    
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
                                    do {
                                        indexJ2 = (indexJ2 - 1 + choixPionsJ2.length) % choixPionsJ2.length;
                                      } while (indexJ2 != 0 && indexJ2 == indexJ1);
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
                                    do {
                                        indexJ2 = (indexJ2 + 1) % choixPionsJ2.length;
                                      } while (indexJ2 != 0 && indexJ2 == indexJ1);
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
                  MaterialPageRoute(builder: (context) => MyHomePage(indexJ1:indexJ1,indexJ2:indexJ2,indexPlateau:indexPlateau,timerValue: timerValue,)),
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
