import 'package:chess_game_by_mitch/components/piece.dart';
import 'package:chess_game_by_mitch/components/square.dart';
import 'package:chess_game_by_mitch/res/constant/app_colors.dart';
import 'package:chess_game_by_mitch/res/helper.dart';
import 'package:flutter/material.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // A 2-dimesional list represeting the chessboard,
  // with each position possibly containe a chess piece,
  late List<List<ChessPiece?>> board;

  // The currently selected piece on the chess board,
  // If no piece is selecte, this is null.
  ChessPiece? selectedPiece;

  // The row index of the selected piece
  // Default value of -1 indicated no piece is currently selected.
  int selectedRow = -1;

  // The col index of the selected piece
  // Default value of -1 indicated no piece is currently selected.
  int selectedCol = -1;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

// INITIALIZE BOARD
  void _initializeBoard() {
    List<List<ChessPiece?>> newBoard =
        List.generate(8, (index) => List.generate(8, (index) => null));

    const String pawnImg = "assets/pawn.png";
    const String rookImg = "assets/rook.png";
    const String knightImg = "assets/knight.png";
    const String bishopImg = "assets/bishop.png";
    const String queenImg = "assets/queen.png";
    const String kingImg = "assets/king.png";

    // Place pawns
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: true,
        img: pawnImg,
      );
      newBoard[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: false,
        img: pawnImg,
      );
    }

    // Place rooks
    newBoard[0][0] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: true,
      img: rookImg,
    );
    newBoard[0][7] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: true,
      img: rookImg,
    );
    newBoard[7][0] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: false,
      img: rookImg,
    );
    newBoard[7][7] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: false,
      img: rookImg,
    );

    // Place knights
    newBoard[0][1] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: true,
      img: knightImg,
    );
    newBoard[0][6] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: true,
      img: knightImg,
    );
    newBoard[7][1] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: false,
      img: knightImg,
    );
    newBoard[7][6] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: false,
      img: knightImg,
    );

    // Place bishops
    newBoard[0][2] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: true,
      img: bishopImg,
    );
    newBoard[0][5] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: true,
      img: bishopImg,
    );
    newBoard[7][2] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: false,
      img: bishopImg,
    );
    newBoard[7][5] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: false,
      img: bishopImg,
    );

    // Place queen
    newBoard[0][4] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: true,
      img: queenImg,
    );
    newBoard[7][3] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: false,
      img: queenImg,
    );

    // Place king
    newBoard[0][3] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: true,
      img: kingImg,
    );
    newBoard[7][4] = ChessPiece(
      type: ChessPieceType.pawn,
      isWhite: false,
      img: kingImg,
    );

    board = newBoard;
  }

  selectPiece(int row, int col) {
    setState(() {
      selectedRow = row;
      selectedCol = col;
    });
  }

  @override
  Widget build(BuildContext context) {
    _initializeBoard();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 120),
          Expanded(
            child: GridView.builder(
                itemCount: 8 * 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ 8;
                  int col = index % 8;
                  bool isSelect = row == selectedRow && col == selectedCol;
                  return Square(
                    isWhite: Helper.isWhite(index),
                    piece: board[row][col],
                    isSelected: isSelect,
                    onTap: () => selectPiece(row, col),
                  );
                }),
          ),
        ],
      ),
    );
  }
}


/*
# Steps to create chess
 1. Desgin game borad 
 2. Place chess pieces
 3. Select piece
 4. Define logic of each pieces
 5. Dead piece
 6. Is kind is Checked?

*/
