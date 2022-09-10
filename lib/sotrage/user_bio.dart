import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';


class UserPreferences {
  static  SharedPreferences? _preferences;
  static const _keyUser = 'user';
  static  User myUser = User(
    imagePath:
    'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Sarah Abs',
    email: 'sarah.abs@gmail.com',
    about:
    'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: false ,
    likedNumber: 0
  );


  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    // _preferences?.clear();
  }

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());
    await _preferences?.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences?.getString(_keyUser);
    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
