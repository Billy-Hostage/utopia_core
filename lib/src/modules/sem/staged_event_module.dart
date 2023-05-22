// Billy-Hostage 2023

//import '../../utopia_world.dart';

//import 'staged_event_record.dart';
import '../utopia_module_base.dart';

enum EventStage {
  preDateTime,
  preCharacter,
  preSignal,
  preConsult,
  postConsult
}

class StagedEventModule extends ModuleBase {
  StagedEventModule(super.w);

  void triggerStageEvents(EventStage newStage, {dynamic params}) {
    //TODO: actually implement SEM system.

    final stateName = newStage.toString();
    logWarning(
        "Stub: Trigger $stateName", "StagedEventModule/triggerStageEvents");
  }

  @override
  void describe() {
    logInfo("Stub: Describe StagedEventModule state.",
        "StagedEventModule/describe");
  }
}
