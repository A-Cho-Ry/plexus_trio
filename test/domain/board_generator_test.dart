import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:plexus_trio/plexus_trio_core.dart';

void main() {
  group('BoardGenerator', () {
    test(
      'generates a board with unique cards and at least one playable trio',
      () {
        final rules = TrioRules();
        final generator = BoardGenerator(
          gameRules: rules,
          deckGenerator: const DeckGenerator(),
          random: Random(42),
        );

        final board = generator.generate(boardSize: 12);
        final trio = rules.findFirstValidTrio(board.cards);

        expect(board.size, 12);
        expect(board.cards.map((card) => card.id).toSet().length, 12);
        expect(trio, isNotNull);
      },
    );

    test('throws when board size is invalid', () {
      final generator = BoardGenerator(
        gameRules: const TrioRules(),
        deckGenerator: const DeckGenerator(),
        random: Random(1),
      );

      expect(() => generator.generate(boardSize: 2), throwsArgumentError);
    });

    test(
      'throws state error when deck allows board but no trio is possible',
      () {
        final generator = BoardGenerator(
          gameRules: const TrioRules(),
          deckGenerator: const DeckGenerator(traitCount: 2, traitValues: 2),
          random: Random(3),
        );

        expect(
          () => generator.generate(boardSize: 4, maxAttempts: 10),
          throwsA(isA<StateError>()),
        );
      },
    );
  });
}
