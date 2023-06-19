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

  List<List<int>> validMoves = [];

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
        isWhite: false,
        img: pawnImg,
      );
      newBoard[6][i] = ChessPiece(
        type: ChessPieceType.pawn,
        isWhite: true,
        img: pawnImg,
      );
    }

    // Place rooks
    newBoard[0][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      img: rookImg,
    );
    newBoard[0][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: false,
      img: rookImg,
    );
    newBoard[7][0] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      img: rookImg,
    );
    newBoard[7][7] = ChessPiece(
      type: ChessPieceType.rook,
      isWhite: true,
      img: rookImg,
    );

    // Place knights
    newBoard[0][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      img: knightImg,
    );
    newBoard[0][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: false,
      img: knightImg,
    );
    newBoard[7][1] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      img: knightImg,
    );
    newBoard[7][6] = ChessPiece(
      type: ChessPieceType.knight,
      isWhite: true,
      img: knightImg,
    );

    // Place bishops
    newBoard[0][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      img: bishopImg,
    );
    newBoard[0][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: false,
      img: bishopImg,
    );
    newBoard[7][2] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      img: bishopImg,
    );
    newBoard[7][5] = ChessPiece(
      type: ChessPieceType.bishop,
      isWhite: true,
      img: bishopImg,
    );

    // Place queen
    newBoard[0][4] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: false,
      img: queenImg,
    );
    newBoard[7][3] = ChessPiece(
      type: ChessPieceType.queen,
      isWhite: true,
      img: queenImg,
    );

    // Place king
    newBoard[0][3] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: false,
      img: kingImg,
    );
    newBoard[7][4] = ChessPiece(
      type: ChessPieceType.king,
      isWhite: true,
      img: kingImg,
    );

    board = newBoard;
  }

// USER SELECTED A PIECE
  void selectPiece(int row, int col) {
    setState(() {
      // no piece has been selected yet, this is the first selection
      if (selectedPiece == null && board[row][col] != null) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }

      // There is a piece already selected, but usr can select another one of their piece
      else if (board[row][col] != null &&
          board[row][col]!.isWhite == selectedPiece!.isWhite) {
        selectedPiece = board[row][col];
        selectedRow = row;
        selectedCol = col;
      }

      // if there is a piece selected and user taps on a square that is a valid move, move there
      else if (selectedPiece != null &&
          validMoves.any((element) => element[0] == row && element[1] == col)) {
        movePiece(row, col);
      }

      // if the piece is selected then calculate the valid moves
      validMoves = calculateRawValidMoves(
        selectedRow,
        selectedCol,
        selectedPiece,
      );
    });
  }

// CALCULATE RAW VALID MOVES
  List<List<int>> calculateRawValidMoves(int row, int col, ChessPiece? piece) {
    List<List<int>> candidateMoves = [];
    if (piece == null) {
      return [];
    }
    // different directions based on their color
    int direction = piece.isWhite ? -1 : 1;

    switch (piece.type) {
      case ChessPieceType.pawn:
        // pawns can move forward if the square is not occupied
        if (Helper.isInBoard(row + direction, col) &&
            board[row + direction][col] == null) {
          candidateMoves.add([row + direction, col]);
        }

        // pawns can move 2 square forward if they are at their  initial position
        if ((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
          if (Helper.isInBoard(row + 2 * direction, col) &&
              board[row + 2 * direction][col] == null &&
              board[row + direction][col] == null) {
            candidateMoves.add([row + 2 * direction, col]);
          }
        }

        // pawn can capture diagonally
        if (Helper.isInBoard(row + direction, col - 1) &&
            board[row + direction][col - 1] != null &&
            board[row + direction][col - 1]!.isWhite) {
          candidateMoves.add([row + direction, col - 1]);
        }

        if (Helper.isInBoard(row + direction, col + 1) &&
            board[row + direction][col + 1] != null &&
            board[row + direction][col + 1]!.isWhite) {
          candidateMoves.add([row + direction, col + 1]);
        }

        break;
      case ChessPieceType.rook:
        // horizontal and vertical direction
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], //right
        ];

        for (var direction in directions) {
          int i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!Helper.isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); // kill
              }
              break; // blocked
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.knight:
        // all eight possible L shapes the knights can move
        var knightMoves = [
          [-2, -1], // up 2 left 1
          [-2, 1], // up 2 right 1
          [-1, -2], // up 1 left 2
          [-1, 2], // up 1 right 2
          [1, -2], // down 1 left 2
          [1, 2], // down 1 right 2
          [2, -1], // down 2 left 1
          [2, 1], // down 2 right 1
        ];

        for (var move in knightMoves) {
          var newRow = row + move[0];
          var newCol = col + move[1];
          if (!Helper.isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]); // kill
            }
            continue; // blocked
          }
          candidateMoves.add([newRow, newCol]);
        }
        break;
      case ChessPieceType.bishop:
        // diagonal direction
        var directions = [
          [-1, -1], // up left
          [-1, 1], // up right
          [1, 1], // down right
          [1, -1], // down left
        ];

        for (var direction in directions) {
          int i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!Helper.isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); // kill
              }
              break; // blocked
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.queen:
        // all eight directions: up, down, left, right, and 4 diagonal.
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], //right
          [-1, -1], // up left
          [-1, 1], // up right
          [1, 1], // down right
          [1, -1], // down left
        ];

        for (var direction in directions) {
          int i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newCol = col + i * direction[1];
            if (!Helper.isInBoard(newRow, newCol)) {
              break;
            }
            if (board[newRow][newCol] != null) {
              if (board[newRow][newCol]!.isWhite != piece.isWhite) {
                candidateMoves.add([newRow, newCol]); // kill
              }
              break; // blocked
            }
            candidateMoves.add([newRow, newCol]);
            i++;
          }
        }
        break;
      case ChessPieceType.king:
        // all eight directions: up, down, left, right, and 4 diagonal.
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], //right
          [-1, -1], // up left
          [-1, 1], // up right
          [1, 1], // down right
          [1, -1], // down left
        ];

        for (var direction in directions) {
          var newRow = row + direction[0];
          var newCol = col + direction[1];
          if (!Helper.isInBoard(newRow, newCol)) {
            continue;
          }
          if (board[newRow][newCol] != null) {
            if (board[newRow][newCol]!.isWhite != piece.isWhite) {
              candidateMoves.add([newRow, newCol]); // kill
            }
            continue; // blocked
          }
          candidateMoves.add([newRow, newCol]);
        }
        break;
      default:
    }
    return candidateMoves;
  }

// MOVE PIECE
  void movePiece(int newRow, int newCol) {
    // move the piece and clear the old spot
    board[newRow][newCol] = selectedPiece;
    board[selectedRow][selectedCol] = null;

    // clear selection
    setState(() {
      selectedPiece = null;
      selectedRow = -1;
      selectedCol = -1;
      validMoves = [];
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  // get the row and col position of this square
                  int row = index ~/ 8;
                  int col = index % 8;

                  // check if the square is selected
                  bool isSelected = row == selectedRow && col == selectedCol;

                  // check if this square is a valid move
                  bool isValidMove = false;
                  for (var position in validMoves) {
                    // compare row and col
                    if (position[0] == row && position[1] == col) {
                      isValidMove = true;
                    }
                  }
                  return Square(
                    isWhite: Helper.isWhite(index),
                    piece: board[row][col],
                    isSelected: isSelected,
                    isValidMove: isValidMove,
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
