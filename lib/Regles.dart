import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'Pieces.dart';

class Regles {
  // Vérifie si la partie est terminée (échec et mat ou pat)
  static bool estFinDePartie(List<Piece?> board, Color joueurActuel) {
    for (var piece in board) {
      if (piece != null && piece.color == joueurActuel) {
        if (piece.getPossibleMoves(board).isNotEmpty) {
          return false; // Il reste des coups possibles
        }
      }
    }
    return true; // Aucun coup possible, fin de partie
  }

  // Gère la promotion des pions
  static void promotionPion(List<Piece?> board, int index, String typePiece) {
    Piece? pion = board[index];
    if (pion != null && pion is Pion) {
      if ((pion.color == Colors.white && pion.y == 0) ||
          (pion.color == Colors.black && pion.y == 7)) {
        // Promotion
        switch (typePiece) {
          case "Reine":
            board[index] = Reine(pion.color, pion.player, pion.x, pion.y);
            break;
          case "Tour":
            board[index] = Tour(pion.color, pion.player, pion.x, pion.y);
            break;
          case "Fou":
            board[index] = Fou(pion.color, pion.player, pion.x, pion.y);
            break;
          case "Cavalier":
            board[index] = Cavalier(pion.color, pion.player, pion.x, pion.y);
            break;
        }
      }
    }
  }

  // Vérifie et effectue le petit roque
  static bool petitRoque(List<Piece?> board, Color joueurActuel) {
    // Vérifie les conditions pour le petit roque
    int roiIndex = joueurActuel == Colors.white ? 60 : 4;
    int tourIndex = joueurActuel == Colors.white ? 63 : 7;

    Piece? roi = board[roiIndex];
    Piece? tour = board[tourIndex];

    if (roi is Roi && tour is Tour && !roi.aBouge && !tour.aBouge) {
      // Vérifie que les cases entre le roi et la tour sont vides
      int direction = joueurActuel == Colors.white ? 1 : -1;
      for (int i = 1; i <= 2; i++) {
        if (board[roiIndex + i * direction] != null) {
          return false; // Une case est occupée
        }
      }

      // Effectue le petit roque
      board[roiIndex] = null;
      board[tourIndex] = null;
      board[roiIndex + 2 * direction] = Roi(joueurActuel, roi.player, roi.x + 2, roi.y);
      board[roiIndex + 1 * direction] = Tour(joueurActuel, tour.player, tour.x - 2, tour.y);
      return true;
    }
    return false;
  }

  // Vérifie et effectue le grand roque
  static bool grandRoque(List<Piece?> board, Color joueurActuel) {
    // Vérifie les conditions pour le grand roque
    int roiIndex = joueurActuel == Colors.white ? 60 : 4;
    int tourIndex = joueurActuel == Colors.white ? 56 : 0;

    Piece? roi = board[roiIndex];
    Piece? tour = board[tourIndex];

    if (roi is Roi && tour is Tour && !roi.aBouge && !tour.aBouge) {
      // Vérifie que les cases entre le roi et la tour sont vides
      int direction = joueurActuel == Colors.white ? -1 : 1;
      for (int i = 1; i <= 3; i++) {
        if (board[roiIndex + i * direction] != null) {
          return false; // Une case est occupée
        }
      }

      // Effectue le grand roque
      board[roiIndex] = null;
      board[tourIndex] = null;
      board[roiIndex + 2 * direction] = Roi(joueurActuel, roi.player, roi.x + 2, roi.y);
      board[roiIndex + 1 * direction] = Tour(joueurActuel, tour.player, tour.x - 3, tour.y);
      return true;
    }
    return false;
  }

  static bool petitRoquePossible(List<Piece?> board, Color joueurActuel) {
    int roiIndex = joueurActuel == Colors.white ? 60 : 4;
    int tourIndex = joueurActuel == Colors.white ? 63 : 7;

    Piece? roi = board[roiIndex];
    Piece? tour = board[tourIndex];

    if (roi is Roi && tour is Tour && !roi.aBouge && !tour.aBouge) {
      // Vérifie que les cases entre le roi et la tour sont vides
      for (int i = 1; i <= 2; i++) {
        if (board[roiIndex + i] != null) {
          return false;
        }
      }

      // Vérifie que le roi ne traverse pas ou ne termine sur une case attaquée
      for (int i = 0; i <= 2; i++) {
        if (estCaseAttaquee(board, roiIndex + i, joueurActuel)) {
          return false;
        }
      }

      return true;
    }

    return false;
  }

  static bool grandRoquePossible(List<Piece?> board, Color joueurActuel) {
    int roiIndex = joueurActuel == Colors.white ? 60 : 4;
    int tourIndex = joueurActuel == Colors.white ? 56 : 0;

    Piece? roi = board[roiIndex];
    Piece? tour = board[tourIndex];

    if (roi is Roi && tour is Tour && !roi.aBouge && !tour.aBouge) {
      // Vérifie que les cases entre le roi et la tour sont vides
      for (int i = 1; i <= 3; i++) {
        if (board[roiIndex - i] != null) {
          return false;
        }
      }

      // Vérifie que le roi ne traverse pas ou ne termine sur une case attaquée
      for (int i = 0; i <= 2; i++) {
        if (estCaseAttaquee(board, roiIndex - i, joueurActuel)) {
          return false;
        }
      }

      return true;
    }

    return false;
  }

  static bool estCaseAttaquee(List<Piece?> board, int caseIndex, Color joueurActuel) {
    for (var piece in board) {
      if (piece != null && piece.color != joueurActuel) {
        if (piece.getPossibleMoves(board).contains(caseIndex)) {
          return true; // La case est attaquée
        }
      }
    }
    return false;
  }
}