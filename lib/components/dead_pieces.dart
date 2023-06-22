// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DeadPieces extends StatelessWidget {
  final String imgPath;
  final bool isWhite;
  const DeadPieces({
    Key? key,
    required this.imgPath,
    required this.isWhite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        imgPath,
        color: isWhite ? Colors.grey[300] : Colors.grey[800],
        width: 50,
        height: 50,
      ),
    );
  }
}
