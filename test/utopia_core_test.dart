import 'package:utopia_core/src/models/experience/item.dart';
import 'package:utopia_core/utopia_core.dart';
import 'package:test/test.dart';

void simulateTickPass(UtopiaWorld w, int ticks) {
  for (int i = 0; i < ticks; ++i) {
    w.tickExt();
  }
}

void main() {
  group('World Basic test', () {
    UtopiaWorld? worldToTest;
    setUp(() {
      // Create world
      worldToTest =
          UtopiaWorld.newWorld("TestLand", r"E:\utopia\utopia-demo-experience");
    });

    test('Test Creation', () {
      expect(worldToTest, isNotNull);
    });

    test('Test Tick', () {
      simulateTickPass(worldToTest!, 10);
      expect(worldToTest?.tickCounter, 10);
    });

    test('Item Load', () {
      final outAsset = worldToTest?.lib.getAsset<ItemModel>(
          'items/resources/wood', (worldToTest?.lm)!, ItemModel.fromFsJson,
          loadLocaleJson: true);
      expect(outAsset, isNotNull);
      expect(outAsset!.requireLocaleJson, isTrue);
      expect(outAsset.isFullLoad, isTrue);
      print(
          "Load Item ${outAsset.assetName}. item name is ${outAsset.name!.getPreferredLocaleString([
            I18nLanguage.zhhans,
            I18nLanguage.enus
          ])}. basename ${outAsset.assetBaseName}");
    });
  });
}
