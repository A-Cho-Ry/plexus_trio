import 'package:flutter_test/flutter_test.dart';
import 'package:plexus_trio/plexus_trio_core.dart';

void main() {
  group('TrioRules', () {
    const rules = TrioRules();

    test('accepts a trio when each trait is all same or all different', () {
      final trio = [
        CardModel.fromTraits([0, 0, 0, 0]),
        CardModel.fromTraits([0, 1, 1, 1]),
        CardModel.fromTraits([0, 2, 2, 2]),
      ];

      expect(rules.isValidTrio(trio), isTrue);
    });

    test('rejects a trio when any trait is two-same-one-different', () {
      final trio = [
        CardModel.fromTraits([0, 0, 0, 0]),
        CardModel.fromTraits([0, 0, 1, 1]),
        CardModel.fromTraits([0, 1, 2, 2]),
      ];

      expect(rules.isValidTrio(trio), isFalse);
    });

    test('rejects duplicate cards', () {
      final card = CardModel.fromTraits([0, 0, 0, 0]);
      final trio = [
        card,
        card,
        CardModel.fromTraits([0, 1, 1, 1]),
      ];

      expect(rules.isValidTrio(trio), isFalse);
    });

    test('findFirstValidTrio returns the first valid trio from a board', () {
      final board = [
        CardModel.fromTraits([0, 0, 0, 0]),
        CardModel.fromTraits([0, 1, 1, 1]),
        CardModel.fromTraits([0, 2, 2, 2]),
        CardModel.fromTraits([1, 0, 0, 0]),
      ];

      final trio = rules.findFirstValidTrio(board);

      expect(trio, isNotNull);
      expect(trio!.cards.map((card) => card.id).toSet(), {
        '0-0-0-0',
        '0-1-1-1',
        '0-2-2-2',
      });
    });
  });
}
