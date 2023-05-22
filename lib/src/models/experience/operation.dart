// Billy-Hostage

import '../data_types.dart';
import '../experience_model_base.dart';
import '../../modules/logging/logging_module.dart';

class OperationModel extends ExperienceModelBase {
  OperationModel.fromFsJsonCore(super.fsJsonAsset, super.lm)
      : super.fromFsJsonCore();
  OperationModel.fromFsJson(super.fsJsonAsset, super.lm) : super.fromFsJson();

  @override
  void deserializeFromJsonCore(baseJsonObject, LoggingModule lm) {
    // TODO: implement deserializeFromJsonCore
  }

  @override
  void deserializeFromJsonFull(baseJsonObject,
      Map<I18nLanguage, dynamic> localeJsonObjects, LoggingModule lm) {
    // TODO: implement deserializeFromJsonFull
  }
}
