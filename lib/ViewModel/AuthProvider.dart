import 'package:flutter/cupertino.dart';
import 'package:newsaty/Model/DataModels/User.dart';
import 'package:newsaty/Model/Services/AuthPrefs.dart';
import 'package:newsaty/Model/Services/AuthService.dart';

enum Status { UnAuthenticated, Authenticated, Authenticating }

class AuthProvider extends ChangeNotifier {
  Status authStatus = Status.UnAuthenticated;
  String errorMessage;
  User user;

  AuthService _authService = AuthService();
  AuthPrefs _authPrefs = AuthPrefs();

  Future loadUid() async {
    user = await _authPrefs.loadUser();
    print(user.uid);
  }

  void isSignedIn() async {
    print("Check Login");
    authStatus = Status.Authenticating;
    notifyListeners();
    try {
      await loadUid();
      print(user.uid);
      final res = await _authService.isSignedIn(user.uid);
      print(res);
      authStatus = res ? Status.Authenticated : Status.UnAuthenticated;
    } catch (e) {
      print(e.toString());
      errorMessage = e.toString();
      authStatus = Status.UnAuthenticated;
    }
    notifyListeners();
  }

  void signIn() async {
    authStatus = Status.Authenticating;
    try {
      user = await _authService.signIn();
      authStatus = Status.Authenticated;
      _authPrefs.writeUser(user);
    } catch (e) {
      errorMessage = e.toString();
      authStatus = Status.UnAuthenticated;
    }
    notifyListeners();
  }

  void signOut() async {
    try {
      await _authService.signOut();
      user = null;
      _authPrefs.deleteUser();
      authStatus = Status.UnAuthenticated;
    } catch (e) {
      errorMessage = e.toString();
    }
  }
}
