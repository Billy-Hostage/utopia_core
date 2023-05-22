// Billy-Hostage 2023

import 'dart:convert' show jsonDecode;
import 'package:path/path.dart' as path;

import './data_types.dart' show FileSystemJSONAsset, I18nLanguage;
import '../modules/logging/logging_module.dart';

abstract class ExperienceModelBase {
  final String _assetName;
  String get assetName => _assetName;
  String get assetBaseName => path.basenameWithoutExtension(_assetName);

  bool get requireLocaleJson => false;
  final bool _isFullLoad;

  /// false indicating a partial load
  bool get isFullLoad => _isFullLoad;

  // Create model object from json on filesystem.
  // This reads every thing
  ExperienceModelBase.fromFsJson(
      FileSystemJSONAsset fsJsonAsset, LoggingModule lm)
      : _assetName = fsJsonAsset.name,
        _isFullLoad = true {
    final baseJsonObj = jsonDecode(fsJsonAsset.baseJsonFile.readAsStringSync());
    deserializeFromJsonCore(baseJsonObj, lm);
    if (fsJsonAsset.localeJsonFiles.isEmpty) {
      lm.logWarning("${fsJsonAsset.name} has no localeJson. Plz check.",
          "ExperienceModelBase/fromFsJson");
      assert(!requireLocaleJson,
          "${runtimeType.toString()}.fromFsJson needs locale jsons to load.\n If you want to load core info only, please specify fromFsJsonCore Constructor instead.");
    } else {
      Map<I18nLanguage, Map> localeJsonObjs = {};
      fsJsonAsset.localeJsonFiles.forEach((locale, jsonFile) {
        assert(!localeJsonObjs.containsKey(locale));
        final json = jsonFile.readAsStringSync();
        localeJsonObjs[locale] = jsonDecode(json);
      });
      if (localeJsonObjs.isNotEmpty) {
        deserializeFromJsonFull(baseJsonObj, localeJsonObjs, lm);
      }
    }
  }

  // Create model object from json on filesystem.
  // This reads fields that are only relavent to core running.
  ExperienceModelBase.fromFsJsonCore(
      FileSystemJSONAsset fsJsonAsset, LoggingModule lm)
      : _assetName = fsJsonAsset.name,
        _isFullLoad = false {
    deserializeFromJsonCore(
        jsonDecode(fsJsonAsset.baseJsonFile.readAsStringSync()), lm);
  }

  /// Will be called when model is constructed with fromFsJson&fromFsJsonCore
  /// fromFsJsonCore ONLY calls this to deserialize asset
  void deserializeFromJsonCore(dynamic baseJsonObject, LoggingModule lm);

  /// Will be called when model is constructed with fromFsJson only
  void deserializeFromJsonFull(dynamic baseJsonObject,
      Map<I18nLanguage, dynamic> localeJsonObjects, LoggingModule lm);
}
