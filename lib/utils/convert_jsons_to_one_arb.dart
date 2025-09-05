part of '../json_to_arb.dart';

/// Converts a list of language JSON files to a single ARB format.
/// Handles empty and malformed JSON files gracefully.

void convertJsonsToOneArb(List<LangaugeModel> languages, JsonToArbModel jsonToArbModel) {
  try {
    for (var language in languages) {
      // Use the new file reader function to get all content for this language
      final arbContent = readAllJsonFilesForLanguage(language);

      // Write the ARB file
      final arbFileName = '${jsonToArbModel.output}/app_${language.code}.arb';
      final arbFile = File(arbFileName);
      final encoder = JsonEncoder.withIndent('  ');
      arbFile.writeAsStringSync(encoder.convert(arbContent));
      Logger.success('Generated ARB file: $arbFileName');
    }
    Logger.success('All ARB files generated successfully.');
  } catch (e, stack) {
    throw JsonToArbException('Failed to convert JSON to ARB: $e\n$stack');
  }
}

/// Handles JSON file content errors: empty, malformed, or wrong root type.
void handleJsonFileErrors(String fileContent, String filePath) {
  if (fileContent.trim().isEmpty) {
    throw SkipFileException('[ERROR] JSON file is empty, skipping: $filePath');
  }
  try {
    final dynamic decoded = jsonDecode(fileContent);
    if (decoded is! Map<String, dynamic>) {
      throw FormatException('[ERROR] JSON root is not a Map: $filePath');
    }
  } catch (e) {
    if (e is SkipFileException) rethrow;
    throw FormatException('[ERROR] Failed to parse JSON in file: $filePath\n$e');
  }
}
