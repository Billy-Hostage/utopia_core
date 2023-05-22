// Billy-Hostage 2023

import '../../utopia_world.dart';

class CharacterBase {
  final UtopiaWorld world;

  CharacterBase(this.world);

  void tickCharacter(int tickIntervalMs) {
    throw UnsupportedError("CharacterBase.tickCharacter not implemented.");
  }
}
