part of '../json_to_arb.dart';

// read and parse the pubspec.yaml file
YamlMap getYamlFileFromPubspec() {
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    throw Exception('pubspec.yaml not found');
  }
  final content = pubspec.readAsStringSync();
  final doc = loadYaml(content);
  return doc as YamlMap;
}
