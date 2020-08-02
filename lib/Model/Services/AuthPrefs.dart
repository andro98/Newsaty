import 'package:newsaty/Model/DataModels/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefs {
  Future<void> writeUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user', [user.uid, user.name, user.photoUrl]);
  }

  Future<User> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final res = prefs.getStringList('user');
    print("Loding user");
    print(res);
    User user = User(uid: res[0], name: res[1], photoUrl: res[2]);
    print(user.uid);
    return user;
  }

  Future<void> deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove('user');
  }
}
