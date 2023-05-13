// Billy-Hostage 2023

dynamic safeGetFieldFromMap(Map obj, dynamic key, dynamic def) {
  if (obj.containsKey(key)) {
    return obj[key];
  }
  return def;
}
