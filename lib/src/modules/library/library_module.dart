// Billy-Hostage 2023

import './library_utils.dart';
import '../logging/logging_module.dart';
import '../utopia_module_base.dart';
import '../../models/data_types.dart' show FileSystemJSONAsset;
import '../../models/experience_model_base.dart';
import '../../models/experience/experience.dart';

/// LibraryModule loads and keeps(maybe) assets from expPack(s).
/// Right now it does not care about memory usage or fs read overhead. We need to resovle this in the future
class LibraryModule extends ModuleBase {
  late ExperienceModel expModel;
  final String expPathBase;

  LibraryModule(super.w, String expPath) : expPathBase = expPath {
    logInfo("loading exp pack at $expPath", "LibraryModule/constructor");

    expModel = getAsset<ExperienceModel>(
        "experience", world.lm, ExperienceModel.fromFsJsonCore,
        loadLocaleJson: false)!;

    logInfo(
        "Experience identifier: ${expModel.identifier}, isFullLoad: ${expModel.isFullLoad}",
        "test");
  }

  @override
  void describe({LoggingModule? lm}) {
    if (lm != null) {
      lm.logInfo(
          "Currently Selected ExperiencePack: ${expModel.identifier} as $expPathBase",
          "LibraryModule/describe");
    } else {
      print(
          "Currently Selected ExperiencePack: ${expModel.identifier} as $expPathBase [LibraryModule/describe]");
    }
  }

  /// TODO This loads a instance of model to memory everytime.
  /// We need a cache pool.
  T? getAsset<T extends ExperienceModelBase>(String assetName, LoggingModule lm,
      T Function(FileSystemJSONAsset fsJsonAsset, LoggingModule lm) constructor,
      {bool loadLocaleJson = false}) {
    // ?Search from pool?
    final expFsJson = getAssetJsonsFileSystem("experience", expPathBase,
        seachLocaleJson: loadLocaleJson);
    if (expFsJson != null) {
      try {
        // ?Cache to pool?
        return constructor(expFsJson, lm);
      } on Exception catch (e) {
        lm.logError("Asset $assetName loading failed. Please check logs below:",
            "LibraryModule/getAsset");
        lm.logError(e.toString(), "LibraryModule/getAsset");
        return null;
      }
    }
    return null;
  }
}
