class Config {
  static const String baseUrl = 'http://123.123.123.123:9911';
  static const String generateTokenUrl = '$baseUrl/generate-token/';
  static const String userDataApiUrl = '$baseUrl/user';
  static const String userId = 'fake-id';

  static const int httpTimeout = 5;
  static const bool useJwtAuthorization = true;
}
