class AppConfig {
  factory AppConfig({required baseURL, required appTitle}) {
    baseURL = baseURL;
    appTitle = appTitle;
    return _appConfig;
  }

  AppConfig._internal();

  static String? baseURL;

  static final AppConfig _appConfig = AppConfig._internal();
}
