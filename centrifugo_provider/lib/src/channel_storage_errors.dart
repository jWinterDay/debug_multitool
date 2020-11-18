class StorageNotInitializedException implements Exception {
  StorageNotInitializedException([
    this.message,
  ]);

  final String message;
}

class AlreadyInitializedException implements Exception {}
