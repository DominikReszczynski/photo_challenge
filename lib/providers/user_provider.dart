import 'dart:convert';

import 'package:cas_house/main_global.dart';
import 'package:cas_house/models/user.dart';
import 'package:cas_house/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  final SharedPreferences _prefs;
  String? _token;
  String? get token => _token;

  bool get isAuthenticated => _token != null;
  bool get isLoggedIn => _token != null;

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  User? _user;
  User? get user => _user;

  UserProvider(this._prefs) {
    // _prefs.clear();
    _loggedIn = _prefs.getBool('loggedIn') ?? false;
    final userData = _prefs.getString('userData');
    if (userData != null) {
      // 3) zdekoduj do Map i stwórz obiekt User
      final Map<String, dynamic> userMap = jsonDecode(userData);
      _user = User.fromJson(userMap);
    }
    loggedUser = user;
  }

  // Future<void> _loadLoginState() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _loggedIn = prefs.getBool('loggedIn') ?? false;
  //   _user = prefs.getString('userId');
  //   notifyListeners();
  // }

  Future<bool> login({required String email, required String password}) async {
    try {
      final userServices = UserServices();
      final result = await userServices.login(email, password);
      if (result['success'] == true) {
        // _token = result['token'];
        _loggedIn = true;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('loggedIn', true);
        print(2);
        await prefs.setString('userData', jsonEncode(result['user']));
        print(3);
        _user = User(
            id: result['user']['_id'],
            email: result['user']['email'],
            username: result['user']['username'],
            password: result['user']['password']);
        print(4);
        loggedUser = user;
        notifyListeners();
        loggedUser = User.fromMap(result['user']);
        return true;
      } else {
        _token = '1234567890';
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String nickname,
  }) async {
    try {
      final userServices = UserServices();
      final result = await userServices.registration(email, password, nickname);
      return result;
    } catch (e) {
      debugPrint('Registration error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    _token = null;
    _loggedIn = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedIn');
    await prefs.remove('userData');
    notifyListeners();
  }
}
