// Billy-Hostage 2023

import '../utopia_module_base.dart';

class TimeModule extends ModuleBase {
  TimeModule(super.w) {
    // TODO get time config
  }

  @override
  void describe() {
    // TODO: implement describe
  }

  @override
  void tick(int tickIntervalMs) {
    // TODO
    logWarning("Stub: Tick world time and calender.", "TimeModule/tick");
  }
}
