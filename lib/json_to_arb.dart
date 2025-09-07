import 'dart:convert';
import 'dart:io';
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

// - The tool automatically checks for missing and duplicate keys. --- IGNORE ---

// Main function to execute the JSON to ARB conversion process
void main() {
  // read the source, output, and locales from pubspec.yaml
  final arbToJsonModel = config();

  // get the list of languages and their corresponding JSON files
  final languages = getLanguages(arbToJsonModel.source, arbToJsonModel.locales);

  // convert JSON files to single ARB file per language
  convertJsonsToOneArb(languages, arbToJsonModel);
}

// arb_directories:
//   source: lib/l10n
//   output: lib/l10n/app_arb
//   locales:
//     - en
//     - ar
