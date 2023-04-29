// Billy-Hostage 2023

import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:utopia_core/src/modules/logging/logging_module.dart';

import '../../models/data_types.dart' show I18nLanguage, codeToI18n;

/// Returns all ExperienceJsons.
/// 0 is base json, others are locale specific.
List<String> getExperienceJsonsPath(String experienceBasePath) {
  List<String> out = [];
  Directory baseDir = Directory(experienceBasePath);
  assert(baseDir.existsSync());

  // base
  final baseJsonPath = path.join(experienceBasePath, "experience.json");
  assert(File(baseJsonPath).existsSync());
  out.add(baseJsonPath);

  //locale
  final fEntries =
      baseDir.listSync(recursive: false, followLinks: false).whereType<File>();
  for (var file in fEntries) {
    final base = path.basename(file.path);
    if (base.startsWith("experience.") && base != "experience.json") {
      out.add(file.path);
    }
  }

  return out;
}

I18nLanguage getI18nFromFilePath(String filePath, LoggingModule lm) {
  final segName = path.basename(filePath).split('.');
  if (segName.length < 2) {
    lm.logError(
        "file $filePath has no locale code.", "lib_util/getI18nFromFilePath");
    return I18nLanguage.unknown;
  }
  return codeToI18n(segName[segName.length - 2], lm);
}
