abstract class AuthLocalDatasource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<String?> getSavedToken();
}
