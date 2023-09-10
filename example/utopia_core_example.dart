// Billy-Hostage 2023

// This is a debug-friendly cli interface for utopia core
import 'dart:io';
import 'package:utopia_core/src/models/experience/item.dart';
import 'package:utopia_core/src/models/experience/location.dart';
import 'package:utopia_core/utopia_core.dart';

void simulateTickPass(UtopiaWorld w, int ticks) {
  for (int i = 0; i < ticks; ++i) {
    w.tickExt();
  }
}

void cmdTick(UtopiaWorld w, List<String> fullArgs) {
  assert(fullArgs.isNotEmpty);
  int times = fullArgs.length >= 2 ? int.parse(fullArgs[1]) : 1;
  simulateTickPass(w, times);
}

void getLocation(UtopiaWorld w, String name, [String? lanCode]) {
  var ast =
      w.lib.getAsset<LocationModel>(name, w.log, LocationModel.fromFsJson);
  if (lanCode != null) {
    stdout.writeln(ast!.toLocalString(lanCode));
  } else {
    stdout.writeln(ast);
  }
}

void getItem(UtopiaWorld w, String name, [String? lanCode]) {
  var ast = w.lib.getAsset<ItemModel>(name, w.log, ItemModel.fromFsJson);
  if (lanCode != null) {
    stdout.writeln(ast!.toLocalString(lanCode));
  } else {
    stdout.writeln(ast);
  }
}

void cmdGet(UtopiaWorld w, List<String> fullArgs) {
  assert(fullArgs.length >= 2);
  String subType = fullArgs[1];
  switch (subType.toLowerCase().trim()) {
    case 'item':
      assert(fullArgs.length >= 3);
      if (fullArgs.length >= 4) {
        getItem(w, fullArgs[2], fullArgs[3]);
      } else {
        getItem(w, fullArgs[2]);
      }
      break;
    case 'location':
      assert(fullArgs.length >= 3);
      if (fullArgs.length >= 4) {
        getLocation(w, fullArgs[2], fullArgs[3]);
      } else {
        getLocation(w, fullArgs[2]);
      }
    default:
      throw UnimplementedError("subType \"$subType\" not implemented as get.");
  }
}

bool inputLoop(UtopiaWorld w) {
  stdout.write("!> ");
  String? input = stdin.readLineSync();
  if (input == null) {
    return false;
  }

  // segment
  var cmdList = input.split(" ");
  if (cmdList.isEmpty) return true;
  // parse
  try {
    switch (cmdList[0].toLowerCase().trim()) {
      case "exit":
      case "quit":
        return false; // quit
      case "tick":
        cmdTick(w, cmdList);
        break;
      case "get":
        cmdGet(w, cmdList);
        break;
      case "":
        break;
      default:
        throw UnimplementedError("command \"${cmdList[0]}\" not implemented.");
    }
  } catch (e, stacktrace) {
    stderr.writeln(e);
    stderr.writeln(stacktrace);
  }

  return true;
}

void main() {
  UtopiaWorld worldToTest =
      UtopiaWorld.newWorld("TestLand", r"E:\utopia\utopia-demo-experience");
  while (inputLoop(worldToTest)) {}
}
