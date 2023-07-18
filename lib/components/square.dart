// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chess_game_by_mitch/components/piece.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  final ChessPiece? piece;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isValidMove;
  const Square({
    Key? key,
    required this.isWhite,
    this.piece,
    required this.isSelected,
    required this.onTap,
    required this.isValidMove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color selectedColor;
    // if selected, square will be green
    if (isSelected) {
      selectedColor = Colors.green;
    }
    // if is valid move, borders will be green
    else if (isValidMove) {
      selectedColor = Colors.greenAccent;
    }
    // otherwise, square will be white or black
    else {
      selectedColor = (isWhite ? Colors.purple[100] : Colors.purple[300])!;
    }
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: selectedColor, width: 4),
          color: isWhite ? Colors.purple[100] : Colors.purple[300],
        ),
        child: piece != null
            ? Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  piece!.img,
                  color: piece!.isWhite ? Colors.white : Colors.black,
                  filterQuality: FilterQuality.high,
                ),
              )
            : null,
      ),
    );
  }
}
