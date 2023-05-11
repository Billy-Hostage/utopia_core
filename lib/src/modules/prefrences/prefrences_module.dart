//Billy-Hostage 2023

import '../utopia_module_base.dart';

import '../../models/data_types.dart';

class PrefrencesModule extends ModuleBase {
  PrefrencesModule(super.w);

  PrefrencesModule.fromPersistence(super.w, String persistPath) {
    //TODO
  }

  @override
  void describe() {
    // TODO: implement describe
  }

  final List<I18nLanguage> _preferredLangList = [
    I18nLanguage.zhhans,
    I18nLanguage.enus // TODO
  ];
  List<I18nLanguage> get preferredLangList => _preferredLangList;
}
