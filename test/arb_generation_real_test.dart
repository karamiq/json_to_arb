import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_to_arb/json_to_arb.dart';

void main() {
  group('Real ARB Generation', () {
    test('Generates ARB files from test_l10n JSONs', () {
      // Setup: use the test_l10n directory and config
      final sourceDir = Directory('test_l10n');
      final outputDir = Directory('test_l10n/app_arb');
      final locales = ['en', 'ar'];
      // Use the config model directly
      final model = JsonToArbModel(source: sourceDir.path, output: outputDir.path, locales: locales);
      final languages = getLanguages(model.source, model.locales);
      convertJsonsToOneArb(languages, model);

      // Assert ARB files exist and contain expected keys
      final enArb = File('${outputDir.path}/app_en.arb');
      final arArb = File('${outputDir.path}/app_ar.arb');
      expect(enArb.existsSync(), isTrue);
      expect(arArb.existsSync(), isTrue);
      final enContent = enArb.readAsStringSync();
      final arContent = arArb.readAsStringSync();
      // Check for generated keys and file-based prefixes
      expect(enContent.contains('appKey0'), isTrue);
      expect(enContent.contains('firstExtraKey1'), isTrue);
      expect(enContent.contains('firstSecond2Key2'), isTrue);
      expect(enContent.contains('firstSecondExtraKey2'), isTrue);
      expect(enContent.contains('firstSecondThird3Key3'), isTrue);
      expect(enContent.contains('firstSecondThirdExtraKey3'), isTrue);
      expect(arContent.contains('appKey0'), isTrue);
      expect(arContent.contains('firstExtraKey1'), isTrue);
      expect(arContent.contains('firstSecond2Key2'), isTrue);
      expect(arContent.contains('firstSecondExtraKey2'), isTrue);
      expect(arContent.contains('firstSecondThird3Key3'), isTrue);
      expect(arContent.contains('firstSecondThirdExtraKey3'), isTrue);
    });
  });
}
