// Billy-Hostage 2023

import 'modules/sem/staged_event_module.dart';
import 'modules/library/library_module.dart';
import 'modules/logging/logging_module.dart';
import 'modules/time/time_module.dart';
import 'modules/prefrences/prefrences_module.dart';
import 'modules/character/character_module.dart';
import 'modules/inventory/inventory_module.dart';
import 'modules/outcome/outcome_module.dart';

/// The general manager class for the entire world instance.
/// Other modules can get all other interfaces for the world in here.
/// Also, the control of ticking is here.
/// This class is usually used with other wrapper classes or routing systems.
class UtopiaWorld {
  // Basic Informations
  final String _worldName;
  String get worldName => _worldName;
  final DateTime _creationTime;
  DateTime get creationTime => _creationTime;
  final List<String> _flags;

  // Ticks
  int _tickCounter = 0;
  int get tickCounter => _tickCounter;
  int _agreedTickIntervalMs; // 1s for default interval
  int get agreedTickIntervalMs => _agreedTickIntervalMs;

  // Submodules
  late final StagedEventModule sem;
  late final LibraryModule lib;
  late final LoggingModule log;
  late final CharacterModule character;
  late final InventoryModule inventory;
  late final OutcomeModule outcome;
  late final TimeModule time;
  late final PrefrencesModule prefrence;

  /// Create world constructor
  /// Brand new world, no resume
  UtopiaWorld.newWorld(String name, String expPath,
      {int expectedTickIntervalMs = 1000})
      : _worldName = name,
        _agreedTickIntervalMs = expectedTickIntervalMs,
        _creationTime = DateTime.now(),
        _flags = [] {
    // TODO More Module Initialization below
    // TODO After all initialization, print out debug information

    // INIT PHRASE 1
    log = LoggingModule(this);
    prefrence = PrefrencesModule(this);

    // INIT PHRASE 2
    lib = LibraryModule(this, expPath);
    // TODO we need a persistence manager here

    // INIT PHRASE 3
    sem = StagedEventModule(this);
    time = TimeModule(this);
    character = CharacterModule(this);
    inventory = InventoryModule(this);
    outcome = OutcomeModule(this);
  }

  /// External timers/tickers should call this.
  void tickExt() {
    ++_tickCounter;

    // TODO: Calculate tick interval, see if we meet the expected target.

    // StageEvent PreDateTime
    sem.triggerStageEvents(EventStage.preDateTime);

    // Tick DataTimeModule
    time.tick(_agreedTickIntervalMs);

    // StageEvent PreCharacter
    sem.triggerStageEvents(EventStage.preCharacter);

    // Tick CharacterModule
    character.tick(_agreedTickIntervalMs);

    // Tick InventoryModule
    inventory.tick(_agreedTickIntervalMs);

    // TODO: Tick QuestModule

    // TODO: Tick DialogModule

    // StageEvent PreSignal
    sem.triggerStageEvents(EventStage.preSignal);

    // TODO: Tick PlayerSignalModule

    // StageEvent PreConsult
    sem.triggerStageEvents(EventStage.preConsult);

    // TODO: Ask WorldDataModule to consult changes in all previous processes.
    // And Generate Delta as a JSON Package
    // Chages are saved in some form of persistent storage.

    // StageEvent PostConsult
    // This stage can do postprocessing to delta package.
    // Keep in mind that all changes made in here will NOT be saved nor processed until next tick.
    // TODO: actually pass delta package.
    sem.triggerStageEvents(EventStage.postConsult, params: null);

    // TODO: Lastly, send consult message to ui/frontend/console or whatever.

    log.logInfo("Tick $_tickCounter Done.", "UtopiaWorld/tickExt");
  }

  void updateAgreedTickIntervalMs(
    int newValue,
    /* Reason */
  ) {
    _agreedTickIntervalMs = newValue;
  }

  bool hasFlag(String flagName) {
    return _flags.contains(flagName);
  }

  void addFlag(String flagName) {
    if (!hasFlag(flagName)) _flags.add(flagName);
  }

  void removeFlag(String flagName) {
    if (hasFlag(flagName)) _flags.remove(flagName);
  }
}
