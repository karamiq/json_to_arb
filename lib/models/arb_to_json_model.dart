import 'package:json_to_arb/constants/keys.dart';
import 'package:yaml/yaml.dart';

// Model representing the configuration for JSON to ARB conversion
class JsonToArbModel {
  // Source directory containing JSON files
  final String source;
  // Output directory for generated ARB files
  final String output;
  // List of locale codes to process
  final List<String> locales;

  JsonToArbModel({required this.source, required this.output, required this.locales});

  // Factory constructor to create an instance from a YamlMap
  factory JsonToArbModel.fromYaml(YamlMap yaml) {
    return JsonToArbModel(
      source: yaml[Keys.source],
      output: yaml[Keys.output],
      locales: List<String>.from(yaml[Keys.locales]),
    );
  }
}
