import 'package:plexus_trio/src/domain/models/card_model.dart';

class Trio {
  Trio({
    required CardModel first,
    required CardModel second,
    required CardModel third,
  }) : cards = List<CardModel>.unmodifiable([first, second, third]) {
    if (cards.map((card) => card.id).toSet().length != 3) {
      throw ArgumentError('A trio must contain 3 unique cards.');
    }
  }

  final List<CardModel> cards;

  @override
  bool operator ==(Object other) {
    if (other is! Trio) {
      return false;
    }

    final leftIds = cards.map((card) => card.id).toList()..sort();
    final rightIds = other.cards.map((card) => card.id).toList()..sort();

    for (var index = 0; index < leftIds.length; index++) {
      if (leftIds[index] != rightIds[index]) {
        return false;
      }
    }

    return true;
  }

  @override
  int get hashCode {
    final sortedIds = cards.map((card) => card.id).toList()..sort();
    return Object.hashAll(sortedIds);
  }
}
