import 'package:shared_preferences/shared_preferences.dart';

import '../contract/auth_local_datasource.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  @override
  Future<void> clearToken() {
    // TODO: implement clearToken
    throw UnimplementedError();
  }

  @override
  Future<String?> getSavedToken() {
    // TODO: implement getSavedToken
    throw UnimplementedError();
  }

  @override
  Future<String?> getToken() {
    // TODO: implement getToken
    throw UnimplementedError();
  }
}
