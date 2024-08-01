enum UrlEnvironment { development, production }

class UrlConfig {
  static UrlEnvironment _environment = UrlEnvironment.development;
  static UrlEnvironment get environment => _environment;
  static void setEnvironment(UrlEnvironment env) => _environment = env;

  // static String get baseUrl => "/api/v1/";

  static get baseUrl {
    switch (_environment) {
      case UrlEnvironment.development:
        return 'https://soundmind-api.onrender.com';
      case UrlEnvironment.production:
        return 'https://prod.example.com';
    }
  }
}
