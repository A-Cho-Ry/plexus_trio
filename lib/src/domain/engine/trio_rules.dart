import 'package:plexus_trio/src/domain/models/trio.dart';
import 'package:plexus_trio/src/domain/models/card_model.dart';

class TrioRules {
  const TrioRules();

  bool isValidTrio(List<CardModel> cards) {
    if (cards.length != 3) {
      return false;
    }
    if (!_hasUniqueIds(cards)) {
      return false;
    }

    final traitCount = cards.first.traits.length;
    if (cards.any((card) => card.traits.length != traitCount)) {
      return false;
    }

    for (var traitIndex = 0; traitIndex < traitCount; traitIndex++) {
      final valuesAtTrait = <int>{
        cards[0].traits[traitIndex],
        cards[1].traits[traitIndex],
        cards[2].traits[traitIndex],
      };

      if (valuesAtTrait.length != 1 && valuesAtTrait.length != 3) {
        return false;
      }
    }

    return true;
  }

  Trio? findFirstValidTrio(List<CardModel> cards) {
    for (var i = 0; i < cards.length - 2; i++) {
      for (var j = i + 1; j < cards.length - 1; j++) {
        for (var k = j + 1; k < cards.length; k++) {
          final candidate = [cards[i], cards[j], cards[k]];
          if (isValidTrio(candidate)) {
            return Trio(first: cards[i], second: cards[j], third: cards[k]);
          }
        }
      }
    }
    return null;
  }

  List<Trio> findAllValidTrios(List<CardModel> cards) {
    final trios = <Trio>[];

    for (var i = 0; i < cards.length - 2; i++) {
      for (var j = i + 1; j < cards.length - 1; j++) {
        for (var k = j + 1; k < cards.length; k++) {
          final candidate = [cards[i], cards[j], cards[k]];
          if (isValidTrio(candidate)) {
            trios.add(Trio(first: cards[i], second: cards[j], third: cards[k]));
          }
        }
      }
    }

    return List<Trio>.unmodifiable(trios);
  }

  bool _hasUniqueIds(List<CardModel> cards) =>
      cards.map((card) => card.id).toSet().length == cards.length;
}
