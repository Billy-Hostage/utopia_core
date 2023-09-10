// Billy-Hostage 2023

import '../../utopia_world.dart';
import '../../models/experience/operation.dart';

class OperationProcessor {
  OperationProcessor(this.world);
  final UtopiaWorld world;

  OperationModel? _currentTickingOperation;
  OperationModel? get currentTickingOperation => _currentTickingOperation;

  void tickCurrentOp(int tickIntervalMs) {
    if (_currentTickingOperation == null) {
      return;
    }
    //TODO tick current op

    // TODO check is op done?
    //   TODO if done, submit outcome
  }

  void cancelCurrentOp(/* Reason */) {
    _currentTickingOperation = null;
    // TODO reset progress
  }
}
