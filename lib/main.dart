import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'widget_timer.dart';
import 'ParametrePartie.dart';
import 'Pieces.dart';
import 'Regles.dart';


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
      home: const MyHomePage(indexJ1: 0,indexJ2: 0,indexPlateau: 0),
    );
  }
}



class MyHomePage extends StatefulWidget {
  final int indexJ1;
  final int indexJ2;
  final int indexPlateau;

  const MyHomePage({super.key, required this.indexJ1, required this.indexJ2,required this.indexPlateau,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<List> pionsJ1;
  late List<List> pionsJ2;
  late List<List<Color>> plateaux;




  final List<Piece?> _board = List.filled(64,null);
  String _joueur = "Joueur 1";
  final int timer = 1000;

  final GlobalKey<WidgetTimerState> _timerJoueur1 = GlobalKey<WidgetTimerState>();
  final GlobalKey<WidgetTimerState> _timerJoueur2 = GlobalKey<WidgetTimerState>();


  List<int> _highlightedCells = [];
  int? _selectedCell;
  

  @override
  void initState() {
    super.initState();
    _initializeBoard();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timerJoueur1.currentState?.startTimer();
    });

pionsJ1=[
  ['assets/ChoixPions/Joueur1/PB.png', 'assets/ChoixPions/Joueur1/CP.png'],
  ['assets/ChoixPions/Joueur1/RB.png', 'assets/ChoixPions/Joueur1/RS.png'],
  ['assets/ChoixPions/Joueur1/DB.png', 'assets/ChoixPions/Joueur1/DA.png'],
  ['assets/ChoixPions/Joueur1/FB.png', 'assets/ChoixPions/Joueur1/FE.png'],
  ['assets/ChoixPions/Joueur1/TB.png', 'assets/ChoixPions/Joueur1/TG.png'],
  ['assets/ChoixPions/Joueur1/CB.png', 'assets/ChoixPions/Joueur1/CC.png']
  
];

pionsJ2=[
  ['assets/ChoixPions/Joueur1/PN.png', 'assets/ChoixPions/Joueur1/CP.png'],
  ['assets/ChoixPions/Joueur1/RN.png', 'assets/ChoixPions/Joueur1/RS.png'],
  ['assets/ChoixPions/Joueur1/DN.png', 'assets/ChoixPions/Joueur1/DA.png'],
  ['assets/ChoixPions/Joueur1/FN.png', 'assets/ChoixPions/Joueur1/FE.png'],
  ['assets/ChoixPions/Joueur1/TN.png', 'assets/ChoixPions/Joueur1/TG.png'],
  ['assets/ChoixPions/Joueur1/CN.png', 'assets/ChoixPions/Joueur1/CC.png']
];

plateaux=[
  [const Color(0xFFEEEED2),const Color(0xFF769656)],
  [const Color(0xFFC69C6D),const Color(0xFF603813)],

  
];
  
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
        _timerJoueur1.currentState?.pause();
        _timerJoueur2.currentState?.startTimer();
      } else {
        _joueur = "Joueur 1";
        _timerJoueur2.currentState?.pause();
        _timerJoueur1.currentState?.startTimer();
      }
    });
  }

  void _movePiece(int fromIndex, int toIndex) {
    setState(() {
      // Déplace la pièce
      Piece? piece = _board[fromIndex];
      if (piece != null) {
        _board[toIndex] = piece;
        _board[fromIndex] = null;

        // Mettez à jour les coordonnées de la pièce
        piece.x = toIndex % 8;
        piece.y = toIndex ~/ 8;

        piece.aBouge = true; // Marque la pièce comme ayant bougé

        if (piece is Pion) {
          if ((piece.color == Colors.white && piece.y == 0) ||
              (piece.color == Colors.black && piece.y == 7)) {
            // Promouvoir le pion (par exemple, en reine par défaut)
            _board[toIndex] = Reine(piece.color, piece.x, piece.y);
          }
        }
      }

      // Réinitialise la sélection et les cases mises en surbrillance
      _selectedCell = null;
      _highlightedCells = [];

      // Change de joueur
      _changeJoueur();
    });
  }

bool _isPlayerTurn(Piece piece) {
  return (_joueur == "Joueur 1" && piece.color == Colors.white) ||
         (_joueur == "Joueur 2" && piece.color == Colors.black);
}

void _onPieceSelected(int index) {
  setState(() {
    if (_highlightedCells.contains(index)) {
      Piece? piece = _board[_selectedCell!];

      // Vérifie si le mouvement est un roque
      if (piece is Roi) {
        int diff = index - _selectedCell!;
        if (diff == 2) {
          // Petit roque
          if (Regles.petitRoque(_board, piece.color)) {
            _changeJoueur();
            return;
          }
        } else if (diff == -2) {
          // Grand roque
          if (Regles.grandRoque(_board, piece.color)) {
            _changeJoueur();
            return;
          }
        }
      }
      // Déplace la pièce vers une case mise en surbrillance
      _movePiece(_selectedCell!, index);
    } 
    else {
      // Désélectionne si on appuie ailleurs
      Piece? piece = _board[index];
      if (piece != null && _isPlayerTurn(piece)) {
        // Vérifie si c'est le tour du joueur actif
        _selectedCell = index;
        _highlightedCells = piece.getPossibleMoves(_board);

        // Ajoute les cases de roque si le roi est sélectionné
        if (piece is Roi) {
          if (Regles.petitRoquePossible(_board, piece.color)) {
            _highlightedCells.add(index + 2); // Case pour le petit roque
          }
          if (Regles.grandRoquePossible(_board, piece.color)) {
            _highlightedCells.add(index - 2); // Case pour le grand roque
          }
        }
      } else {
        // Désélectionne si ce n'est pas le tour du joueur
        _selectedCell = null;
        _highlightedCells = [];
      }
    }
  });
}




Widget _buildCell(int index, double cellSize,int indexJ1,int indexJ2) {
  bool isWhite = (index ~/ 8 % 2 == 0 && index % 8 % 2 == 0) || (index ~/ 8 % 2 == 1 && index % 8 % 2 == 1);
  Color baseColor = isWhite ?  plateaux[widget.indexPlateau][0] : plateaux[widget.indexPlateau][1];

  Color cellColor = _selectedCell == index
    ? Colors.blueAccent.withValues(alpha: 0.4)
    : (_highlightedCells.contains(index)
        ? Colors.yellowAccent.withValues(alpha: 0.4)
        : baseColor);

  BoxDecoration decoration = BoxDecoration(
    color: cellColor,
    border: _highlightedCells.contains(index)
        ? Border.all(color: Colors.yellowAccent, width: 1) // Bordure pour les déplacements possibles
        : null,
  );  

  return GestureDetector(
    onTap: () => _onPieceSelected(index),
    child: Container(
      width: cellSize,
      height: cellSize,
      decoration: decoration,
      child: Center(
        child: _board[index]?.buildPiece(cellSize * 0.75,indexJ1,indexJ2) ?? Container(),
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
                        child:WidgetTimer(timer, key: _timerJoueur2),
                      )
                    ],
                  ),
                ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(8, (i) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(8, (j) => _buildCell(i * 8 + j, cellSize,widget.indexJ1,widget.indexJ2)),
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
                    child: WidgetTimer(timer, key: _timerJoueur1),
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
