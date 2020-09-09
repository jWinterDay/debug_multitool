class Pair<L, R> {
  Pair(
    this.first,
    this.second,
  );

  final L first;
  final R second;

  @override
  String toString() {
    return '[Pair] first: $first, second: $second';
  }
}
