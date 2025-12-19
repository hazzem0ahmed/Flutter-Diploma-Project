class ApiService {

  static Future<Map<String, dynamic>> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'first_name': 'John ',
      'last_name': 'Safwat',
      'avatar': 'lib/assets/images/0ecb0264ed6bae405d7a1f06d2b702842000ca23.png',
    };
  }

  static Future<List<String>> getWatchList() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ['Movie One', 'Movie Two', 'Movie Three'];
  }

  static Future<List<String>> getHistory() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ['Watched A', 'Watched B'];
  }
}
