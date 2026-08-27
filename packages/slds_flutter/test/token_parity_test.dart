import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('component styling does not define raw color literals', () {
    final componentDir = Directory('lib/src/components');
    final offenders = <String>[];

    for (final entity in componentDir.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }
      final text = entity.readAsStringSync();
      if (RegExp(r'Color\(0x[0-9a-fA-F]+\)').hasMatch(text) ||
          RegExp(r'#[0-9a-fA-F]{6,8}').hasMatch(text)) {
        offenders.add(entity.path);
      }
    }

    expect(offenders, isEmpty);
  });
}
