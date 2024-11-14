import 'package:get/get.dart';
import 'package:setia_module/generated/locales.g.dart' as locales;

class LocalizationService extends Translations {
  Map<String, String> fa = {}, en = {};

  LocalizationService() {
    fa.addAll(locales.Locales.fa_IR);
    en.addAll(locales.Locales.en_US);
  }

  @override
  Map<String, Map<String, String>> get keys => {'fa': fa, 'en': en};

}
