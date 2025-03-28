import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'widget_timer.dart';

abstract class Piece {
  final String name;
  final Color color;
  int x;
  int y;
  

  Piece(this.name, this.color, this.x, this.y);

  Widget buildPiece(double size);
  List<int> getPossibleMoves(List<Piece?> board);
  
}

class Roi extends Piece {
  Roi(Color color,int x,int y) : super("Roi", color,x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? 'assets/images/RB.png'
      : 'assets/images/RN.png';
    
    return Transform.rotate(
      angle: color == Colors.black ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size),
    );
  }

  @override
  List<int> getPossibleMoves(List<Piece?> board){
    List<int>moves=[];
    List<List<int>> directions = [
      [1, 1],[1, 0],[1, -1],[0, 1],
      [0, -1],[-1, 1],[-1, 0],[-1, -1],
    ];

    for(var dir in directions){
      int newX=x+dir[0];
      int newY=y+dir[1];
      if(newX>=0 && newX<8 && newY>=0 && newY<8){
        int index=newX+newY*8;
        if(board[index]==null || board[index]!.color!=color){
          moves.add(index);
        }
      }
    }
    return moves;
  }
}

class Reine extends Piece {
  Reine(Color color,int x,int y) : super("Reine", color,x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? 'assets/images/DB.png'
      : 'assets/images/DN.png';

    return Transform.rotate(
      angle: color == Colors.black ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size),
    );
  }
    @override
  List<int> getPossibleMoves(List<Piece?> board) {
    List<int> moves = [];
    List<List<int>> directions = [
      [1, 0], [-1, 0], [0, 1], [0, -1], // Horizontal et vertical
      [1, 1], [-1, -1], [1, -1], [-1, 1] // Diagonales
    ];

    for (var dir in directions) {
      int newX = x;
      int newY = y;
      while (true) {
        newX += dir[0];
        newY += dir[1];
        if (newX < 0 || newX >= 8 || newY < 0 || newY >= 8) break;

        int index = newY * 8 + newX;
        if (board[index] == null) {
          moves.add(index);
        } else {
          if (board[index]?.color != color) {
            moves.add(index);
          }
          break;
        }
      }
    }
    return moves;
  }
}

class Tour extends Piece {
  Tour(Color color,int x,int y) : super("Tour", color,x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? 'assets/images/TB.png'
      : 'assets/images/TN.png';

    return Transform.rotate(
      angle: color == Colors.black ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size),
    );
  }
    @override
  List<int> getPossibleMoves(List<Piece?> board) {
    List<int> moves = [];
    List<List<int>> directions = [
      [1, 0], [-1, 0], [0, 1], [0, -1] // Horizontal et vertical
    ];

    for (var dir in directions) {
      int newX = x;
      int newY = y;
      while (true) {
        newX += dir[0];
        newY += dir[1];
        if (newX < 0 || newX >= 8 || newY < 0 || newY >= 8) break;

        int index = newY * 8 + newX;
        if (board[index] == null) {
          moves.add(index);
        } else {
          if (board[index]?.color != color) {
            moves.add(index);
          }
          break;
        }
      }
    }
    return moves;
  }
}

class Fou extends Piece {
  Fou(Color color,int x,int y) : super("Fou", color,x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? 'assets/images/FB.png'
      : 'assets/images/FN.png';

    return Transform.rotate(
      angle: color == Colors.black ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size),
    );
  }
    @override
  List<int> getPossibleMoves(List<Piece?> board) {
    List<int> moves = [];
    List<List<int>> directions = [
      [1, 1], [-1, -1], [1, -1], [-1, 1] // Diagonales
    ];

    for (var dir in directions) {
      int newX = x;
      int newY = y;
      while (true) {
        newX += dir[0];
        newY += dir[1];
        if (newX < 0 || newX >= 8 || newY < 0 || newY >= 8) break;

        int index = newY * 8 + newX;
        if (board[index] == null) {
          moves.add(index);
        } else {
          if (board[index]?.color != color) {
            moves.add(index);
          }
          break;
        }
      }
    }
    return moves;
  }
}

class Cavalier extends Piece {
  Cavalier(Color color,int x,int y) : super("Cavalier", color,x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? 'assets/images/CB.png'
      : 'assets/images/CN.png';

    return Transform.rotate(
      angle: color == Colors.black ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size),
    );
  }
    @override
  List<int> getPossibleMoves(List<Piece?> board) {
    List<int> moves = [];
    List<List<int>> jumps = [
      [2, 1], [2, -1], [-2, 1], [-2, -1],
      [1, 2], [1, -2], [-1, 2], [-1, -2]
    ];

    for (var jump in jumps) {
      int newX = x + jump[0];
      int newY = y + jump[1];
      if (newX >= 0 && newX < 8 && newY >= 0 && newY < 8) {
        int index = newY * 8 + newX;
        if (board[index] == null || board[index]?.color != color) {
          moves.add(index);
        }
      }
    }
    return moves;
  }
}

class Pion extends Piece {
  Pion(Color color,int x,int y) : super("Pion", color,x,y);

  @override
  Widget buildPiece(double size) {
    String imagePath = color == Colors.white
      ? 'assets/images/PB.png'
      : 'assets/images/PN.png';
    return Transform.rotate(
      angle: color == Colors.black ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size),
    );
  }
    @override
  List<int> getPossibleMoves(List<Piece?> board) {
    List<int> moves = [];
    int direction = color == Colors.white ? -1 : 1;

    // Avancer d'une case
    int forwardIndex = (y + direction) * 8 + x;
    if (board[forwardIndex] == null) {
      moves.add(forwardIndex);

      // Avancer de deux cases au premier coup
      if ((color == Colors.white && y == 6) || (color == Colors.black && y == 1)) {
        int doubleForwardIndex = (y + 2 * direction) * 8 + x;
        if (board[doubleForwardIndex] == null) {
          moves.add(doubleForwardIndex);
        }
      }
    }

    // Capturer en diagonale
    for (int dx in [-1, 1]) {
      int newX = x + dx;
      int newY = y + direction;
      if (newX >= 0 && newX < 8 && newY >= 0 && newY < 8) {
        int index = newY * 8 + newX;
        if (board[index] != null && board[index]?.color != color) {
          moves.add(index);
        }
      }
    }

    return moves;
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
    if (_selectedCell == null) {
      // Sélectionne une pièce
      Piece? piece = _board[index];
      if (piece != null && _isPlayerTurn(piece)) {
        // Vérifie si c'est le tour du joueur actif
        _selectedCell = index;
        _highlightedCells = piece.getPossibleMoves(_board);
      } else {
        // Désélectionne si ce n'est pas le tour du joueur
        _selectedCell = null;
        _highlightedCells = [];
      }
    } else if (_highlightedCells.contains(index)) {
      // Déplace la pièce vers une case mise en surbrillance
      _movePiece(_selectedCell!, index);
    } else {
      // Désélectionne si on appuie ailleurs
      _selectedCell = null;
      _highlightedCells = [];
    }
  });
}




Widget _buildCell(int index, double cellSize) {
  bool isWhite = (index ~/ 8 % 2 == 0 && index % 8 % 2 == 0) || (index ~/ 8 % 2 == 1 && index % 8 % 2 == 1);
  Color baseColor = isWhite ? const Color(0xFFEEEED2) : const Color(0xFF769656);

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
                        child: WidgetTimer(timer, key: _timerJoueur2),
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
