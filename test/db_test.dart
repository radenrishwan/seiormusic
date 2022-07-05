import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  test('test initialize db', () {
    Hive.init('/hive_test');

    Hive.openBox("audio");

    Hive.close();
  });
}
