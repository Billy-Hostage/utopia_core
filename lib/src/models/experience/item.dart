// Billy-Hostage 2023

import '../experience_model_base.dart';
import '../data_types.dart';
import '../../modules/logging/logging_module.dart';
import '../../general_utils.dart';

class ItemModel extends ExperienceModelBase {
  ItemModel.fromFsJson(super.fsJsonAsset, super.lm) : super.fromFsJson();
  ItemModel.fromFsJsonCore(super.fsJsonAsset, super.lm)
      : super.fromFsJsonCore();
  @override
  bool get requireLocaleJson => true;

  // Fields
  late final List<String> _tags;
  List<String> get tags => _tags;
  late final dynamic _additionalInfo;
  dynamic get additionalInfo => _additionalInfo;
  late final int _maxStackCount;
  int get maxStackCount => _maxStackCount;
  late final int _maxOwnCount;
  int get maxOwnCount => _maxOwnCount;

  LocalizableString? _name;
  LocalizableString? get name => _name;
  LocalizableString? _desc;
  LocalizableString? get desc => _desc;

  @override
  void deserializeFromJsonCore(baseJsonObject, LoggingModule lm) {
    _tags = safeGetFieldFromMap(baseJsonObject, "tags", []);
    _additionalInfo = safeGetFieldFromMap(baseJsonObject, "additionalInfo", []);
    _maxStackCount = safeGetFieldFromMap(baseJsonObject, "maxStackCount", 64);
    _maxOwnCount = safeGetFieldFromMap(baseJsonObject, "maxOwnCount", -1);
  }

  @override
  void deserializeFromJsonFull(baseJsonObject,
      Map<I18nLanguage, dynamic> localeJsonObjects, LoggingModule lm) {
    _name = LocalizableString("$assetName:name", lm);
    _desc = LocalizableString("$assetName:desc", lm);
    localeJsonObjects.forEach((locale, localeJsonObj) {
      _name?.addLocale(locale,
          safeGetFieldFromMap(localeJsonObj, "name", "LOCALE_NOT_FOUND:name"));
      _desc?.addLocale(locale,
          safeGetFieldFromMap(localeJsonObj, "desc", "LOCALE_NOT_FOUND:desc"));
    });
  }
}
