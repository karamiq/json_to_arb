// example/example.dart
//
// json_to_arb is a CLI-first tool: its configuration (source, output,
// locales) is read from `json_to_arb.yaml` or a `json_to_arb:` section in
// `pubspec.yaml` in the current working directory — not from arguments
// passed here. This example simply forwards CLI args to the package's
// entry point, exactly like the `bin/json_to_arb.dart` executable does.
//
// To run it, do so from a project root that already has:
//   1. A `json_to_arb` config (source/output/locales), and
//   2. JSON translation files under `source`, one subfolder per locale.
//
// See the README's "Configuration" and "Usage" sections for the full
// folder layout this expects.
//
// Run a single conversion:
//   dart run example/example.dart
//
// Run in watch mode (regenerates ARB files whenever a source JSON changes):
//   dart run example/example.dart --watch

import 'package:json_to_arb/json_to_arb.dart' as json_to_arb;

void main(List<String> arguments) {
  json_to_arb.main(arguments);
}
