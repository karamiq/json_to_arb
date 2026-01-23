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
      // Check for nested keys (camelCase)
      expect(enContent.contains('profileSettingsPrivacy'), isTrue);
      expect(arContent.contains('profileSettingsPrivacy'), isTrue);
      // Check for other keys (camelCase)
      expect(enContent.contains('appWelcome'), isTrue);
      expect(arContent.contains('appWelcome'), isTrue);
      expect(enContent.contains('homeTitle'), isTrue);
      expect(arContent.contains('homeTitle'), isTrue);
      expect(enContent.contains('profileUsername'), isTrue);
      expect(arContent.contains('profileUsername'), isTrue);
    });
  });
}
