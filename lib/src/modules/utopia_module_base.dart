// Billy-Hostage 2023

import '../utopia_world.dart';

/// The base class for all modules
/// provides save/load functionality interface
abstract class ModuleBase {
  final UtopiaWorld world;

  ModuleBase(this.world);

  //TODO fill here
  void describe();

  void tick(int tickIntervalMs) {
    throw UnsupportedError("${runtimeType.toString()} cannot tick.");
  }

  void logInfo(String message, String src) {
    world.lm.logInfo(message, src);
  }

  void logWarning(String message, String src) {
    world.lm.logWarning(message, src);
  }

  void logError(String message, String src) {
    world.lm.logError(message, src);
  }
}
