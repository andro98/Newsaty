import 'package:flutter/cupertino.dart';
import 'package:newsaty/Model/DataModels/User.dart';
import 'package:newsaty/Model/Services/AuthService.dart';

enum Status { UnAuthenticated, Authenticated, Authenticating }

class AuthProvider extends ChangeNotifier {
  Status authStatus = Status.UnAuthenticated;
  String errorMessage;
  User user;

  AuthService _authService;

  void isSignedIn() async {
    authStatus = Status.Authenticating;
    try {
      final res = await _authService.isSignedIn(user.uid);
      authStatus = res ? Status.Authenticated : Status.UnAuthenticated;
    } catch (e) {
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
      authStatus = Status.UnAuthenticated;
    } catch (e) {
      errorMessage = e.toString();
    }
  }
}
