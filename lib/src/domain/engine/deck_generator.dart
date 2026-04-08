import 'package:plexus_trio/src/domain/models/card_model.dart';

class DeckGenerator {
  const DeckGenerator({this.traitCount = 4, this.traitValues = 3});

  final int traitCount;
  final int traitValues;

  List<CardModel> buildStandardDeck() {
    if (traitCount <= 0) {
      throw ArgumentError('traitCount must be greater than 0.');
    }
    if (traitValues <= 0) {
      throw ArgumentError('traitValues must be greater than 0.');
    }

    var totalCardCount = 1;
    for (var index = 0; index < traitCount; index++) {
      totalCardCount *= traitValues;
    }

    final cards = <CardModel>[];
    for (var value = 0; value < totalCardCount; value++) {
      cards.add(_buildCardFromIndex(value));
    }

    return List<CardModel>.unmodifiable(cards);
  }

  CardModel _buildCardFromIndex(int index) {
    var remainder = index;
    final traits = List<int>.filled(traitCount, 0);

    for (var traitIndex = traitCount - 1; traitIndex >= 0; traitIndex--) {
      traits[traitIndex] = remainder % traitValues;
      remainder ~/= traitValues;
    }

    return CardModel.fromTraits(traits);
  }
}
