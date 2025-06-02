import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'Pieces.dart';

class Regles {
  static bool estEnEchec(List<Piece?> board, int joueurActuel) {
    Piece? roi = board.firstWhere(
      (piece) => piece is Roi && piece.player == joueurActuel,
      orElse: () => null,
    );

    if (roi == null) return false; // Pas de roi trouvé (cas improbable)

    return estCaseAttaquee(board, roi.x + roi.y * 8, joueurActuel);
  }

  static bool estEchecEtMat(List<Piece?> board, int joueurActuel) {
    if (!estEnEchec(board, joueurActuel)) {
      return false; // Pas en échec, donc pas d'échec et mat
    }

    // Vérifier si le joueur peut effectuer un coup légal pour sortir de l'échec
    for (var piece in board) {
      if (piece != null && piece.player == joueurActuel) {
        List<int> coupsPossibles = piece.getPossibleMoves(board);

        for (var coup in coupsPossibles) {
          // Simuler le coup
          List<Piece?> copieBoard = board.map((p) => p?.clone()).toList();
          Piece pieceClone = copieBoard[piece.x + piece.y * 8]!;
          pieceClone.x = coup % 8;
          pieceClone.y = (coup / 8).floor();
          copieBoard[coup] = pieceClone;
          copieBoard[piece.x + piece.y * 8] = null;

          // Vérifier si le roi est toujours en échec après ce coup
          if (!estEnEchec(copieBoard, joueurActuel)) {
            return false;
          }
        }
      }
    }

    return true; // Aucun coup légal pour sortir de l'échec, échec et mat
  }

// ...existing code...
  static bool estPat(List<Piece?> board, int joueurActuel) {
    if (estEnEchec(board, joueurActuel)) {
      return false; // Pas un pat si le joueur est en échec
    }

    // Vérifier si le joueur peut effectuer un coup légal
    for (var piece in board) {
      if (piece != null && piece.player == joueurActuel) {
        List<int> coupsPossibles = piece.getPossibleMoves(board);
        for (var coup in coupsPossibles) {
            // Simuler le coup
            List<Piece?> copieBoard = board.map((p) => p?.clone()).toList();
            Piece pieceClone = copieBoard[piece.x + piece.y * 8]!;
            pieceClone.x = coup % 8;
            pieceClone.y = (coup / 8).floor();
            copieBoard[coup] = pieceClone;
            copieBoard[piece.x + piece.y * 8] = null;

            // Vérifier si le roi est toujours en échec après ce coup
            if (!estEnEchec(copieBoard, joueurActuel)) {
              return false;
            }
          }
      }
    }

    return true; // Aucun coup légal, pat
  }
// ...existing code...

  static void promotionPion(List<Piece?> board, int index, String typePiece, int player) {
    Piece? pion = board[index];
    if (pion != null && pion is Pion) {
      if ((pion.player == 1 && pion.y == 0) || (pion.player == 2 && pion.y == 7)) {
        switch (typePiece) {
          case "Reine":
            board[index] = Reine(pion.color, pion.player, pion.x, pion.y);
            print("Reine ouais ouais");
            break;
          case "Tour":
            board[index] = Tour(pion.color, pion.player, pion.x, pion.y);
            print("Tour ouais ouais");
            break;
          case "Fou":
            board[index] = Fou(pion.color, pion.player, pion.x, pion.y);
            print("Fou ouais ouais");
            break;
          case "Cavalier":
            board[index] = Cavalier(pion.color, pion.player, pion.x, pion.y);
            print("Cavalier ouais ouais");
            break;
        }
      }
    }
  }

  static List<int> getRoquesPossibles(List<Piece?> board, int joueur) {
    List<int> roques = [];
    int ligne = (joueur == 1) ? 7 : 0; // <-- Correction ici
    int roiIndex = 4 + ligne * 8;
    Piece? roi = board[roiIndex];
    if (roi is Roi && !roi.aBouge && !estEnEchec(board, joueur)) {
      // Petit roque
      int tourPetitIndex = 7 + ligne * 8;
      Piece? tourPetit = board[tourPetitIndex];
      if (tourPetit is Tour && !tourPetit.aBouge &&
          board[5 + ligne * 8] == null &&
          board[6 + ligne * 8] == null &&
          !estCaseAttaquee(board, 5 + ligne * 8, joueur) &&
          !estCaseAttaquee(board, 6 + ligne * 8, joueur)) {
        roques.add(6 + ligne * 8);
      }
      // Grand roque
      int tourGrandIndex = 0 + ligne * 8;
      Piece? tourGrand = board[tourGrandIndex];
      if (tourGrand is Tour && !tourGrand.aBouge &&
          board[1 + ligne * 8] == null &&
          board[2 + ligne * 8] == null &&
          board[3 + ligne * 8] == null &&
          !estCaseAttaquee(board, 2 + ligne * 8, joueur) &&
          !estCaseAttaquee(board, 3 + ligne * 8, joueur)) {
        roques.add(2 + ligne * 8);
      }
    }
    return roques;
  }


  static bool estCaseAttaquee(List<Piece?> board, int caseIndex, int joueurActuel) {
    for (var piece in board) {
      if (piece != null && piece.player != joueurActuel) {
        if (piece.getPossibleMoves(board, ignoreKingSafety: true).contains(caseIndex)) {
          return true;
        }
      }
    }
    return false;
  }
}