# json_to_arb

`json_to_arb` is a Dart command-line tool for Flutter localization. It lets you keep translations in multiple modular JSON files (per feature, module, or screen) for each language, then automatically merges them into a single ARB file per locale—ready for Flutter's official localization system.

## Key Features
- Modular JSON files for each language and feature/module (e.g., `app.json`, `home.json`, `profile.json`).
- Automatic merging and flattening of nested objects, with file name prefixes to avoid key collisions.
- Generates a single ARB file per language in your chosen output directory (matching Flutter's `arb-dir`).
- Seamless integration: Flutter's localization code generator picks up the ARB files, so you access translations with strongly-typed properties.

## Benefits
- Easy, maintainable translation workflow.
- No manual merging or risk of duplicate keys.
- Works out-of-the-box with Flutter's localization system.

---



## Installation
**Note:** This package is intended for development use only. Add it to your `dev_dependencies` so it is not included in your production build.

Add to your `pubspec.yaml`:
```yaml
dev_dependencies:
   json_to_arb: ^0.1.13
```
Then run:
```
flutter pub get
```


## Usage
### Global CLI Installation
You can install `json_to_arb` globally to use it as a command-line tool anywhere:

```sh
dart pub global activate json_to_arb
```

After activation, run:

```sh
json_to_arb
```

This will execute the conversion process as defined in your configuration.
1. **Add your JSON files**
   Organize by language and feature/module:
   ```
   lib/l10n/en/app.json
   lib/l10n/en/home.json
   lib/l10n/ar/app.json
   lib/l10n/ar/home.json
   ```

2. **Configure your project**
   In your `pubspec.yaml`, add:
   ```yaml
   arb_directories:
     source: lib/l10n
     output: lib/l10n/app_arb
     locales:
       - en
       - ar
   ```
   **Important:** The `output` path must match the `arb-dir` in your Flutter `pubspec.yaml`:
   ```yaml
   flutter:
     generate: true
     # arb-dir: lib/l10n/app_arb
   ```
   This ensures ARB files are picked up automatically by Flutter's localization system.

3. **Run the converter**
   From your project root:
   ```
   dart run json_to_arb
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
