import 'package:json_to_arb/json_to_arb.dart'
    show JsonToArbModel, consistancyChecker, convertJsonsToOneArb, getLanguages;

void main() {
  final model = JsonToArbModel(
    source: 'test_l10n',
    output: 'test_l10n/app_arb',
    locales: ['en', 'ar'],
    logging: false,
  );

  // get the list of languages and their corresponding JSON files
  final languages = getLanguages(model.source, model.locales);

  // convert JSON files to single ARB file per language
  convertJsonsToOneArb(languages);

  // check for consistancy between all JSON files
  if (model.logging) {
    consistancyChecker(languages);
  }
}
