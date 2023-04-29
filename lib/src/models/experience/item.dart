// Billy-Hostage 2023

import 'dart:convert';

import '../data_types.dart';
import '../../modules/logging/logging_module.dart';

class ItemModel {
  String _id = "placeholder";
  String get id => _id;
  List<String> _flags = <String>[];
  List<String> get flags => _flags;
  List<String> _tags = <String>[];
  List<String> get tags => _tags;
  dynamic _additionalInfo = {};
  dynamic get additionalInfo => _additionalInfo;
  int _maxStackCount = 16;
  int get maxStackCount => _maxStackCount;

  final LocalizableString _name;
  final LocalizableString _desc;

  ItemModel.fromJson(String uid, String baseJsonContent, LoggingModule lm,
      {Map<I18nLanguage, String>? localeJsonContent})
      : _name = LocalizableString("$uid:name", lm),
        _desc = LocalizableString("$uid:desc", lm) {
    var decodeBaseJson = jsonDecode(baseJsonContent);
    assert(decodeBaseJson is Map);

    // setup members
    _id = decodeBaseJson["id"];
    _flags = decodeBaseJson["flags"];
    _tags = decodeBaseJson["tags"];
    _additionalInfo = decodeBaseJson["additionalInfo"];
    _maxStackCount = decodeBaseJson["maxStackCount"];

    // load localeJson
    if (localeJsonContent == null) {
      lm.logWarning(
          "Item $uid has no localeJson. Plz check.", "ItemModel/fromJson");
    } else {
      localeJsonContent.forEach((locale, json) {
        final localeJsonObj = jsonDecode(json);
        assert(localeJsonObj is Map);
        _name.addLocale(locale, localeJsonObj["name"]);
        _desc.addLocale(locale, localeJsonObj["desc"]);
      });
    }
  }
}
