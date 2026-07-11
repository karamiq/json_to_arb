part of '../json_to_arb.dart';

/// Reads all JSON files for a language and returns combined content
Map<String, dynamic> readAllJsonFilesForLanguage(
  LangaugeModel language,
  JsonToArbModel model,
) {
  final Map<String, dynamic> combinedContent = {};

  for (var jsonFile in language.jsonFiles) {
    try {
      final fileContent = readAndProcessJsonFile(jsonFile, model);
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
Map<String, dynamic> readAndProcessJsonFile(
  File jsonFile,
  JsonToArbModel model,
) {
  try {
    // Read file content
    final fileContent = jsonFile.readAsStringSync();

    // Use the error handler, skip file if needed
    handleJsonFileErrors(fileContent, jsonFile.path);

    // Build a source-relative path then remove the locale segment if present.
    final normalizedSource = model.source.replaceAll('\\', '/');
    final normalizedPath = jsonFile.path.replaceAll('\\', '/');

    String relativePath = normalizedPath;
    if (relativePath.startsWith(normalizedSource)) {
      relativePath = relativePath.substring(normalizedSource.length);
    }
    if (relativePath.startsWith('/')) {
      relativePath = relativePath.substring(1);
    }

    final parts = relativePath
        .split('/')
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isNotEmpty && model.locales.contains(parts.first)) {
      parts.removeAt(0);
    }

    if (parts.isEmpty) {
      throw JsonToArbException(
        'Could not derive key prefix from path: ${jsonFile.path}',
      );
    }

    String fileName = parts.first.replaceAll('.json', '').replaceAll('.', '');
    for (int i = 1; i < parts.length; i++) {
      String word = parts[i].replaceAll('.json', '').replaceAll('.', '');
      String capitalized = word[0].toUpperCase() + word.substring(1);

      fileName += capitalized;
    }

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
