import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'Regles.dart';

List<List<String>> pionsJ1=[
  ['assets/ChoixPions/Joueur1/PB.png', 'assets/ChoixPions/Joueur1/CP.png','assets/ChoixPions/Joueur1/PO.png','assets/ChoixPions/Joueur1/PA.png','assets/ChoixPions/Joueur1/PCR.png'],
  ['assets/ChoixPions/Joueur1/RB.png', 'assets/ChoixPions/Joueur1/RS.png','assets/ChoixPions/Joueur1/RO.png','assets/ChoixPions/Joueur1/RA.png','assets/ChoixPions/Joueur1/RCR.png'],
  ['assets/ChoixPions/Joueur1/DB.png', 'assets/ChoixPions/Joueur1/DA.png','assets/ChoixPions/Joueur1/DO.png','assets/ChoixPions/Joueur1/DAr.png','assets/ChoixPions/Joueur1/DCR.png'],
  ['assets/ChoixPions/Joueur1/FB.png', 'assets/ChoixPions/Joueur1/FE.png','assets/ChoixPions/Joueur1/FO.png','assets/ChoixPions/Joueur1/FA.png','assets/ChoixPions/Joueur1/FCR.png'],
  ['assets/ChoixPions/Joueur1/TB.png', 'assets/ChoixPions/Joueur1/TG.png','assets/ChoixPions/Joueur1/TO.png','assets/ChoixPions/Joueur1/TA.png','assets/ChoixPions/Joueur1/TCR.png'],
  ['assets/ChoixPions/Joueur1/CB.png', 'assets/ChoixPions/Joueur1/CC.png','assets/ChoixPions/Joueur1/CO.png','assets/ChoixPions/Joueur1/CA.png','assets/ChoixPions/Joueur1/CCR.png']
  
];
List<List<String>> pionsJ2=[
  ['assets/ChoixPions/Joueur2/PN.png', 'assets/ChoixPions/Joueur2/CP.png','assets/ChoixPions/Joueur2/PO.png','assets/ChoixPions/Joueur2/PA.png','assets/ChoixPions/Joueur2/PCR.png'],
  ['assets/ChoixPions/Joueur2/RN.png', 'assets/ChoixPions/Joueur2/RS.png','assets/ChoixPions/Joueur2/RO.png','assets/ChoixPions/Joueur2/RA.png','assets/ChoixPions/Joueur2/RCR.png'],
  ['assets/ChoixPions/Joueur2/DN.png', 'assets/ChoixPions/Joueur2/DA.png','assets/ChoixPions/Joueur2/DO.png','assets/ChoixPions/Joueur2/DAr.png','assets/ChoixPions/Joueur2/DCR.png'],
  ['assets/ChoixPions/Joueur2/FN.png', 'assets/ChoixPions/Joueur2/FE.png','assets/ChoixPions/Joueur2/FO.png','assets/ChoixPions/Joueur2/FA.png','assets/ChoixPions/Joueur2/FCR.png'],
  ['assets/ChoixPions/Joueur2/TN.png', 'assets/ChoixPions/Joueur2/TG.png','assets/ChoixPions/Joueur2/TO.png','assets/ChoixPions/Joueur2/TA.png','assets/ChoixPions/Joueur2/TCR.png'],
  ['assets/ChoixPions/Joueur2/CN.png', 'assets/ChoixPions/Joueur2/CC.png','assets/ChoixPions/Joueur2/CO.png','assets/ChoixPions/Joueur2/CA.png','assets/ChoixPions/Joueur2/CCR.png']

];

List<List<Color>> plateaux=[
  [const Color(0xFFEEEED2),const Color(0xFF769656)],
  [const Color(0xFFC69C6D),const Color(0xFF603813)],
  [const Color(0xFFE7DBEE),const Color(0xFF987DB6)],
  [const Color(0xFFDADFE8),const Color(0xFF6D9FC9)],
  [const Color(0xFFEDF0BF),const Color(0xFFED7476)],
  [const Color(0xFFF1D9B4),const Color(0xFFB68664)]

  
];




abstract class Piece {
  final String name;
  final Color color;
  final int player;
  int x;
  int y;
  bool aBouge = false; // Indique si la pièce a déjà bougé

  

  Piece(this.name, this.color, this.player, this.x, this.y, {this.aBouge = false});

  Widget buildPiece(double size,int indexJ1,int indexJ2);

