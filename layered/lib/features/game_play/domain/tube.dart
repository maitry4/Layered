import 'package:layered/features/game_play/domain/fruit_type.dart';

class Tube {
  final int capacity;
  final List<FruitType> slabs; // bottom → top

  Tube({required this.capacity, required List<FruitType> slabs})
      : slabs = List.unmodifiable(slabs);

  bool get isEmpty => slabs.isEmpty;
  bool get isFull => slabs.length == capacity;
  FruitType? get top => slabs.isNotEmpty ? slabs.last : null;

  bool get isComplete =>
      isFull && slabs.every((s) => s == slabs.first);

  Tube copy() => Tube(capacity: capacity, slabs: List.from(slabs));
}
