// Billy-Hostage 2023

import 'dart:convert';

import '../data_types.dart';
import '../../modules/logging/logging_module.dart';

class ExperienceModel {
  String _version = "v1";
  String get version => _version;
  String _identifier = "teamutopia.place.holder";
  String get identifier => _identifier;
  String _url = "";
  String get url => _url;

  // exp version
  int _majorVersion = 0;
  int _minorVersion = 0;
  int _patchVersion = 0;
  String get expVersion => "$_majorVersion.$_minorVersion.$_patchVersion";

  List<String> _claimedFeatures = <String>[];
  List<String> get claimedFeatures => _claimedFeatures;
  List<String> _tags = <String>[];
  List<String> get tags => _tags;
  List<String> _spolierTags = <String>[];
  List<String> get spolierTags => _spolierTags;

  final List<I18nLanguage> _supportedLanguages = <I18nLanguage>[];
  List<I18nLanguage> get supportedLanguages => _supportedLanguages;

  final LocalizableString _name;
  LocalizableString get lName => _name;
  final LocalizableString _desc;
  LocalizableString get lDesc => _desc;
  final LocalizableStringList _authors;
  LocalizableStringList get llAuthors => _authors;

  ExperienceModel.fromJson(String uid, String baseJsonContent, LoggingModule lm,
      {Map<I18nLanguage, String>? localeJsonContent})
      : _name = LocalizableString("$uid:name", lm),
        _desc = LocalizableString("$uid:desc", lm),
        _authors = LocalizableStringList("$uid:authors", lm) {
    var decodeBaseJson = jsonDecode(baseJsonContent);
    assert(decodeBaseJson is Map);

    // setup members
    _version = decodeBaseJson["version"];
    _identifier = decodeBaseJson["identifier"];
    _url = decodeBaseJson["url"];

    String expVersion = decodeBaseJson["expVersion"];
    // Parse version
    final spV = expVersion.split('.');
    assert(spV.length >= 3);
    _majorVersion = int.parse(spV[0]);
    _minorVersion = int.parse(spV[1]);
    _patchVersion = int.parse(spV[2]);

    _claimedFeatures = List<String>.from(decodeBaseJson["claimedFeatures"]);
    _tags = List<String>.from(decodeBaseJson["tags"]);
    _spolierTags = List<String>.from(decodeBaseJson["spolierTags"]);

    List<String> supportedLangStrings =
        List<String>.from(decodeBaseJson["supportLangs"]);
    // Parse lang
    for (var i = 0; i < supportedLangStrings.length; i++) {
      _supportedLanguages.add(codeToI18n(supportedLangStrings[i], lm));
    }

    // load localeJson
    if (localeJsonContent == null) {
      lm.logWarning(
          "$uid has no localeJson. Plz check.", "ExperienceModel/fromJson");
    } else {
      localeJsonContent.forEach((locale, json) {
        final localeJsonObj = jsonDecode(json);
        assert(localeJsonObj is Map);
        _name.addLocale(locale, localeJsonObj["name"]);
        _desc.addLocale(locale, localeJsonObj["desc"]);

        List<String> authors = List<String>.from(localeJsonObj['authors']);
        for (var i = 0; i < authors.length; i++) {
          _authors.addLocale(i, locale, authors[i]);
        }
      });
    }
  }
}
