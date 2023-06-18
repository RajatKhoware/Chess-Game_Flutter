// ignore_for_file: public_member_api_docs, sort_constructors_first
enum ChessPieceType { pawn, king, queen, rook, bishop, knight }

class ChessPiece {
  final ChessPieceType type;
  final bool isWhite;
  final String img;
  ChessPiece({
    required this.type,
    required this.isWhite,
    required this.img,
  });
}
