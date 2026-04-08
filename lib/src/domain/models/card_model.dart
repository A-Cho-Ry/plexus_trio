class CardModel {
  CardModel({required String id, required List<int> traits})
    : id = id.trim(),
      traits = List<int>.unmodifiable(traits) {
    if (this.id.isEmpty) {
      throw ArgumentError('Card id cannot be empty.');
    }
    if (this.traits.isEmpty) {
      throw ArgumentError('Card must include at least one trait.');
    }
    if (this.traits.any((value) => value < 0)) {
      throw ArgumentError('Trait values must be non-negative integers.');
    }
  }

  factory CardModel.fromTraits(List<int> traits) {
    if (traits.isEmpty) {
      throw ArgumentError('Card must include at least one trait.');
    }
    return CardModel(id: traits.join('-'), traits: traits);
  }

  final String id;
  final List<int> traits;

  @override
  bool operator ==(Object other) {
    return other is CardModel &&
        id == other.id &&
        _listEquals(traits, other.traits);
  }

  @override
  int get hashCode => Object.hash(id, Object.hashAll(traits));
}

bool _listEquals(List<int> left, List<int> right) {
  if (left.length != right.length) {
    return false;
  }

  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) {
      return false;
    }
  }

  return true;
}
