part of json_diff;

enum BeautifulDiffType {
  added,
  changed,
  removed,
  moved,
}

class BeautifulDiffResult {
  BeautifulDiffResult({
    @required this.diffType,
    @required this.value,
    @required this.key,
    @required this.path,
  })  : assert(diffType != null),
        assert(key != null);

  final BeautifulDiffType diffType;
  final Object value;
  final Object key;
  final List<Object> path;

  Object get beautyPath {
    return '[' + path.join('->') + '] ';
  }

  Object get beautyKey {
    return '$key: ';
  }

  Object get beautyValue {
    if (diffType == BeautifulDiffType.changed) {
      return '\n' + (value as List<Object>).join('->');
    }

    return value;
  }

  String toStringForWidget() {
    return '$beautyPath "$key": $beautyValue';
  }

  @override
  String toString() {
    return 'diffType: $diffType, key: $key, path: $beautyPath, value: $beautyValue';
  }
}

extension DiffNodeExt on DiffNode {
  /// beautified diff result
  static List<BeautifulDiffResult> beautifulDiff(DiffNode diff) {
    return [
      // removed
      for (final e in diff.removed.entries) ...[
        BeautifulDiffResult(
          diffType: BeautifulDiffType.removed,
          value: e.value,
          key: e.key,
          path: diff.path,
        ),
      ],

      // added
      for (final e in diff.added.entries) ...[
        BeautifulDiffResult(
          diffType: BeautifulDiffType.added,
          value: e.value,
          key: e.key,
          path: diff.path,
        ),
      ],

      // changed
      for (final e in diff.changed.entries) ...[
        BeautifulDiffResult(
          diffType: BeautifulDiffType.changed,
          value: e.value,
          key: e.key,
          path: diff.path,
        ),
      ],

      // moved
      for (final e in diff.moved.entries) ...[
        BeautifulDiffResult(
          diffType: BeautifulDiffType.moved,
          value: e.value,
          key: e.key,
          path: diff.path,
        ),
      ],

      // recursive get
      for (final e in diff.node.entries) ...beautifulDiff(e.value)
    ];
  }
}
