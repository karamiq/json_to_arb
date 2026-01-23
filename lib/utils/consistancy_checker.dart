part of '../json_to_arb.dart';

void consistancyChecker(List<LangaugeModel> languages) {
  if (languages.isEmpty) {
    Logger.info('No languages found for consistency check.');
    return;
  }

  _checkMissingKeys(languages);
  _checkDuplicateValues(languages);
  Logger.success('Consistency check completed.');
}

/// Check for missing keys across all languages
/// Compares each language against the first one as a reference
/// Logs any missing or extra keys found
void _checkMissingKeys(List<LangaugeModel> languages) {
  final referenceKeys = readAllJsonFilesForLanguage(
    languages.first,
  ).keys.toSet();

  for (var language in languages.skip(1)) {
    final currentKeys = readAllJsonFilesForLanguage(language).keys.toSet();

    final missingKeys = referenceKeys.difference(currentKeys);
    final extraKeys = currentKeys.difference(referenceKeys);

    if (missingKeys.isNotEmpty) {
      Logger.error(
        'Language "${language.code}" missing: ${missingKeys.join(', ')}',
      );
    }
    if (extraKeys.isNotEmpty) {
      Logger.error(
        'Language "${language.code}" extra: ${extraKeys.join(', ')}',
      );
    }
  }
}

void _checkDuplicateValues(List<LangaugeModel> languages) {
  bool foundDuplicates = false;

  for (var language in languages) {
    final valueMap = <String, List<KeyFileInfo>>{};

    for (var jsonFile in language.jsonFiles) {
      try {
        final fileName = jsonFile.path.split('/').last;
        final content = readAndProcessJsonFile(jsonFile);

        content.forEach((key, value) {
          if (value is String && value.trim().isNotEmpty) {
            valueMap
                .putIfAbsent(value.trim(), () => [])
                .add(KeyFileInfo(key, fileName));
          }
        });
      } catch (e) {
        Logger.yellow('Skipping ${jsonFile.path}: $e');
      }
    }

    final duplicates = Map.fromEntries(
      valueMap.entries.where((entry) => entry.value.length > 1),
    );

    if (duplicates.isNotEmpty) {
      foundDuplicates = true;
      _reportLanguageDuplicates(language.code, duplicates);
    } else {
      Logger.success('✓ No duplicates in ${language.code}');
    }
  }

  if (!foundDuplicates) {
    Logger.success('✓ No duplicate values found.');
  }
}

void _reportLanguageDuplicates(
  String languageCode,
  Map<String, List<KeyFileInfo>> duplicates,
) {
  Logger.yellow('\n${'=' * 50}');
  Logger.yellow('🔄 DUPLICATES - ${languageCode.toUpperCase()}');
  Logger.yellow('=' * 50);

  int count = 0;
  duplicates.forEach((value, keyInfos) {
    count++;
    final fileGroups = <String, List<String>>{};

    for (var info in keyInfos) {
      fileGroups.putIfAbsent(info.fileName, () => []).add('"${info.key}"');
    }

    Logger.yellow('\n📋 #$count:');
    fileGroups.forEach((file, keys) {
      Logger.yellow('   • $file → ${keys.join(', ')}');
    });
  });

  Logger.yellow('\n📊 ${duplicates.length} duplicate(s) in $languageCode');
  Logger.yellow('=' * 50);
}

class KeyFileInfo {
  final String key;
  final String fileName;

  const KeyFileInfo(this.key, this.fileName);
}
