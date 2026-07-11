part of '../json_to_arb.dart';

// Load all languages based on the provided locales
List<LangaugeModel> getLanguages(String source, List<String> locales) {
  final List<LangaugeModel> languages = [];
  for (var locale in locales) {
    // Get all JSON files for the current locale
    final jsonFiles = getJsonFiles(source, locale);
<<<<<<< HEAD
    final language = LangaugeModel(code: locale, jsonFiles: jsonFiles);
=======
    final language = LangaugeModel(
      filesContents: const <File, Map<String, dynamic>>{},
      code: locale,
      jsonFiles: jsonFiles,
    );
>>>>>>> nested-folders
    languages.add(language);
  }
  return languages;
}
