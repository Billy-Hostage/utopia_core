// Billy-Hostage 2023

import '../../modules/logging/logging_module.dart';

enum OutcomeType { getItem, unknown }

OutcomeType stringToOutcomeType(String inStr, LoggingModule? lm) {
  final pattern = inStr.toLowerCase().replaceAll(RegExp(r"[_-]"), "");
  switch (pattern) {
    case "getitem":
      return OutcomeType.getItem;
  }
  lm?.logError("Unknown outcome type $inStr", "types/codeToI18n");
  return OutcomeType.unknown;
}

class Outcome {
  Outcome(this._type, this._content);

  final OutcomeType _type;
  OutcomeType get type => _type;

  // Content needs to be processed sepreratly with type
  final Map<String, dynamic> _content;
  Map<String, dynamic> get cotnent => _content;
}
