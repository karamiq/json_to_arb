import 'dart:convert';
import 'dart:io';
import 'package:json_to_arb/models/file_name_case.dart';
import 'package:yaml/yaml.dart';
part 'package:json_to_arb/logger/logger.dart';
part 'package:json_to_arb/models/arb_to_json_model.dart';
part 'package:json_to_arb/models/langauge_model.dart';

part 'utils/pubspec.yamle_handler.dart';
part 'utils/get_json_files.dart';
part 'utils/get_languages.dart';
part 'utils/configuration.dart';
part 'utils/convert_jsons_to_one_arb.dart';
part 'utils/files_existing_checker.dart';
part 'utils/file_reader.dart';
part 'exceptions/exceptions.dart';
part 'package:json_to_arb/constants/keys.dart';
part 'utils/consistancy_checker.dart';

// - The tool automatically checks for missing and duplicate keys. --- IGNORE ---
// read the source, output, and locales from pubspec.yaml
final jsonToArbModel = config();

// Main function to execute the JSON to ARB conversion process
void main() {
  // get the list of languages and their corresponding JSON files
  final languages = getLanguages(jsonToArbModel.source, jsonToArbModel.locales);

  // convert JSON files to single ARB file per language
  convertJsonsToOneArb(languages);

  // check for consistancy between all JSON files
  if (jsonToArbModel.logging) {
    consistancyChecker(languages);
  }
}

// arb_directories:
//   source: lib/l10n
//   output: lib/l10n/app_arb
//   logging: true # optional, default is true
//   file_name_case: preserve # optional, default is preserve, other option is camel
//   locales:
//     - en
//     - ar
