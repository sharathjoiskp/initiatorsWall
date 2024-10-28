import 'package:shared_preferences/shared_preferences.dart';

class LocalDbRepo {
  Future<void> addUserId(String userId, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('email', email);
  }

  Future<Map<String, String?>> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? email = prefs.getString('email');
    return {'userId': userId, 'email': email};
  }

  Future<Map<String, String?>> deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('email');
    return {'status': 'success', 'data': 'Logout Success'};
  }
}
