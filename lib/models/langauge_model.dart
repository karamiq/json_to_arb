part of '../json_to_arb.dart';

// Model representing a language and its associated JSON files
class LangaugeModel {
  // Language code (e.g., 'en', 'ar')
  final String code;
  // List of JSON files for this language
  final List<File> jsonFiles;

  LangaugeModel({required this.code, required this.jsonFiles});
}
