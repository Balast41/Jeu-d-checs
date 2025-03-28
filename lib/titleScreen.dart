import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'widget_timer.dart';
import 'dart:async';
import 'ParametrePartie.dart';



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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: const EdgeInsets.only(top:50),
          child: Image.asset('assets/logo2.png',width: 200,height: 200,),
          ),
          ElevatedButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Parametrepartie()),
              );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
           
           ),
           child: const Text('Commencer'),
           ),
           Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, '/parametres');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: const Text('Paramètres'),
            ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ElevatedButton(
                onPressed: () {
                  print("Bouton droit appuyé");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Option 2'),
              ),
              
            ),
        ],
      )
    );
  }
}
