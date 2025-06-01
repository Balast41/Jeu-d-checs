import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
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
      home: const MyHomePage(indexJ1: 0,indexJ2: 0,indexPlateau: 0,timerValue: 1000,),
    );
  }
}



class MyHomePage extends StatefulWidget {
  final int indexJ1;
  final int indexJ2;
  final int indexPlateau;
  final int timerValue;

  const MyHomePage({super.key, required this.indexJ1, required this.indexJ2,required this.indexPlateau,required this.timerValue,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<List> pionsJ1;
  late List<List> pionsJ2;
  late List<List<Color>> plateaux;
  List<Piece> piecesCapturees = [];

  late AudioPlayer _audioPlayer;

  void _playBackgroundMusic() async {
  await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Boucle la musique
  await _audioPlayer.play(AssetSource('musique/J.mp3'));} // Joue la musique


  final List<Piece?> _board = List.filled(64,null);
  String _joueur = "Joueur 1";

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
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();

pionsJ1=[
  ['assets/ChoixPions/Joueur1/PB.png', 'assets/ChoixPions/Joueur1/CP.png','assets/ChoixPions/Joueur1/PO.png','assets/ChoixPions/Joueur1/PA.png'],
  ['assets/ChoixPions/Joueur1/RB.png', 'assets/ChoixPions/Joueur1/RS.png','assets/ChoixPions/Joueur1/RO.png','assets/ChoixPions/Joueur1/RA.png'],
  ['assets/ChoixPions/Joueur1/DB.png', 'assets/ChoixPions/Joueur1/DA.png','assets/ChoixPions/Joueur1/DO.png','assets/ChoixPions/Joueur1/DAr.png'],
  ['assets/ChoixPions/Joueur1/FB.png', 'assets/ChoixPions/Joueur1/FE.png','assets/ChoixPions/Joueur1/FO.png','assets/ChoixPions/Joueur1/FA.png'],
  ['assets/ChoixPions/Joueur1/TB.png', 'assets/ChoixPions/Joueur1/TG.png','assets/ChoixPions/Joueur1/TO.png','assets/ChoixPions/Joueur1/TA.png'],
  ['assets/ChoixPions/Joueur1/CB.png', 'assets/ChoixPions/Joueur1/CC.png','assets/ChoixPions/Joueur1/CO.png','assets/ChoixPions/Joueur1/CA.png']
  
];

pionsJ2=[
  ['assets/ChoixPions/Joueur2/PN.png', 'assets/ChoixPions/Joueur2/CP.png','assets/ChoixPions/Joueur2/PO.png','assets/ChoixPions/Joueur2/PA.png'],
  ['assets/ChoixPions/Joueur2/RN.png', 'assets/ChoixPions/Joueur2/RS.png','assets/ChoixPions/Joueur2/RO.png','assets/ChoixPions/Joueur2/RA.png'],
  ['assets/ChoixPions/Joueur2/DN.png', 'assets/ChoixPions/Joueur2/DA.png','assets/ChoixPions/Joueur2/DO.png','assets/ChoixPions/Joueur2/DAr.png'],
  ['assets/ChoixPions/Joueur2/FN.png', 'assets/ChoixPions/Joueur2/FE.png','assets/ChoixPions/Joueur2/FO.png','assets/ChoixPions/Joueur2/FA.png'],
  ['assets/ChoixPions/Joueur2/TN.png', 'assets/ChoixPions/Joueur2/TG.png','assets/ChoixPions/Joueur2/TO.png','assets/ChoixPions/Joueur2/TA.png'],
  ['assets/ChoixPions/Joueur2/CN.png', 'assets/ChoixPions/Joueur2/CC.png','assets/ChoixPions/Joueur2/CO.png','assets/ChoixPions/Joueur2/CA.png']
];

plateaux=[
  [const Color(0xFFEEEED2),const Color(0xFF769656)],
  [const Color(0xFFC69C6D),const Color(0xFF603813)],
  [const Color(0xFFE7DBEE),const Color(0xFF987DB6)],
  [const Color(0xFFDADFE8),const Color(0xFF6D9FC9)],
  [const Color(0xFFEDF0BF),const Color(0xFFED7476)],
  [const Color(0xFFF1D9B4),const Color(0xFFB68664)]


  
];
  
  }

void _initializeBoard() {
  // Initialisation des pièces sur le plateau
  _board[0] = Tour(Colors.black, 2, 0, 0);
  _board[1] = Cavalier(Colors.black, 2, 1, 0);
  _board[2] = Fou(Colors.black, 2, 2, 0);
  _board[3] = Reine(Colors.black, 2, 3, 0);
  _board[4] = Roi(Colors.black, 2, 4, 0);
  _board[5] = Fou(Colors.black, 2, 5, 0);
  _board[6] = Cavalier(Colors.black, 2, 6, 0);
  _board[7] = Tour(Colors.black, 2, 7, 0);

  // Placement des pions noirs
  for (int i = 8; i < 16; i++) {
    _board[i] = Pion(Colors.black, 2, i % 8, 1);
  }

  // Placement des pions blancs
  for (int i = 48; i < 56; i++) {
    _board[i] = Pion(Colors.white, 1, i % 8, 6);
  }

  _board[56] = Tour(Colors.white, 1, 0, 7);
  _board[57] = Cavalier(Colors.white, 1, 1, 7);
  _board[58] = Fou(Colors.white, 1, 2, 7);
  _board[59] = Reine(Colors.white, 1, 3, 7);
  _board[60] = Roi(Colors.white, 1, 4, 7);
  _board[61] = Fou(Colors.white, 1, 5, 7);
  _board[62] = Cavalier(Colors.white, 1, 6, 7);
  _board[63] = Tour(Colors.white, 1, 7, 7);
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

  void verifierFinDePartie() {
    if (Regles.estEchecEtMat(_board, _joueur == "Joueur 1" ? 1 : 2)) {
      print("Échec et mat !");
      _finDePartie("Échec et mat !");
    } else if (Regles.estPat(_board, _joueur == "Joueur 1" ? 1 : 2)) {
      print("Pat !");
      _finDePartie("Pat !");
    } else if (Regles.estEnEchec(_board, _joueur == "Joueur 1" ? 1 : 2)) {
      print("Échec !");
      _afficherMessage("Échec !");
    }
  }

  void _finDePartie(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Fin de partie"),
          content: Text(message),
        );
      },
    );
  }

  void _afficherMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _movePiece(int fromIndex, int toIndex) {
    setState(() {
      Piece? piece = _board[fromIndex];
      if (piece != null) {
        // Vérifie si une pièce adverse est capturée
        if (_board[toIndex] != null) {
          piecesCapturees.add(_board[toIndex]!); // Ajoute la pièce capturée à la liste
        }

        // Déplace la pièce
        _board[toIndex] = piece;
        _board[fromIndex] = null;

        // Met à jour les coordonnées de la pièce
        piece.x = toIndex % 8;
        piece.y = toIndex ~/ 8;

        piece.aBouge = true; // Marque la pièce comme ayant bougé

        // Gère la promotion des pions
        if (piece is Pion) {
          if ((piece.player == 1 && piece.y == 0) || (piece.player == 2 && piece.y == 7)) {
            _demanderPromotion(toIndex);
          }
        }
      }

      if (piece is Roi) {
        // Blancs
        if (piece.player == 1 && fromIndex == 60 && toIndex == 62) {
          // Petit roque blanc
          _board[61] = _board[63];
          _board[63] = null;
          _board[61]?.x = 5;
          _board[61]?.y = 7;
          _board[61]?.aBouge = true;
        }
        if (piece.player == 1 && fromIndex == 60 && toIndex == 58) {
          // Grand roque blanc
          _board[59] = _board[56];
          _board[56] = null;
          _board[59]?.x = 3;
          _board[59]?.y = 7;
          _board[59]?.aBouge = true;
        }
        // Noirs
        if (piece.player == 2 && fromIndex == 4 && toIndex == 6) {
          // Petit roque noir
          _board[5] = _board[7];
          _board[7] = null;
          _board[5]?.x = 5;
          _board[5]?.y = 0;
          _board[5]?.aBouge = true;
        }
        if (piece.player == 2 && fromIndex == 4 && toIndex == 2) {
          // Grand roque noir
          _board[3] = _board[0];
          _board[0] = null;
          _board[3]?.x = 3;
          _board[3]?.y = 0;
          _board[3]?.aBouge = true;
        }
      }

      // Réinitialise la sélection et les cases mises en surbrillance
      _selectedCell = null;
      _highlightedCells = [];

      // Change de joueur
      _changeJoueur();

      // Vérifie les règles de fin de partie
      verifierFinDePartie();
    });
  }

  bool _isPlayerTurn(Piece piece) {
    return (_joueur == "Joueur 1" && piece.player == 1) ||
          (_joueur == "Joueur 2" && piece.player == 2);
  }

  void _demanderPromotion(int index) {
    final choix = ["Reine", "Tour", "Fou", "Cavalier"];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Promotion"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: choix
                .map((type) => ListTile(
                      title: Text(type),
                      onTap: () {
                        setState(() {
                          Regles.promotionPion(_board, index, type, _joueur == "Joueur 1" ? 1 : 2);
                        });
                        Navigator.of(context).pop();
                      },
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  int? getRoiEnEchecIndex(int joueur) {
    if (Regles.estEnEchec(_board, joueur)) {
      for (var piece in _board) {
        if (piece is Roi && piece.player == joueur) {
          return piece.x + piece.y * 8;
        }
      }
    }
    return null;
  }

  void _onPieceSelected(int index) {
    setState(() {
      if (_highlightedCells.contains(index)) {
        // Déplace la pièce vers une case mise en surbrillance
        Piece? piece = _board[_selectedCell!];

        // Sinon, déplace la pièce normalement
        _movePiece(_selectedCell!, index);
      } else {
        // Désélectionne si on appuie ailleurs
        Piece? piece = _board[index];
        if (piece != null && _isPlayerTurn(piece)) {
          // Vérifie si c'est le tour du joueur actif
          _selectedCell = index;
          List<int> coupsPossibles = piece.getPossibleMoves(_board);
          int joueur = _joueur == "Joueur 1" ? 1 : 2;
          _highlightedCells = coupsPossibles.where((coup) {
            // Simule le coup
            List<Piece?> copieBoard = _board.map((p) => p?.clone()).toList();
            Piece pieceClone = copieBoard[piece.x + piece.y * 8]!;
            pieceClone.x = coup % 8;
            pieceClone.y = (coup / 8).floor();
            copieBoard[coup] = pieceClone;
            copieBoard[piece.x + piece.y * 8] = null;
            // Vérifie si le roi est toujours en échec après ce coup
            return !Regles.estEnEchec(copieBoard, joueur);
          }).toList();

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
  
  int? roiEchecIndex = getRoiEnEchecIndex(_joueur == "Joueur 1" ? 1 : 2);

  Color cellColor;
  if (index == roiEchecIndex) {
    cellColor = Colors.redAccent.withValues(alpha: 0.7); // Case du roi en échec
  } else if (_selectedCell == index) {
    cellColor = Colors.blueAccent.withValues(alpha: 0.4);
  } else if (_highlightedCells.contains(index)) {
    cellColor = Colors.yellowAccent.withValues(alpha: 0.4);
  } else {
    cellColor = baseColor;
  }

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
                        child:WidgetTimer(widget.timerValue, key: _timerJoueur2),
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
                    child: WidgetTimer(widget.timerValue, key: _timerJoueur1),
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
