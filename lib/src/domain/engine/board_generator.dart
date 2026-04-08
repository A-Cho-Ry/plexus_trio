import 'dart:math';

import 'package:plexus_trio/src/domain/engine/deck_generator.dart';
import 'package:plexus_trio/src/domain/engine/trio_rules.dart';
import 'package:plexus_trio/src/domain/models/board_state.dart';
import 'package:plexus_trio/src/domain/models/card_model.dart';

class BoardGenerator {
  BoardGenerator({
    required TrioRules gameRules,
    required DeckGenerator deckGenerator,
    Random? random,
  }) : _gameRules = gameRules,
       _deckGenerator = deckGenerator,
       _random = random ?? Random();

  final TrioRules _gameRules;
  final DeckGenerator _deckGenerator;
  final Random _random;

  BoardState generate({int boardSize = 12, int maxAttempts = 1_000}) {
    if (boardSize < 3) {
      throw ArgumentError('boardSize must be at least 3.');
    }
    if (maxAttempts <= 0) {
      throw ArgumentError('maxAttempts must be greater than 0.');
    }

    final deck = _deckGenerator.buildStandardDeck();
    if (boardSize > deck.length) {
      throw ArgumentError(
        'boardSize ($boardSize) cannot exceed deck size (${deck.length}).',
      );
    }

    for (var attempt = 0; attempt < maxAttempts; attempt++) {
      final shuffledDeck = List<CardModel>.from(deck)..shuffle(_random);
      final cards = shuffledDeck.take(boardSize).toList(growable: false);
      if (_gameRules.findFirstValidTrio(cards) != null) {
        return BoardState(cards: cards);
      }
    }

    throw StateError(
      'Could not generate a playable board in $maxAttempts attempts.',
    );
  }
}
