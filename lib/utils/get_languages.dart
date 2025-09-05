part of '../json_to_arb.dart';

// Load all languages based on the provided locales
List<LangaugeModel> getLanguages(String source, List<String> locales) {
  final List<LangaugeModel> languages = [];
  for (var locale in locales) {
    // Get all JSON files for the current locale
    final jsonFiles = getJsonFiles(source, locale);
    final language = LangaugeModel(
      // extracting the file contents for each JSON file
      filesContents: {
        for (var file in jsonFiles) file: readAndProcessJsonFile(file),
      },
      code: locale,
      jsonFiles: jsonFiles,
    );
    languages.add(language);
  }
  return languages;
}
