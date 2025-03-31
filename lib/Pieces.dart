import 'dart:math' as math;
import 'package:flutter/material.dart';

List<List<String>> pionsJ1=[
  ['assets/ChoixPions/Joueur1/PB.png', 'assets/ChoixPions/Joueur1/CP.png'],
  ['assets/ChoixPions/Joueur1/RB.png', 'assets/ChoixPions/Joueur1/RS.png'],
  ['assets/ChoixPions/Joueur1/DB.png', 'assets/ChoixPions/Joueur1/DA.png'],
  ['assets/ChoixPions/Joueur1/FB.png', 'assets/ChoixPions/Joueur1/FE.png'],
  ['assets/ChoixPions/Joueur1/TB.png', 'assets/ChoixPions/Joueur1/TG.png'],
  ['assets/ChoixPions/Joueur1/CB.png', 'assets/ChoixPions/Joueur1/CC.png']
  
];
List<List<String>> pionsJ2=[
  ['assets/ChoixPions/Joueur2/PN.png', 'assets/ChoixPions/Joueur2/CP.png'],
  ['assets/ChoixPions/Joueur2/RN.png', 'assets/ChoixPions/Joueur2/RS.png'],
  ['assets/ChoixPions/Joueur2/DN.png', 'assets/ChoixPions/Joueur2/DA.png'],
  ['assets/ChoixPions/Joueur2/FN.png', 'assets/ChoixPions/Joueur2/FE.png'],
  ['assets/ChoixPions/Joueur2/TN.png', 'assets/ChoixPions/Joueur2/TG.png'],
  ['assets/ChoixPions/Joueur2/CN.png', 'assets/ChoixPions/Joueur2/CC.png']
  
];

List<List<Color>> plateaux=[
  [const Color(0xFFEEEED2),const Color(0xFF769656)],
  [const Color(0xFFC69C6D),const Color(0xFF603813)],

  
];




abstract class Piece {
  final String name;
  final Color color;
  int x;
  int y;
  bool aBouge = false; // Indique si la pièce a déjà bougé

  

  Piece(this.name, this.color, this.x, this.y, {this.aBouge = false});

  Widget buildPiece(double size,int indexJ1,int indexJ2) {
    throw UnimplementedError('buildPiece() must be implemented in subclasses');
  }
  List<int> getPossibleMoves(List<Piece?> board);
  
}

class Roi extends Piece {
  Roi(Color color,int x,int y) : super("Roi", color,x,y);

  @override
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[1][indexJ1]
      : pionsJ2[1][indexJ2];
    return Image.asset(imagePath, width: size, height: size);
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
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[2][indexJ1]
      : pionsJ2[2][indexJ2];
    return Image.asset(imagePath, width: size, height: size);
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
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[4][indexJ1]
      : pionsJ2[4][indexJ2];
    return Image.asset(imagePath, width: size, height: size);
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
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[3][indexJ1]
      : pionsJ2[3][indexJ2];
    return Image.asset(imagePath, width: size, height: size);
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
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[5][indexJ1]
      : pionsJ2[5][indexJ2];
    return Image.asset(imagePath, width: size, height: size);
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
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[0][indexJ1]
      : pionsJ2[0][indexJ2];
    return Image.asset(imagePath, width: size, height: size);
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