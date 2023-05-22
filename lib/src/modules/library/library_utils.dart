// Billy-Hostage 2023

import 'dart:io';
import 'package:path/path.dart' as path;
import '../logging/logging_module.dart';

import '../../models/data_types.dart'
    show FileSystemJSONAsset, I18nLanguage, codeToI18n;

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

FileSystemJSONAsset? getAssetJsonsFileSystem(
    String relativeAssetPath, String expPathBase,
    {LoggingModule? lm, bool seachLocaleJson = true}) {
  final String fullJsonAssetPath = path.join(expPathBase, relativeAssetPath);
  final String assetBaseName = path.basenameWithoutExtension(relativeAssetPath);

  // determin the JSON asset is flat or grouoped layout

  final File possibleFlatBaseJson = File("$fullJsonAssetPath.json");
  if (possibleFlatBaseJson.existsSync()) {
    // Consider it flat
    final FileSystemJSONAsset out = FileSystemJSONAsset(
        name: relativeAssetPath, baseJsonFile: possibleFlatBaseJson);

    // Load all locale jsons
    if (seachLocaleJson) {
      final fEntries = possibleFlatBaseJson.parent
          .listSync(recursive: false, followLinks: false)
          .whereType<File>();
      for (var file in fEntries) {
        final fileBasenameNoExt = path.basenameWithoutExtension(file.path);
        if (!fileBasenameNoExt.startsWith(assetBaseName) ||
            fileBasenameNoExt == assetBaseName) {
          continue;
        }
        final splitTemp = fileBasenameNoExt.split(".");
        if (splitTemp.length != 2) {
          lm?.logError("Unexpected naming of flat json file at ${file.path}",
              "lib_utils/getAssetJsonsFileSystem");
          continue;
        }
        out.regiserLocaleJson(codeToI18n(splitTemp[1], lm), file);
      }
    }

    return out;
  }

  final File possibleGroupedBaseJson = File("$fullJsonAssetPath/.json");
  if (possibleGroupedBaseJson.existsSync()) {
    // Consider it grouped
    final FileSystemJSONAsset out = FileSystemJSONAsset(
        name: relativeAssetPath, baseJsonFile: possibleGroupedBaseJson);
    if (seachLocaleJson) {
      // get locale jsons for groped json asset.
      final fEntries = possibleGroupedBaseJson.parent
          .listSync(recursive: false, followLinks: false)
          .whereType<File>();
      for (var file in fEntries) {
        final basename = path.basename(file.path);
        if (basename == ".json") continue;
        final splitTemp = basename.split('.');
        if (splitTemp.length != 2) {
          lm?.logError("Unexpected naming of grouped json file at ${file.path}",
              "lib_utils/getAssetJsonsFileSystem");
          continue;
        }
        // register locale json
        out.regiserLocaleJson(codeToI18n(splitTemp[0], lm), file);
      }
    }
    return out;
  }

  if (lm != null) {
    lm.logError("Failed to locate json asset $fullJsonAssetPath in filesystem.",
        "lib_utils/getAssetJsonsFileSystem");
  }
  return null;
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
