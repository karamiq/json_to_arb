part of '../json_to_arb.dart';

/// Configuration model for JSON to ARB conversion.
///
/// Contains source/output paths, target locales, and formatting options.
class JsonToArbModel {
  /// Source directory containing JSON files.
  /// Example: 'assets/locales/json' or 'lib/i18n/json'
  final String source;

  /// Output directory for generated ARB files.
  /// Example: 'lib/l10n' or 'assets/arb'
  final String output;

  /// List of target locale codes (e.g., ['en', 'es', 'fr']).
  /// Example: ['en', 'ar', 'fr'] generates app_en.arb, app_ar.arb, app_fr.arb
  final List<String> locales;

  /// Enable/disable conversion logging (default: true).
  /// Example: false = silent mode, true = show progress messages
  final bool logging;

  /// File name and key case conversion: preserve original or convert to camelCase.
  /// Example: home_screen.json → preserve: 'home_screen' keys, camel: 'homeScreen' keys
  //final FileNameCase fileNameCase;

  /// Creates a JsonToArbModel with required source, output, and locales.
  JsonToArbModel({
    required this.source,
    required this.output,
    required this.locales,
    this.logging = true,
    // this.fileNameCase = FileNameCase.camel,
  });

  /// Creates a JsonToArbModel from YAML configuration.
  factory JsonToArbModel.fromYaml(YamlMap yaml) {
    return JsonToArbModel(
      source: yaml[Keys.source],
      output: yaml[Keys.output],
      locales: List<String>.from(yaml[Keys.locales]),
      logging: yaml[Keys.logging] ?? true,
      //  fileNameCase: FileNameCase.fromYaml(yaml[Keys.fileNameCase]),
    );
  }
}
