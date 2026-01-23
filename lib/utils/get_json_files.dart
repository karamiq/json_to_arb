part of '../json_to_arb.dart';

// Get all JSON files for a specific locale
List<File> getJsonFiles(String source, String locale) {
  final directory = Directory('$source/$locale');
  if (!directory.existsSync()) {
    throw Exception('[ERROR] Directory not found: $source/$locale');
  }
  try {
    // Recursively list all .json files in the directory and subdirectories
    final files = directory
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.json'))
        .toList();
    return files;
  } catch (e, stack) {
    Logger.error('Failed to list JSON files in $source/$locale: $e');
    throw JsonToArbException('Failed to list JSON files in $source/$locale: $e\n$stack');
  }
}
