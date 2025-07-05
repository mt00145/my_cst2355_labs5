import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository {
  static final _prefs = EncryptedSharedPreferences();
  static String loginName = "";
  static String firstName = "";
  static String lastName = "";
  static String phone = "";
  static String email = "";

  static Future<void> saveProfile() async {
    await _prefs.setString("firstName", firstName);
    await _prefs.setString("lastName", lastName);
    await _prefs.setString("phone", phone);
    await _prefs.setString("email", email);
  }


  static Future<void> loadProfile() async {
    firstName = await _prefs.getString("firstName") ?? "";
    lastName = await _prefs.getString("lastName") ?? "";
    phone = await _prefs.getString("phone") ?? "";
    email = await _prefs.getString("email") ?? "";
  }
}