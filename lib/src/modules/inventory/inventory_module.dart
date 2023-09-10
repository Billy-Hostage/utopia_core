// Billy-Hostage 2023

import '../utopia_module_base.dart';

class InventoryModule extends ModuleBase {
  InventoryModule(super.w);

  @override
  void describe() {
    // TODO: implement describe
  }

  @override
  void tick(int tickIntervalMs) {
    // TODO
    logWarning("Stub: Do checkes and other processes on inventory items.",
        "InventoryModule/tick");
  }
}
