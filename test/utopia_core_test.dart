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
  });
}
