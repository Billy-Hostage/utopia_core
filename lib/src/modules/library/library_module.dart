// Billy-Hostage 2023

import 'dart:io';

import '../../models/data_types.dart';

import './library_utils.dart';
import '../utopia_module_base.dart';
import '../../models/experience/experience.dart';

class LibraryModule extends ModuleBase {
  late ExperienceModel expModel;

  LibraryModule(super.w, String expPath) {
    logInfo("loading exp pack at $expPath", "LibraryModule/constructor");
    // Read experience.json
    final expJsons = getExperienceJsonsPath(expPath);
    Map<I18nLanguage, String> localeJsonContent = {};
    for (var i = 1; i < expJsons.length; i++) {
      localeJsonContent[getI18nFromFilePath(expJsons[i], world.lm)] =
          File(expJsons[i]).readAsStringSync();
    }

    expModel = ExperienceModel.fromJson(
        "experience", File(expJsons[0]).readAsStringSync(), world.lm,
        localeJsonContent: localeJsonContent);

    logInfo(
        "Exp idf: ${expModel.lName.getPreferredLocaleString(world.prefrence.preferredLangList)}",
        "test");
  }

  @override
  void describe() {
    // TODO: implement describe
  }
}
