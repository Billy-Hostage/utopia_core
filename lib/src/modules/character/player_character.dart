// Billy-Hostage 2023

import './character_base.dart';
import '../../components/operation/operation_processor.dart';

class PlayerCharacter extends CharacterBase {
  PlayerCharacter(super.world) : _opp = OperationProcessor(world);

  final OperationProcessor _opp;

  @override
  void tickCharacter(int tickIntervalMs) {
    _opp.tickCurrentOp(tickIntervalMs);
  }
}
