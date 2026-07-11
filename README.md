# json_to_arb


A powerful Dart command-line tool that revolutionizes Flutter localization workflows. Instead of managing massive, unwieldy ARB files, `json_to_arb` enables you to organize translations in multiple modular JSON files (per feature, module, or screen) for each language, then automatically merges them into a single ARB file per locale—ready for Flutter's official localization system.

**Now with full support for nested folders and automatic key prefixing based on file/folder structure!**

This tool provides indirect support for Flutter's built-in internationalization, bridging the gap between developer-friendly JSON organization and Flutter's ARB requirements.

---

**Note:** While `json_to_arb` is designed to work as a layer above Flutter's official localization system, it can technically be used separately to merge and manage JSON translation files. However, standalone usage is not its primary purpose, and full benefits are realized when used with Flutter's localization workflow.

## Why Use json_to_arb?

**The Problem:** Flutter localization forces you to manage all translations in one massive ARB file, leading to merge conflicts, maintenance nightmares, and team collaboration issues.

**The Solution:** json_to_arb transforms your workflow by allowing you to:

• **Multiple Files → Single ARB**: Organize translations in separate JSON files (login.json, profile.json, etc.) instead of one massive ARB file
• **Better Organization**: Group translations by feature, not by language
• **Team-Friendly Development**: Each developer works on their feature's translations independently
• **Automatic Merging**: One command converts all your JSON files to Flutter-ready ARB
• **Zero Configuration Overhead**: Works seamlessly with Flutter's official localization system

---

## Installation
**Note:** This package is intended for development use only. Add it to your `dev_dependencies` so it is not included in your production build.

Add to your `pubspec.yaml`:
```yaml
dev_dependencies:
   json_to_arb: ^0.2.0
```
Then run:
```
flutter pub get
```



## Configuration

- You can use either a `json_to_arb.yaml` file (recommended for advanced setups) or a section in your `pubspec.yaml` for configuration.
- If `json_to_arb.yaml` exists, it will be used; otherwise, the tool falls back to `pubspec.yaml`.

**Important:** The `json_to_arb` configuration must be at the root of your `pubspec.yaml`, not under `flutter:`.

Example:
```yaml
...

dependencies:
...

dev_dependencies:
   ...
   json_to_arb: 0.2.0
   ...

flutter:
...

json_to_arb:
   source: lib/l10n
   output: lib/l10n/app_arb
   locales:
      - en
      - ar
      ...Other locals
...
```

Your Flutter localization config must match:
```yaml
flutter:
   generate: true
   arb-dir: lib/l10n/app_arb
   template-arb-file: app_en.arb
   output-localization-file: app_localizations.dart
```

- The `output` in json_to_arb and `arb-dir` in flutter must be the same directory.
- The ARB files generated (e.g., app_en.arb, app_ar.arb) must be in this directory.
- The template ARB file (usually app_en.arb) must exist for code generation.
- The generated Dart file (app_localizations.dart) will be used in your app.

**Troubleshooting:**
- If you see `Missing "json_to_arb" section in pubspec.yaml`, make sure the config is at the root, not under `flutter:`.

## Usage

1. **Organize your JSON files**
   How the folders structure would be like:

   ```
   lib/l10n/
   ├── en/
   │   ├── app.json
   │   ├── home.json
   │   └── profile/
   │       └── settings.json
   ├── ar/
   │   ├── app.json
   │   ├── home.json
   │   └── profile/
   │       └── settings.json
   │   ...Other languages
   └── app_arb/
       ├── app_en.arb     # generated
       ├── app_ar.arb     # generated
       └── ...Other languages
   ```

Errors and warnings are printed in color for easy debugging.

### Error and Warning Logs

`json_to_arb` provides clear error and warning logs to help you quickly identify and resolve issues during the localization workflow. Common logs include:

- **Duplicate Key Detection:** Alerts when the same key appears in multiple JSON files for a locale, with details on file locations and key names.
- **Missing Configuration:** Notifies if required configuration sections (such as `json_to_arb` in `pubspec.yaml` or `json_to_arb.yaml`) are absent or incorrectly placed.
- **Invalid JSON Format:** Reports syntax errors or malformed JSON files that cannot be parsed.
- **File/Folder Issues:** Warns about missing source/output directories or inaccessible files.
- **General Warnings:** Any other issues that may affect ARB generation or localization integrity.
- **Skip Deduplication:** A file that is skipped because of an error is reported once, even if the consistency check revisits it later.

All logs are printed in color for easy visibility in the terminal.

**Duplicate Key Detection:**
If duplicate keys are found across your JSON files, the tool prints a clear log like:
```
==================================================
🔄 DUPLICATES - EN
==================================================

📋 #1:
   • extra.json → "FirstSecondThirdExtraKey3"
   • 3.json → "FirstSecondThird3Key3"

📋 #2:
   • extra.json → "FirstSecondExtraKey2"
   • 2.json → "FirstSecond2Key2"

📊 2 duplicate(s) in en
==================================================
```

---

**Changelog highlights:**
- Support for nested folders
- Configuration can be in json_to_arb.yaml or pubspec.yaml
- Improved error messages and duplicate key logging
- Skipped file warnings are deduplicated across generation and consistency checks
- Full compatibility with Flutter offical localization

## Contributing
Contributions are welcome! If you have ideas, bug reports, or feature requests, please open an issue or submit a pull request on GitHub:

- Fork the repository
- Create your feature branch (`git checkout -b feature/my-feature`)
- Commit your changes (`git commit -am 'Add new feature'`)
- Push to the branch (`git push origin feature/my-feature`)
- Open a pull request

Please make sure your code follows the existing style and includes relevant documentation and tests if applicable.
