class AppConfig {
  static const bool https = true;
  static const String publicFolder = "public";
  static const String protocol = https ? "https://" : "http://";
  static const String rawBaseUrl = "$protocol$domainPath";
  static const String basePath = "$rawBaseUrl/$apiEndPath";
  static const domainPath = "apps.mis.digital";
  static const String apiEndPath = "lionsfootprint/api/";
  static const uploadImageBasePath = basePath;
  static const currentVersion = "2.0.3";
}
