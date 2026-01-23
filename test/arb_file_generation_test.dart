import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_to_arb/json_to_arb.dart';

void main() {
  group('ARB File Generation', () {
    test('Generates ARB files from sample JSONs', () {
      // Setup: create a temp directory structure with sample JSON files
      final tempDir = Directory.systemTemp.createTempSync('json_to_arb_test');
      final sourceDir = Directory('${tempDir.path}/l10n');
      final enDir = Directory('${sourceDir.path}/en')..createSync(recursive: true);
      final arDir = Directory('${sourceDir.path}/ar')..createSync(recursive: true);
      final outputDir = Directory('${sourceDir.path}/app_arb')..createSync(recursive: true);

      // Write sample JSON files
      File(
        '${enDir.path}/app.json',
      ).writeAsStringSync('{"welcome": "Welcome", "home": {"title": "Home Title"}}');
      File(
        '${arDir.path}/app.json',
      ).writeAsStringSync('{"welcome": "مرحبا", "home": {"title": "عنوان الصفحة الرئيسية"}}');

      // Write a minimal pubspec.yaml for config
      File('${tempDir.path}/pubspec.yaml').writeAsStringSync('''
json_to_arb:
  source: l10n
  output: l10n/app_arb
  locales:
    - en
    - ar
''');

      // Run the conversion
      final model = JsonToArbModel(
        source: '${sourceDir.path}',
        output: '${outputDir.path}',
        locales: ['en', 'ar'],
      );
      final languages = getLanguages(model.source, model.locales);
      convertJsonsToOneArb(languages);

      // Assert ARB files exist and contain expected keys
      final enArb = File('${outputDir.path}/app_en.arb');
      final arArb = File('${outputDir.path}/app_ar.arb');
      expect(enArb.existsSync(), isTrue);
      expect(arArb.existsSync(), isTrue);
      final enContent = enArb.readAsStringSync();
      final arContent = arArb.readAsStringSync();
      expect(enContent.contains('appWelcome'), isTrue);
      expect(enContent.contains('appHomeTitle'), isTrue);
      expect(arContent.contains('appWelcome'), isTrue);
      expect(arContent.contains('appHomeTitle'), isTrue);

      // Cleanup
      tempDir.deleteSync(recursive: true);
    });
  });
}
