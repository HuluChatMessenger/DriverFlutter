import 'dart:convert';

import 'package:hulutaxi_driver/core/error/exceptions.dart';
import 'package:hulutaxi_driver/features/login/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  ///Gets the cached [LoginModel] which was gotten the last time
  ///the user had an internet connection
  ///
  /// Throws [CacheException] if no cached data is present
  Future<LoginModel> getLastUser();

  Future<void> cacheUser(LoginModel loginToCache);
}

const prefKeyCurrentUserPhoneNumber = 'PREF_KEY_CURRENT_USER_PHONE_NUMBER';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<LoginModel> getLastUser() {
    final String? jsonPhone =
        sharedPreferences.getString(prefKeyCurrentUserPhoneNumber);
    if (jsonPhone != null) {
      return Future.value(LoginModel.fromJson(json.decode(jsonPhone)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(LoginModel loginToCache) {
    return sharedPreferences.setString(
      prefKeyCurrentUserPhoneNumber,
      json.encode(loginToCache.toJson()),
    );
  }
}
