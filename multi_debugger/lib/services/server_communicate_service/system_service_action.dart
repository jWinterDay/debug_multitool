class SystemServiceAction {
  static const String createNewChannel = 'createNewChannel';
  static const String deleteChannel = 'deleteChannel';

  static bool isControlCommand(String command) {
    return [createNewChannel, deleteChannel].contains(command);
  }
}
