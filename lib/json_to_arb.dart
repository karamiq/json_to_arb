import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:watcher/watcher.dart';
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

// read the source, output, and locales from pubspec.yaml or json_to_arb.yaml
final _jsonToArbModel = config();

// Main function to execute the JSON to ARB conversion process
void main(List<String> arguments) {
  final watchMode = arguments.contains('--watch') || arguments.contains('-w');

  if (watchMode) {
    _runWatch();
  } else {
    _runOnce();
  }
}

/// Runs the conversion a single time (original behavior).
void _runOnce() {
  final languages = getLanguages(
    _jsonToArbModel.source,
    _jsonToArbModel.locales,
  );

  convertJsonsToOneArb(languages);

  if (_jsonToArbModel.logging) {
    consistancyChecker(languages, _jsonToArbModel);
  }
}

/// Watches the source directory for JSON changes and re-runs
/// the conversion automatically, debounced to avoid duplicate
/// triggers from editors that emit multiple write events per save.
void _runWatch() {
  final watcher = DirectoryWatcher(_jsonToArbModel.source);
  Timer? debounce;

  stdout.writeln(
    'json_to_arb: watching "${_jsonToArbModel.source}" for changes...',
  );
  _runOnce(); // run once immediately on startup

  watcher.events.listen((event) {
    if (!event.path.endsWith('.json')) return;

    debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 200), () {
      stdout.writeln(
        'json_to_arb: change detected (${event.path}), regenerating...',
      );
      try {
        _runOnce();
        stdout.writeln('json_to_arb: done.');
      } catch (e) {
        stdout.writeln('json_to_arb: error during regeneration -> $e');
      }
    });
  });
}
