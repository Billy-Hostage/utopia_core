// Billy-Hostage 2023

import '../utopia_module_base.dart';

class LoggingModule extends ModuleBase {
  LoggingModule(super.w);

  void logError(String message, String src) {
    // TODO Record the error
    final String t = DateTime.now().toIso8601String();
    final worldName = world.worldName;
    print("$t {$worldName} [$src] Error: $message");
  }

  void logWarning(String message, String src) {
    // TODO Record the warning
    final String t = DateTime.now().toIso8601String();
    final worldName = world.worldName;
    print("$t {$worldName} [$src] Warn: $message");
  }

  void logInfo(String message, String src) {
    // TODO Record the info
    final String t = DateTime.now().toIso8601String();
    final worldName = world.worldName;
    print("$t {$worldName} [$src] Info: $message");
  }

  @override
  void describe() {
    // TODO: implement describe
  }

  // TODO: we need a queue to store unread/unsynced messages
}
