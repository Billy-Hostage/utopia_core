// Billy-Hostage 2023

import 'modules/sem/staged_event_module.dart';
import 'modules/library/library_module.dart';
import 'modules/logging/logging_module.dart';
import 'modules/time/time_module.dart';
import 'modules/prefrences/prefrences_module.dart';
import 'modules/character/character_module.dart';

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

  // Ticks
  int _tickCounter = 0;
  int get tickCounter => _tickCounter;
  int _agreedTickIntervalMs; // 1s for default interval
  int get agreedTickIntervalMs => _agreedTickIntervalMs;

  // Submodules
  late StagedEventModule _sem;
  StagedEventModule get sem => _sem;
  late LibraryModule _library;
  LibraryModule get lib => _library;
  late LoggingModule _logging;
  LoggingModule get lm => _logging;
  late CharacterModule _character;
  CharacterModule get character => _character;
  late TimeModule _time;
  TimeModule get time => _time;
  late PrefrencesModule _prefrence;
  PrefrencesModule get prefrence => _prefrence;

  /// Create world constructor
  /// Brand new world, no resume
  UtopiaWorld.newWorld(String name, String expPath,
      {int expectedTickIntervalMs = 1000})
      : _worldName = name,
        _agreedTickIntervalMs = expectedTickIntervalMs,
        _creationTime = DateTime.now() {
    // TODO More Module Initialization below
    // TODO After all initialization, print out debug information

    // INIT PHRASE 1
    _logging = LoggingModule(this);
    _prefrence = PrefrencesModule(this);

    // INIT PHRASE 2
    _library = LibraryModule(this, expPath);
    // TODO we need a persistence manager here

    // INIT PHRASE 3
    _sem = StagedEventModule(this);
    _time = TimeModule(this);
    _character = CharacterModule(this);
  }

  /// External timers/tickers should call this.
  void tickExt() {
    ++_tickCounter;

    // TODO: Calculate tick interval, see if we meet the expected target.

    // StageEvent PreDateTime
    _sem.triggerStageEvents(EventStage.preDateTime);

    // Tick DataTimeModule
    _time.tick(_agreedTickIntervalMs);

    // StageEvent PreCharacter
    _sem.triggerStageEvents(EventStage.preCharacter);

    // TODO: Tick CharacterModule
    _character.tick(_agreedTickIntervalMs);

    // TODO: Tick InventoryModule

    // TODO: Tick QuestModule

    // TODO: Tick DialogModule

    // StageEvent PreSignal
    _sem.triggerStageEvents(EventStage.preSignal);

    // TODO: Tick PlayerSignalModule

    // StageEvent PreConsult
    _sem.triggerStageEvents(EventStage.preConsult);

    // TODO: Ask WorldDataModule to consult changes in all previous processes.
    // And Generate Delta as a JSON Package
    // Chages are saved in some form of persistent storage.

    // StageEvent PostConsult
    // This stage can do postprocessing to delta package.
    // Keep in mind that all changes made in here will NOT be saved nor processed until next tick.
    // TODO: actually pass delta package.
    _sem.triggerStageEvents(EventStage.postConsult, params: null);

    // TODO: Lastly, send consult message to ui/frontend/console or whatever.

    _logging.logInfo("Tick $_tickCounter Done.", "UtopiaWorld/tickExt");
  }

  void updateAgreedTickIntervalMs(
    int newValue,
    /* Reason */
  ) {
    _agreedTickIntervalMs = newValue;
  }
}
