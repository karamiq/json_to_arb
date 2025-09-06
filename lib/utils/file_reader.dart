part of '../json_to_arb.dart';

/// Reads all JSON files for a language and returns combined content
Map<String, dynamic> readAllJsonFilesForLanguage(LangaugeModel language) {
  final Map<String, dynamic> combinedContent = {};

  for (var jsonFile in language.jsonFiles) {
    try {
      final fileContent = readAndProcessJsonFile(jsonFile);
      combinedContent.addAll(fileContent);
    } on SkipFileException {
      continue;
    }
  }

  return combinedContent;
}

/// Reads and processes JSON file content with error handling.
///
/// Returns the processed content as a map with string keys and dynamic values.
Map<String, dynamic> readAndProcessJsonFile(File jsonFile) {
  try {
    // Read file content
    final fileContent = jsonFile.readAsStringSync();

    // Use the error handler, skip file if needed
    handleJsonFileErrors(fileContent, jsonFile.path);

    // Get filename without extension for flattening
    final fileName = jsonFile.path.split('/').last.split('.').first;

    // Parse JSON content
    final Map<String, dynamic> jsonMap = jsonDecode(fileContent);

    // Flatten the JSON with filename prefix
    final flattenedJson = flattenJson(jsonMap, parentKey: fileName);

    return flattenedJson;
  } on SkipFileException {
    Logger.warning('Skipping file due to previous error: ${jsonFile.path}');
    rethrow;
  } catch (e) {
    throw JsonToArbException(
      'Failed to read and process file ${jsonFile.path}: $e',
    );
  }
}

Map<String, dynamic> flattenJson(
  Map<String, dynamic> json, {
  String parentKey = '',
}) {
  final Map<String, dynamic> result = {};

  json.forEach((key, value) {
    final keyUpperFirstChar = key[0].toUpperCase() + key.substring(1);
    final newKey = parentKey.isEmpty ? key : '$parentKey$keyUpperFirstChar';
    if (value is Map<String, dynamic>) {
      result.addAll(flattenJson(value, parentKey: newKey));
    } else {
      result[newKey] = value;
    }
  });

  return result;
}
