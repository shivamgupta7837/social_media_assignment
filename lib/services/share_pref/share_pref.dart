// import 'dart:convert';

// import 'package:lawyer_panel/data/auth_model/login_response/login_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharePreference {
//   final String _isLogin = "IS_LOGIN";
//   final String _loginDetails = "LOGIN_DETAILS";
//   final String _userEmail = "USER_EMAIL";
//   final String _userPassword = "USER_PASSWORD";
//   // Private constructor
//   SharePreference._privateConstructor();

//   // The single instance of LocalStorage
//   static final SharePreference _instance =
//       SharePreference._privateConstructor();

//   // Getter to retrieve the singleton instance
//   static SharePreference get instance => _instance;

//   // SharedPreferences instance
//   SharedPreferences? _prefs;

//   // Initialize the SharedPreferences instance (should be called in main)
//   Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   void setUserIsLogin() async {
//   _prefs?.setBool(_isLogin, true);
//   print("sharePf: is user login: ${await isUserLogin()}");
//   }

//   Future<bool?> isUserLogin() async {
//     return _prefs?.getBool(_isLogin);
//   }

//   void saveUserCredentials({required LoginResponse loginResponse}) async {
//     print("Login share: ${jsonEncode(loginResponse)}");
//     final isSaved = await _prefs?.setString(
//       _loginDetails,
//       jsonEncode(loginResponse.toJson()),
//     );
//    if(isSaved!=null){
//      if (isSaved!) {
//       print("Saved");
//     } else {
//       print("Unsaved");
//     }
//    }else{
//     print("saved null");
//    }
//   }


//   LoginResponse? get loginDetails {
//     final result = _prefs?.getString(_loginDetails);
//     if (result != null) {
//       return LoginResponse.fromJson(jsonDecode(result));
//     }
//     return null;
//   }

// }
