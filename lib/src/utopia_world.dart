// Billy-Hostage 2023

import 'modules/sem/staged_event_module.dart';
import 'modules/library/library_module.dart';
import 'modules/logging/logging_module.dart';
import 'modules/time/time_module.dart';

/// The general manager class for the entire world instance.
/// Other modules can get all other interfaces for the world in here.
/// Also, the control of ticking is here.
/// This class is usually used with other wrapper classes or routing systems.
class UtopiaWorld {
  // Basic Informations
  String _worldName = "placeholder";
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
  late LibraryModule _library;
  late LoggingModule _logging;
  LoggingModule get lm => _logging; // this can be exposed
  late TimeModule _time;

  /// Create world constructor
  /// Brand new world, no resume
  UtopiaWorld.newWorld(String name, String expPath,
      {int expectedTickIntervalMs = 1000})
      : _worldName = name,
        _agreedTickIntervalMs = expectedTickIntervalMs,
        _creationTime = DateTime.now() {
    // TODO More Module Initialization below
    // TODO After all initialization, print out debug information
    _logging = LoggingModule(this);

    _sem = StagedEventModule(this);
    _library = LibraryModule(this, expPath);
    _time = TimeModule(this);
  }

  /// External timers/tickers should call this.
  void tickExt() {
    ++_tickCounter;

    // TODO: Calculate tick interval, see if we meet the expected target.

    // StageEvent PreDateTime
    _sem.triggerStageEvents(EventStage.preDateTime);

    // Tick DataTimeModule
    _time.tick();

    // StageEvent PreCharacter
    _sem.triggerStageEvents(EventStage.preCharacter);

    // TODO: Tick CharacterModule

    // StageEvent PreOperation
    _sem.triggerStageEvents(EventStage.preOperation);

    // TODO: Tick OperationModule

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
}
