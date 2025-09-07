# json_to_arb

A powerful Dart command-line tool that revolutionizes Flutter localization workflows. Instead of managing massive, unwieldy ARB files, `json_to_arb` enables you to organize translations in multiple modular JSON files (per feature, module, or screen) for each language, then automatically merges them into a single ARB file per locale—ready for Flutter's official localization system.

This tool provides indirect support for Flutter's built-in internationalization, bridging the gap between developer-friendly JSON organization and Flutter's ARB requirements.

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
   json_to_arb: ^0.1.14
```
Then run:
```
flutter pub get
```


## Usage

1. **Add your JSON files**
   Organize by language and feature/module:
   ```
   lib/l10n/en/app.json
   lib/l10n/en/home.json
   lib/l10n/ar/app.json
   lib/l10n/ar/home.json
   ```

2. **Configure your project**
   In your `pubspec.yaml`, add the `json_to_arb` configuration section:
   ```yaml
   json_to_arb:
     source: lib/l10n           # Directory containing language folders (en/, ar/, etc.)
     output: lib/l10n/app_arb   # Output directory for generated ARB files
     locales:                   # List of locale codes to process
       - en
       - ar
   ```
   
   **Configuration Keys:**
   - **`source`**: Directory containing your language folders with JSON files
   - **`output`**: Directory where ARB files will be generated (must match Flutter's `arb-dir`)
   - **`locales`**: Array of locale codes you want to support
   
   **Important:** The `output` path must match the `arb-dir` in your Flutter `pubspec.yaml`:
   ```yaml
   flutter:
     generate: true
     # arb-dir: lib/l10n/app_arb
   ```
   This ensures ARB files are picked up automatically by Flutter's localization system.

3. **Run the converter**
   
   **Option 1: Project dependency**
   ```
   dart run json_to_arb
   ```
   
   **Option 2: Global CLI**
   ```sh
   # Install globally once
   dart pub global activate json_to_arb
   
   # Then run from anywhere
   json_to_arb
   ```


## Output Example
ARB files are created for each language:
```
lib/l10n/app_arb/app_en.arb
lib/l10n/app_arb/app_ar.arb
```

**Sample JSON:**
```json
{
   "welcome": "Welcome",
   "home": {
      "title": "Home Title"
   }
}
```

**Resulting ARB:**
```json
{
   "appWelcome": "Welcome",
   "appHomeTitle": "Home Title"
}
```

## Accessing Translations in Flutter
After generating ARB files and running Flutter's localization code generation:
```dart
AppLocalizations.of(context)!.appWelcome      // "Welcome"
AppLocalizations.of(context)!.appHomeTitle   // "Home Title"
```


## How It Integrates with Flutter Localization
Flutter expects a single ARB file per locale. This tool merges all your JSONs for a locale into one ARB file, placed in the directory specified by `arb-dir`. Flutter's localization system automatically reads these files—no manual steps or risk of duplication.

## Configuration Reference
```yaml
json_to_arb:
  source: lib/l10n           # Source directory path
  output: lib/l10n/app_arb   # Output directory path  
  locales:                   # List of locale codes
    - en
    - ar
```

**Directory Structure:**
```
lib/l10n/              # source
├── en/app.json
├── en/home.json
├── ar/app.json
├── ar/home.json
└── app_arb/           # output
    ├── app_en.arb     # generated
    └── app_ar.arb     # generated
```



## Contributing
Contributions are welcome! If you have ideas, bug reports, or feature requests, please open an issue or submit a pull request on GitHub:

- Fork the repository
- Create your feature branch (`git checkout -b feature/my-feature`)
- Commit your changes (`git commit -am 'Add new feature'`)
- Push to the branch (`git push origin feature/my-feature`)
- Open a pull request

Please make sure your code follows the existing style and includes relevant documentation and tests if applicable.

---
Errors and warnings are printed in color for easy debugging.
