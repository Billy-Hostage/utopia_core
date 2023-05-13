// Currently useless

abstract class AbA {
  AbA.con() {
    print("AbA::con");
    testFunc1();
  }

  void testFunc1() {
    print("AbA::func1");
  }

  void testFunc2();

  bool get testBool => false;
}

class B extends AbA {
  B.con() : super.con() {
    print("B::con $testBool");
  }

  @override
  void testFunc1() {
    print("B::func1");
  }

  @override
  void testFunc2() {
    print("B::func2");
  }

  @override
  bool get testBool => true;
}

void main() {
  print('awesome!');
  final b = B.con();
}
