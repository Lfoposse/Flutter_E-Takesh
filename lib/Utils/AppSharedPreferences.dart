import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  final String _IsFirstLaunch = "isFirstLaunch";
  final String _IsLoggedIn = "isLoggedIn";
  final String _IsUserCreateAccount = "isUserCreateAccount";

  /// ------------------------------------------------------------
  /// Method that determine if the app is launched for the first time
  /// ------------------------------------------------------------
  Future<bool> isAppFirstLaunch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_IsFirstLaunch) ?? true;
  }

  /// ----------------------------------------------------------
  /// Method that saves the the first connection to app status
  /// ----------------------------------------------------------
  Future<bool> setAppFirstLaunch(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_IsFirstLaunch, value);
  }

  /// ------------------------------------------------------------
  /// Method that determine is the app if an already an account logged
  /// ------------------------------------------------------------
  Future<bool> isAppLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_IsLoggedIn) ?? false;
  }

  /// ----------------------------------------------------------
  /// Method that saves the app logged In status
  /// ----------------------------------------------------------
  Future<bool> setAppLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_IsLoggedIn, value);
  }

  /// ------------------------------------------------------------
  /// Method that determine if user have create
  /// ------------------------------------------------------------
  Future<bool> isAccountCreate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_IsUserCreateAccount) ?? false;
  }

  /// ----------------------------------------------------------
  /// Method that saves the app account create
  /// ----------------------------------------------------------
  Future<bool> setAccountCreate(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(_IsUserCreateAccount, value);
  }
}
