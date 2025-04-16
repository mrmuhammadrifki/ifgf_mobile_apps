import 'package:ifgf_apps/core/utils/enum.dart';

class Environment {
  static EnvType type = EnvType.prod;

  // static String base_url_prod = "https://langganan.syarihub.id";
  // static String base_url_dev = "https://langganan.syarihub.id";
  // static String base_url_news = "https://syarihub.id";

  // static String baseUrl() {
  //   switch (type) {
  //     case EnvType.dev:
  //       return base_url_dev;
  //     default:
  //       return base_url_prod;
  //   }
  // }

  static String mapKey() {
    switch (type) {
      default:
        return "AIzaSyAoN-CC3lseMPsoGPrIwhTGpXG83NbWQ3s";
    }
  }
}