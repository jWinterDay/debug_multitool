class Triple<L, R, T> {
  Triple(this.first, this.second, this.third);

  final L first;
  final R second;
  final T third;

  @override
  String toString() {
    return '[Triple] first: $first, second: $second, third: $third';
  }
}
