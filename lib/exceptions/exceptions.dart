part of '../json_to_arb.dart';

class JsonToArbException implements Exception {
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  final String message;
  JsonToArbException(this.message);
  @override
  String toString() => '$_red[ERROR] $message$_reset';
}

class SkipFileException extends JsonToArbException {
  SkipFileException(super.message);
}
