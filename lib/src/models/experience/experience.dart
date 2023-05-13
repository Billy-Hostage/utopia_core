// Billy-Hostage 2023

import '../experience_model_base.dart';
import '../data_types.dart';
import '../../modules/logging/logging_module.dart';

// Model for experience.*.json at exp pack's root
// no protection is here. This asset can failed to load and cause exceptions.
class ExperienceModel extends ExperienceModelBase {
  ExperienceModel.fromFsJson(super.fsJsonAsset, super.lm) : super.fromFsJson();
  ExperienceModel.fromFsJsonCore(super.fsJsonAsset, super.lm)
      : super.fromFsJsonCore();
  @override
  bool get requireLocaleJson => true;

  // Fields
  late final String _version;
  String get version => _version;
  late final String _identifier;
  String get identifier => _identifier;
  late final String _url;
  String get url => _url;

  // exp version
  late final int _majorVersion;
  late final int _minorVersion;
  late final int _patchVersion;
  String get expVersionFull => "$_majorVersion.$_minorVersion.$_patchVersion";

  late final List<String> _claimedFeatures;
  List<String> get claimedFeatures => _claimedFeatures;
  List<String>? _tags;
  List<String>? get tags => _tags;
  List<String>? _spolierTags;
  List<String>? get spolierTags => _spolierTags;

  late final List<I18nLanguage> _supportedLanguages;
  List<I18nLanguage> get supportedLanguages => _supportedLanguages;

  // Localizable Stuff may not be loaded.

  LocalizableString? _name;
  LocalizableString? get lName => _name;
  LocalizableString? _desc;
  LocalizableString? get lDesc => _desc;
  LocalizableStringList? _authors;
  LocalizableStringList? get llAuthors => _authors;

  @override
  void deserializeFromJsonCore(baseJsonObject, LoggingModule lm) {
    // setup members
    _version = baseJsonObject["version"];
    _identifier = baseJsonObject["identifier"];
    _url = baseJsonObject["url"];

    String expVersion = baseJsonObject["expVersion"];
    // Parse version
    final spV = expVersion.split('.');
    assert(spV.length >= 3);
    _majorVersion = int.parse(spV[0]);
    _minorVersion = int.parse(spV[1]);
    _patchVersion = int.parse(spV[2]);

    _claimedFeatures = List<String>.from(baseJsonObject["claimedFeatures"]);

    List<String> supportedLangStrings =
        List<String>.from(baseJsonObject["supportLangs"]);
    assert(supportedLangStrings.isNotEmpty);
    _supportedLanguages = [];
    // Parse lang
    for (var i = 0; i < supportedLangStrings.length; i++) {
      _supportedLanguages.add(codeToI18n(supportedLangStrings[i], lm));
    }
  }

  @override
  void deserializeFromJsonFull(baseJsonObject,
      Map<I18nLanguage, dynamic> localeJsonObjects, LoggingModule lm) {
    _name = LocalizableString("$assetName:name", lm);
    _desc = LocalizableString("$assetName:desc", lm);
    _authors = LocalizableStringList("$assetName:authors", lm);
    _tags = List<String>.from(baseJsonObject["tags"]);
    _spolierTags = List<String>.from(baseJsonObject["spolierTags"]);

    localeJsonObjects.forEach((locale, localeJsonObj) {
      _name?.addLocale(locale, localeJsonObj["name"]);
      _desc?.addLocale(locale, localeJsonObj["desc"]);

      List<String> authors = List<String>.from(localeJsonObj['authors']);
      for (var i = 0; i < authors.length; i++) {
        _authors?.addLocale(i, locale, authors[i]);
      }
    });
  }
}
