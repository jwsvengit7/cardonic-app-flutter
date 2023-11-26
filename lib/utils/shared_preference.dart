import 'package:cardmonix/dto/response/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('userid', user.userid ?? 0);
    await prefs.setString('username', user.username);
    await prefs.setString('email', user.email);
    await prefs.setString('role', user.role);
    await prefs.setString('token', user.token);
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? userid = prefs.getInt("userid");
    String? username = prefs.getString("username");
    String? email = prefs.getString("email");
    String? role = prefs.getString("role");
    String? token = prefs.getString("token");

    return User(
      userid: userid,
      username: username!,
      email: email!,
      role: role!,
      token: token!,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userid');
    prefs.remove('username');
    prefs.remove('email');
    prefs.remove('role');
    prefs.remove('token');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token!;
  }
}
