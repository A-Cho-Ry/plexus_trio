import 'package:plexus_trio/src/domain/models/card_model.dart';

class BoardState {
  BoardState({required List<CardModel> cards})
    : cards = List<CardModel>.unmodifiable(cards) {
    if (this.cards.length < 3) {
      throw ArgumentError('Board must contain at least 3 cards.');
    }
    if (this.cards.map((card) => card.id).toSet().length != this.cards.length) {
      throw ArgumentError('Board cannot contain duplicate cards.');
    }
  }

  final List<CardModel> cards;

  int get size => cards.length;
}
