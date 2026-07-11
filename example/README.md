# json_to_arb example

Runs the same entry point as `dart run json_to_arb`, called programmatically.

## Before running

Your project needs a `json_to_arb` config, either in `pubspec.yaml` (at
the root, not under `flutter:`) or in a standalone `json_to_arb.yaml`:

```yaml
json_to_arb:
  source: lib/l10n
  output: lib/l10n/app_arb
  locales:
    - en
    - ar
```

And JSON files under `source`, per locale:
```
lib/l10n/
├── en/
│   └── app.json
└── ar/
└── app.json
```

## Watch mode

Automatically regenerates ARB files whenever a source `.json` file changes:
```
dart run example/example.dart --watch
```