// Billy-Hostage 2023

import 'package:utopia_core/src/modules/logging/logging_module.dart';

import '../utopia_world.dart';

/// The base class for all modules
/// provides save/load functionality interface
abstract class ModuleBase {
  UtopiaWorld _world;
  UtopiaWorld get world => _world;

  ModuleBase(UtopiaWorld w) : _world = w;

  //TODO fill here
  void describe();

  void tick() {
    final typeName = runtimeType.toString();
    logInfo("Stub: $typeName Ticking", "ModuleBase/tick");
  }

  void logInfo(String message, String src) {
    _world.lm.logInfo(message, src);
  }

  void logWarning(String message, String src) {
    _world.lm.logWarning(message, src);
  }

  void logError(String message, String src) {
    _world.lm.logError(message, src);
  }
}
