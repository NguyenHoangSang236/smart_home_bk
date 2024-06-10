import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/account_model.dart';

class Utils {
  const Utils._();

  static Future<List<Map<String, dynamic>>> getAllAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('accounts');

    if (jsonString != null) {
      List<dynamic> jsonResponse = jsonDecode(jsonString);
      List<Map<String, dynamic>> dataList = List<Map<String, dynamic>>.from(
        jsonResponse.map(
          (item) => Map<String, dynamic>.from(item),
        ),
      );

      return dataList;
    }

    return [];
  }

  static void saveNewAccount(AccountModel newAcc) async {
    final prefs = await SharedPreferences.getInstance();
    bool isExisted = false;
    List<Map<String, dynamic>> accounts = await getAllAccounts();

    for (Map<String, dynamic> map in accounts) {
      if (map['userName'] == newAcc.userName) {
        isExisted == true;
        break;
      }
    }

    if (!isExisted) {
      accounts.add(newAcc.toJson());
      prefs.setString('accounts', accounts.toString());
    }
  }

  static void setLocalStorageData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value.toString());
  }

  static Future<dynamic> getLocalStorageData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key) ?? '';
  }

  static Future<void> removeLocalStorageData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
