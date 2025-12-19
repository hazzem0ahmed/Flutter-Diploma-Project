abstract class AuthLocalDatasource {
  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> clearToken();

  Future<void> saveUserName(String name);

  Future<String?> getUserName();
}