  List<int> getPossibleMoves(List<Piece?> board, {bool ignoreKingSafety = false});
  
  Piece clone();
}

class Roi extends Piece {
  Roi(Color color, int player, int x, int y, {bool aBouge = false}) : super("Roi", color, player, x, y, aBouge: aBouge);

  @override
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[1][indexJ1]
      : pionsJ2[1][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size)
    );
  }

  @override
  List<int> getPossibleMoves(List<Piece?> board, {bool ignoreKingSafety = false}) {
    List<int> moves = [];
    List<List<int>> directions = [
      [1, 1], [1, 0], [1, -1], [0, 1],
      [0, -1], [-1, 1], [-1, 0], [-1, -1],
    ];

    for (var dir in directions) {
      int newX = x + dir[0];
      int newY = y + dir[1];
      if (newX >= 0 && newX < 8 && newY >= 0 && newY < 8) {
        int index = newY * 8 + newX;
        if (board[index] == null || board[index]?.player != player) {
          if (!ignoreKingSafety) {
            // Simulation du déplacement
            List<Piece?> copieBoard = List<Piece?>.from(board);
            copieBoard[index] = Roi(color, player, newX, newY);
            copieBoard[x + y * 8] = null;
            // Vérifie que le roi ne serait pas en échec sur cette case
            if (!Regles.estCaseAttaquee(copieBoard, index, player)) {
              moves.add(index);
            }
          } else {
            moves.add(index);
          }
        }
      }
    }
    if (!ignoreKingSafety) {
      moves.addAll(Regles.getRoquesPossibles(board, player));
    }
    return moves;
  }

  @override
  Piece clone() => Roi(color, player, x, y, aBouge: aBouge);
}

class Reine extends Piece {
  Reine(Color color, int player, int x, int y, {bool aBouge = false}) : super("Reine", color, player, x, y, aBouge: aBouge);

  @override
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[2][indexJ1]
      : pionsJ2[2][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size)
    );
  }
    @override
  List<int> getPossibleMoves(List<Piece?> board, {bool ignoreKingSafety = false}) {
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

  @override
  Piece clone() => Reine(color, player, x, y, aBouge: aBouge);
}

class Tour extends Piece {
  Tour(Color color, int player, int x, int y, {bool aBouge = false}) : super("Tour", color, player, x, y, aBouge: aBouge);

  @override
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[4][indexJ1]
      : pionsJ2[4][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size)
    );
  }
    @override
  List<int> getPossibleMoves(List<Piece?> board, {bool ignoreKingSafety = false}) {
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

  @override
  Piece clone() => Tour(color, player, x, y, aBouge: aBouge);
}

class Fou extends Piece {
  Fou(Color color, int player, int x, int y, {bool aBouge = false}) : super("Fou", color, player, x, y, aBouge: aBouge);

  @override
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[3][indexJ1]
      : pionsJ2[3][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size)
    );
  }
    @override
  List<int> getPossibleMoves(List<Piece?> board, {bool ignoreKingSafety = false}) {
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

  @override
  Piece clone() => Fou(color, player, x, y, aBouge: aBouge);
}

class Cavalier extends Piece {
  Cavalier(Color color, int player, int x, int y, {bool aBouge = false}) : super("Cavalier", color, player, x, y, aBouge: aBouge);

  @override
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[5][indexJ1]
      : pionsJ2[5][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size)
    );
  }
    @override
  List<int> getPossibleMoves(List<Piece?> board, {bool ignoreKingSafety = false}) {
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

  @override
  Piece clone() => Cavalier(color, player, x, y, aBouge: aBouge);
}

class Pion extends Piece {
  Pion(Color color, int player, int x, int y, {bool aBouge = false}) : super("Pion", color, player, x, y, aBouge: aBouge);

  @override
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[0][indexJ1]
      : pionsJ2[0][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0,
      child: Image.asset(imagePath, width: size, height: size)
    );
  }
    @override
  List<int> getPossibleMoves(List<Piece?> board, {bool ignoreKingSafety = false}) {
    List<int> moves = [];
    int direction = color == Colors.white ? -1 : 1;

    // Avancer d'une case
    int forwardIndex = (y + direction) * 8 + x;
    if (forwardIndex >= 0 && forwardIndex < 64) {
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

  @override
  Piece clone() => Pion(color, player, x, y, aBouge: aBouge);
}