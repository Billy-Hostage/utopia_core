// Billy-Hostage 2023

import 'models/data_types.dart';

dynamic safeGetFieldFromMap(Map obj, dynamic key, dynamic def) {
  if (obj.containsKey(key)) {
    return obj[key];
  }
  return def;
}

List<Selectable> safeGetSelectableListFromMap<T>(
    Map obj, dynamic key, T defElement) {
  if (obj.containsKey(key)) {
    var raw = obj[key];
    if (raw is List) {
      // try parse out selectables
      var out = [];
      for (var e in raw) {
        if (e is Map) {
          var tryParse = tryParseSelector(e, defElement);
          if (tryParse is Selector) {
            out.add(tryParse);
          } else {
            out.add(e);
          }
        } else {
          out.add(e);
        }
      }
      return out;
    }
    return [];
  }
  return [];
}

Selector? tryParseSelector<T>(Map obj, T defVal) {
  if (obj.containsKey("value") && obj.containsKey("cond")) {
    return Selector<T>(obj, defVal);
  }
  return null;
}
