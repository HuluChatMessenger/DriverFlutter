import 'dart:convert';

import 'package:hulutaxi_driver/core/error/exceptions.dart';
import 'package:hulutaxi_driver/features/login/data/models/configuration_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/driver_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/util/constants.dart';

abstract class LocalDataSource {
  ///Gets the cached [DriverModel] which was gotten the last time
  ///the user had an internet connection
  ///
  /// Throws [CacheException] if no cached data is present
  Future<DriverModel> getDriver();

  ///Gets the cached [ConfigurationModel] which was gotten the last time
  ///the user had an internet connection
  ///
  /// Throws [CacheException] if no cached data is present
  Future<ConfigurationModel> getConfig();

  ///Gets the cached [bool] which was gotten the last time
  ///the user had an internet connection
  Future<bool> getLogin();

  ///Gets the cached [String] which was gotten the last time
  ///the user had an internet connection
  Future<String> getLanguage();

  ///Gets the cached [TokenDataModel] which was gotten the last time
  ///the user had an internet connection
  Future<TokenDataModel?> getToken();

  Future<void> cacheDriver(DriverModel driverToCache);

  Future<void> cacheConfig(ConfigurationModel configToCache);

  Future<void> cacheLogin(bool isLogin);

  Future<void> cacheToken(TokenDataModel tokenToCache);

  Future<void> cacheLanguage(String language);

  Future<void> clearData();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ConfigurationModel> getConfig() async {
    final String? jsonConfigDocuments =
        sharedPreferences.getString(AppConstants.prefKeyConfig);
    if (jsonConfigDocuments != null) {
      ConfigurationModel configurationModel =
          ConfigurationModel.fromJson(json.decode(jsonConfigDocuments));
      configurationModel.isLoggedIn = await getLogin();
      return Future.value(configurationModel);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<DriverModel> getDriver() async {
    final String? jsonDriver =
        sharedPreferences.getString(AppConstants.prefKeyDriver);
    if (jsonDriver != null) {
      DriverModel driverModel = DriverModel.fromJson(json.decode(jsonDriver));
      driverModel.isLoggedIn = await getLogin();
      return Future.value(driverModel);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheDriver(DriverModel driverToCache) {
    return sharedPreferences.setString(
      AppConstants.prefKeyDriver,
      json.encode(driverToCache.toJson()),
    );
  }

  @override
  Future<void> cacheConfig(ConfigurationModel configModel) {
    return sharedPreferences.setString(
      AppConstants.prefKeyConfig,
      json.encode(configModel.toJson()),
    );
  }

  @override
  Future<void> clearData() {
    return sharedPreferences.clear();
  }

  @override
  Future<void> cacheLogin(bool isLogin) {
    return sharedPreferences.setBool(
      AppConstants.prefKeyLogin,
      isLogin,
    );
  }

  @override
  Future<void> cacheToken(TokenDataModel tokenToCache) {
    return sharedPreferences.setString(
      AppConstants.prefKeyToken,
      json.encode(tokenToCache.toJson()),
    );
  }

  @override
  Future<void> cacheLanguage(String language) {
    return sharedPreferences.setString(
      AppConstants.prefKeyLanguage,
      language,
    );
  }

  @override
  Future<bool> getLogin() {
    final bool? isLogin = sharedPreferences.getBool(AppConstants.prefKeyLogin);
    if (isLogin != null) {
      return Future.value(isLogin);
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<TokenDataModel?> getToken() {
    final String? jsonToken =
        sharedPreferences.getString(AppConstants.prefKeyToken);
    if (jsonToken != null) {
      return Future.value(TokenDataModel.fromJson(json.decode(jsonToken)));
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<String> getLanguage() {
    final String? currentLanguage =
        sharedPreferences.getString(AppConstants.prefKeyLogin);
    if (currentLanguage != null) {
      return Future.value(currentLanguage);
    } else {
      return Future.value(AppConstants.languageAm);
    }
  }
}
