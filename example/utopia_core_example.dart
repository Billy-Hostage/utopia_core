// Billy-Hostage

// TODO make this a debug-friendly cli interface for utopia core

import 'package:utopia_core/utopia_core.dart';

void simulateTickPass(UtopiaWorld w, int ticks) {
  for (int i = 0; i < ticks; ++i) {
    w.tickExt();
  }
}

void main() {
  UtopiaWorld worldToTest =
      UtopiaWorld.newWorld("TestLand", r"E:\utopia\utopia-demo-experience");
  simulateTickPass(worldToTest, 5);
}
