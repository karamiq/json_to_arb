part of '../json_to_arb.dart';
// this feature is not used currently but will be used in the future
// to check for missing files across different languages

bool checkFiles(List<LangaugeModel> languages) {
  // USING  the fileContents property in LangaugeModel to check for missing files
  if (languages.isEmpty) return false;
  // Collect all unique filenames across all languages
  final Set<String> allFileNames = {
    for (var lang in languages) ...lang.jsonFiles.map((f) => f.uri.pathSegments.last),
  };
  final Map<String, List<String>> missingFiles = {};
  for (var lang in languages) {
    final Set<String> langFileNames = lang.jsonFiles.map((f) => f.uri.pathSegments.last).toSet();
    final List<String> missing = allFileNames.where((fileName) => !langFileNames.contains(fileName)).toList();
    if (missing.isNotEmpty) {
      missingFiles[lang.code] = missing;
    }
  }

  if (missingFiles.isNotEmpty) {
    final buffer = StringBuffer("");
    missingFiles.forEach((locale, files) {
      buffer.write('  ➤ [$locale] is missing: $files');
    });
    Logger.warning(buffer.toString());
    return false;
  }
  Logger.info('All languages have consistent JSON files.');
  return true;
}

// bool checkFiles(List<LangaugeModel> languages) {
//   if (languages.isEmpty) return false;
  
//   // Collect all unique filenames across all languages
//   final Set<String> allFileNames = {
//     for (var lang in languages) ...lang.jsonFiles.map((f) => f.uri.pathSegments.last),
//   };

//   final Map<String, List<String>> missingFiles = {};


//   for (var lang in languages) {
//     final Set<String> langFileNames = lang.jsonFiles.map((f) => f.uri.pathSegments.last).toSet();

//     final List<String> missing = allFileNames.where((fileName) => !langFileNames.contains(fileName)).toList();

//     if (missing.isNotEmpty) {
//       missingFiles[lang.code] = missing;
//     }
//   }

//   if (missingFiles.isNotEmpty) {
//     final buffer = StringBuffer("");
//     missingFiles.forEach((locale, files) {
//       buffer.write('  ➤ [$locale] is missing: $files');
//     });

//     Logger.warning(buffer.toString());
//     return false;
//   }
//   return true;
// }
