import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'widget_timer.dart';

abstract class Piece {
  final String name;
  final Color color;
  final int x;
  final int y;

  Piece(this.name, this.color, this.x, this.y);

  Widget buildPiece(double size);
}

class Roi extends Piece {
  Roi(Color color,int x,int y) : super("Roi", color,x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? 'assets/images/RB.png'
      : 'assets/images/RN.png';
    return Image.asset(imagePath, width: size, height: size);
  }
}

class Reine extends Piece {
  Reine(Color color,int x,int y) : super("Reine", color,x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? 'assets/images/DB.png'
      : 'assets/images/DN.png';
    return Image.asset(imagePath, width: size, height: size);
  }
}

class Tour extends Piece {
  Tour(Color color,int x,int y) : super("Tour", color,x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? 'assets/images/TB.png'
      : 'assets/images/TN.png';
    return Image.asset(imagePath, width: size, height: size);
  }
}

class Fou extends Piece {
  Fou(Color color,int x,int y) : super("Fou", color,x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? 'assets/images/FB.png'
      : 'assets/images/FN.png';
    return Image.asset(imagePath, width: size, height: size);
  }
}

class Cavalier extends Piece {
  Cavalier(Color color,int x,int y) : super("Cavalier", color,x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? 'assets/images/CB.png'
      : 'assets/images/CN.png';
    return Image.asset(imagePath, width: size, height: size);
  }
}

class Pion extends Piece {
  Pion(Color color,int x,int y) : super("Pion", color,x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? 'assets/images/PB.png'
      : 'assets/images/PN.png';
    return Image.asset(imagePath, width: size, height: size);
  }
}

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Piece?> _board = List.filled(64,null);
  String _joueur = "Joueur 1";
  final int timer = 1000;

  late WidgetTimer _timerJoueur1;
  late WidgetTimer _timerJoueur2;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
    _timerJoueur1 = WidgetTimer(timer);
    _timerJoueur2 = WidgetTimer(timer);
  }

void _initializeBoard() {
  // Initialisation des pièces sur le plateau
  _board[0] = Tour(Colors.black, 0, 0);
  _board[1] = Cavalier(Colors.black, 1, 0);
  _board[2] = Fou(Colors.black, 2, 0);
  _board[3] = Reine(Colors.black, 3, 0);
  _board[4] = Roi(Colors.black, 4, 0);
  _board[5] = Fou(Colors.black, 5, 0);
  _board[6] = Cavalier(Colors.black, 6, 0);
  _board[7] = Tour(Colors.black, 7, 0);

  // Placement des pions noirs
  for (int i = 8; i < 16; i++) {
    _board[i] = Pion(Colors.black, i % 8, 1);
  }

  // Placement des pions blancs
  for (int i = 48; i < 56; i++) {
    _board[i] = Pion(Colors.white, i % 8, 6);
  }

  _board[56] = Tour(Colors.white, 0, 7);
  _board[57] = Cavalier(Colors.white, 1, 7);
  _board[58] = Fou(Colors.white, 2, 7);
  _board[59] = Reine(Colors.white, 3, 7);
  _board[60] = Roi(Colors.white, 4, 7);
  _board[61] = Fou(Colors.white, 5, 7);
  _board[62] = Cavalier(Colors.white, 6, 7);
  _board[63] = Tour(Colors.white, 7, 7);
}

  void _changeJoueur() {
    setState(() {
      if (_joueur == "Joueur 1") {
        _joueur = "Joueur 2";
      } else {
        _joueur = "Joueur 1";
      }
    });
  }

Widget _buildCell(int index, double cellSize) {
  bool isWhite = (index ~/ 8 % 2 == 0 && index % 8 % 2 == 0) || (index ~/ 8 % 2 == 1 && index % 8 % 2 == 1);
  Color cellColor = isWhite ? const Color(0xFFEEEED2) : const Color(0xFF769656);
  print('Index: $index, Piece: ${_board[index]?.name}');
  return GestureDetector(
    onTap: _changeJoueur,
    child: Container(
      width: cellSize,
      height: cellSize,
      decoration: BoxDecoration(
        color: cellColor,
      ),
      child: Center(
        child: _board[index]?.buildPiece(cellSize * 0.75) ?? Container(),
         // Affiche la pièce ou un container vide
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cellSize = screenWidth / 8; 

    return Scaffold(
      backgroundColor: const Color(0xFF4b4847),
      body: Center(
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: math.pi,
              child:
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: screenWidth,
                  height: cellSize,
                  color: const Color.fromARGB(255, 111, 111, 111),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "Joueur 2",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: _timerJoueur2,
                      )
                    ],
                  ),
                ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(8, (i) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(8, (j) => _buildCell(i * 8 + j, cellSize)),
              )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: screenWidth,
              height: cellSize,
              color: const Color.fromARGB(255, 111, 111, 111),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Joueur 1",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: _timerJoueur1,
                  )
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
