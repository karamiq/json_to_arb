part of '../json_to_arb.dart';

// read and parse the pubspec.yaml file
YamlMap getYamlFileFromPubspec() {
  // check if the detecated json_to_arb.yaml file exists
  final jsonToArbYaml = File('json_to_arb.yaml');
  if (jsonToArbYaml.existsSync()) {
    final content = jsonToArbYaml.readAsStringSync();
    final doc = loadYaml(content);
    return doc as YamlMap;
  } else {
    final pubspec = File('pubspec.yaml');
    if (!pubspec.existsSync()) {
      throw Exception('pubspec.yaml not found');
    }
    final content = pubspec.readAsStringSync();
    final doc = loadYaml(content);
    return doc as YamlMap;
  }
}
