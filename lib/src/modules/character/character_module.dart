// Billy-Hostage 2023

import './player_character.dart';
import '../utopia_module_base.dart';
import '../../utopia_world.dart';

class CharacterModule extends ModuleBase {
  CharacterModule(UtopiaWorld w)
      : _playerCharacter = PlayerCharacter(w),
        super(w);

  final PlayerCharacter _playerCharacter;
  PlayerCharacter get player => _playerCharacter;

  @override
  void describe() {
    // TODO: implement describe
  }
  @override
  void tick(int tickIntervalMs) {
    // tick player
    _playerCharacter.tickCharacter(tickIntervalMs);

    // TODO tick other Registered characters
  }
}
