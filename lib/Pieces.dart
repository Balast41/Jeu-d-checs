import 'dart:math' as math;
import 'package:flutter/material.dart';

abstract class Piece {
  final String name;
  final Color color;
  final int player;
  int x;
  int y;
  bool aBouge = false; // Indique si la pièce a déjà bougé

  

  Piece(this.name, this.color, this.player, this.x, this.y, {this.aBouge = false});

  Widget buildPiece(double size);
  List<int> getPossibleMoves(List<Piece?> board);
  
}

class Roi extends Piece {
  Roi(Color color, int player, int x,int y) : super("Roi", color, player, x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? pionsJ1[1][indexJ1]
      : pionsJ2[1][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0, // Rotation de 180° pour les pièces du joueur 2
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
  Reine(Color color, int player, int x,int y) : super("Reine", color, player, x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? pionsJ1[2][indexJ1]
      : pionsJ2[2][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0, // Rotation de 180° pour les pièces du joueur 2
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
  Tour(Color color, int player, int x,int y) : super("Tour", color, player, x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? pionsJ1[4][indexJ1]
      : pionsJ2[4][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0, // Rotation de 180° pour les pièces du joueur 2
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
  Fou(Color color, int player, int x,int y) : super("Fou", color, player, x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? pionsJ1[3][indexJ1]
      : pionsJ2[3][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0, // Rotation de 180° pour les pièces du joueur 2
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
  Cavalier(Color color, int player, int x,int y) : super("Cavalier", color, player, x,y);

  @override
  Widget buildPiece(double size) {
      String imagePath = color == Colors.white
      ? pionsJ1[5][indexJ1]
      : pionsJ2[5][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0, // Rotation de 180° pour les pièces du joueur 2
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
  Pion(Color color, int player, int x,int y) : super("Pion", color, player, x,y);

  @override
  Widget buildPiece(double size,int indexJ1,int indexJ2) {
      String imagePath = color == Colors.white
      ? pionsJ1[0][indexJ1]
      : pionsJ2[0][indexJ2];
    return Transform.rotate(
      angle: player == 2 ? math.pi : 0, // Rotation de 180° pour les pièces du joueur 2
      child: Image.asset(imagePath, width: size, height: size),
    );
  }
    @override
  List<int> getPossibleMoves(List<Piece?> board) {
    List<int> moves = [];
    int direction = color == Colors.white ? -1 : 1; // Direction de mouvement
    int startRow = color == Colors.white ? 6 : 1; // Ligne de départ pour le double pas

    // Mouvement simple
    int newX = x;
    int newY = y + direction;
    if (newY >= 0 && newY < 8) {
      int index = newY * 8 + newX;
      if (board[index] == null) {
        moves.add(index);
      }
    }

    // Double pas
    if (y == startRow) {
      newY += direction;
      if (newY >= 0 && newY < 8) {
        int index = newY * 8 + newX;
        if (board[index] == null) {
          moves.add(index);
        }
      }
    }

    // Prise en diagonale
    for (int dx = -1; dx <= 1; dx += 2) {
      newX = x + dx;
      newY = y + direction;
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