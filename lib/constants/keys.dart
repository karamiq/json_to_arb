part of '../json_to_arb.dart';

/// Configuration keys used in pubspec.yaml for json_to_arb setup
class Keys {
  /// The root configuration section name in pubspec.yaml
  static const String jsonToArb = 'json_to_arb';

  /// Path to the directory containing language folders with JSON files
  /// Example: 'lib/l10n' (contains en/, ar/, etc. folders)
  static const String source = 'source';

  /// Path to the output directory where ARB files will be generated
  /// Must match the 'arb-dir' in Flutter's localization configuration
  /// Example: 'lib/l10n/app_arb'
  static const String output = 'output';

  /// List of locale codes to process
  /// Example: ['en', 'ar', 'fr']
  static const String locales = 'locales';
}
