part of '../json_to_arb.dart';

// load the configuration from pubspec.yaml
JsonToArbModel config() {
  // YamlMap representation of pubspec.yaml
  final pubspecYaml = getYamlFileFromPubspec();

  // check if the required section exists
  if (pubspecYaml[Keys.jsonToArb] == null) {
    Logger.error('[ERROR] Missing "${Keys.jsonToArb}" section in pubspec.yaml');
    throw 'Include "${Keys.jsonToArb}" section in pubspec.yaml';
  }
  if (pubspecYaml[Keys.jsonToArb][Keys.source] == null) {
    Logger.error(
      '[ERROR] Missing "${Keys.source}" key in "${Keys.jsonToArb}" section of pubspec.yaml',
    );
    throw 'Include "${Keys.source}" key in "${Keys.jsonToArb}" section of pubspec.yaml';
  }
  if (pubspecYaml[Keys.jsonToArb][Keys.output] == null) {
    Logger.error(
      '[ERROR] Missing "${Keys.output}" key in "${Keys.jsonToArb}" section of pubspec.yaml',
    );
    throw 'Include "${Keys.output}" key in "${Keys.jsonToArb}" section of pubspec.yaml';
  }
  if (pubspecYaml[Keys.jsonToArb][Keys.locales] == null) {
    Logger.error(
      '[ERROR] Missing "${Keys.locales}" key in "${Keys.jsonToArb}" section of pubspec.yaml',
    );
    throw 'Include "${Keys.locales}" key in "${Keys.jsonToArb}" section of pubspec.yaml';
  }
  // parse and return the configuration model
  return JsonToArbModel.fromYaml(pubspecYaml[Keys.jsonToArb]);
}
