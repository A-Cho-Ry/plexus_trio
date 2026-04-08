import 'package:flutter_test/flutter_test.dart';
import 'package:plexus_trio/plexus_trio_core.dart';

void main() {
  group('DeckGenerator', () {
    test('builds a full standard 4-trait/3-value deck with unique cards', () {
      const generator = DeckGenerator();
      final deck = generator.buildStandardDeck();

      expect(deck.length, 81);
      expect(deck.map((card) => card.id).toSet().length, 81);
      expect(deck.every((card) => card.traits.length == 4), isTrue);
      expect(
        deck.every(
          (card) => card.traits.every((value) => value >= 0 && value <= 2),
        ),
        isTrue,
      );
    });

    test('supports custom dimensions and value counts', () {
      const generator = DeckGenerator(traitCount: 2, traitValues: 4);
      final deck = generator.buildStandardDeck();

      expect(deck.length, 16);
      expect(deck.map((card) => card.id).toSet().length, 16);
      expect(deck.every((card) => card.traits.length == 2), isTrue);
    });
  });
}
