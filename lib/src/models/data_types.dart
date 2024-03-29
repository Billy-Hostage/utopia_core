// Billy-Hostage 2023

import 'dart:io';
import '../modules/logging/logging_module.dart';

typedef Selectable = dynamic; // means a possible type or it's typed selector

class FileSystemJSONAsset {
  final String name;
  final File baseJsonFile;
  final Map<I18nLanguage, File> _localeJsonFiles;
  Map<I18nLanguage, File> get localeJsonFiles => _localeJsonFiles;

  FileSystemJSONAsset({required this.name, required this.baseJsonFile})
      : _localeJsonFiles = {};

  void regiserLocaleJson(I18nLanguage locale, File file) {
    if (_localeJsonFiles.containsKey(locale)) {
      // error here
      throw Exception("This locale has already been registered");
    }
    _localeJsonFiles[locale] = file;
  }
}

enum I18nLanguage {
  enus,
  jajp,
  kokr,
  zhhans,
  zhhant,
  unknown
  //TODO more
}

I18nLanguage codeToI18n(String code, [LoggingModule? lm]) {
  final ccode = code.toLowerCase().replaceAll(RegExp(r'[_-]'), '');
  switch (ccode) {
    case 'enus':
      return I18nLanguage.enus;
    case 'jajp':
      return I18nLanguage.jajp;
    case 'kokr':
      return I18nLanguage.kokr;
    case 'zhhans':
      return I18nLanguage.zhhans;
    case 'zhhant':
      return I18nLanguage.zhhant;
  }
  if (lm != null) lm.logError("Unknown languagecode $code", "types/codeToI18n");
  return I18nLanguage.unknown;
}

class LocalizableString {
  late Map<I18nLanguage, String> _localeStringMap;
  final LoggingModule _lm;
  final String _uid;
  String get uid => _uid;

  LocalizableString(String uid, LoggingModule lm)
      : _uid = uid,
        _lm = lm {
    _localeStringMap = <I18nLanguage, String>{};
  }

  void addLocale(I18nLanguage locale, String content) {
    _localeStringMap[locale] = content;
  }

  String get fallbackString {
    if (_localeStringMap.isEmpty) {
      throw Exception("$uid has zero locale string avalable.");
    }

    // prefer english
    if (_localeStringMap.containsKey(I18nLanguage.enus)) {
      return _localeStringMap[I18nLanguage.enus]!;
    }

    // just use the first one
    String outPerferred = "";
    _localeStringMap.forEach((key, value) {
      _lm.logWarning("String $_uid Fallback to $key as $value",
          "LocalizableString/fallbackString");
      outPerferred = value;
    });
    return outPerferred;
  }

  String getPreferredLocaleString(List<I18nLanguage> list) {
    if (list.isEmpty) {
      throw Exception("$uid has beed requested with no preferred locale.");
    }
    for (var p in list) {
      if (_localeStringMap.containsKey(p)) {
        return _localeStringMap[p]!;
      }
    }
    return fallbackString;
  }
}

class LocalizableStringList {
  final List<LocalizableString> _localizables;
  List<LocalizableString> get localizables => _localizables;
  final LoggingModule _lm;
  final String _uid;
  String get uid => _uid;

  LocalizableStringList(String uid, LoggingModule lm)
      : _uid = uid,
        _lm = lm,
        _localizables = [];

  void addLocale(int index, I18nLanguage locale, String content) {
    while (_localizables.length <= index) {
      // need to add a new list element
      _localizables
          .add(LocalizableString("$_uid[${_localizables.length}]", _lm));
    }
    _localizables[index].addLocale(locale, content);
  }
}

enum SelectorConditionType {
  hasFlag,
  noFlag,
  unknown,
}

SelectorConditionType strToCondType(String s, [LoggingModule? lm]) {
  switch (s) {
    case 'HAS_FLAG':
      return SelectorConditionType.hasFlag;
    case 'NO_FLAG':
      return SelectorConditionType.noFlag;
  }
  if (lm != null) lm.logError("Unknown cond type $s", "types/strToCondType");
  return SelectorConditionType.unknown;
}

class SelectorCondition {
  final SelectorConditionType type;
  String? flag;

  SelectorCondition(Map input) : type = strToCondType(input['type']) {
    if (type == SelectorConditionType.noFlag ||
        type == SelectorConditionType.hasFlag) {
      flag = input['flag'];
    }
  }

  @override
  String toString() {
    return "SelectorCondition $type [$flag]";
  }
}

class Selector<T> {
  //Fields
  final T value;
  final SelectorCondition cond;

  Selector(Map input, T defVal)
      : value = input['value'],
        cond = SelectorCondition(input['cond']);

  @override
  String toString() {
    return "Selector val:[$value] cond:[$cond]";
  }
}
