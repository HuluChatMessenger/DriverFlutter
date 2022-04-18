import 'dart:convert';

import 'package:hulutaxi_driver/core/error/exceptions.dart';
import 'package:hulutaxi_driver/features/login/data/models/configuration_model.dart';
import 'package:hulutaxi_driver/features/login/data/models/driver_model.dart';
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

  Future<void> cacheDriver(DriverModel driverToCache);

  Future<void> cacheConfig(ConfigurationModel configToCache);

  Future<void> clearData();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ConfigurationModel> getConfig() {
    final String? jsonConfigDocuments =
        sharedPreferences.getString(AppConstants.prefKeyConfig);
    if (jsonConfigDocuments != null) {
      return Future.value(
          ConfigurationModel.fromJsonCache(json.decode(jsonConfigDocuments)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<DriverModel> getDriver() {
    final String? jsonDriver = sharedPreferences.getString(AppConstants.prefKeyDriver);
    if (jsonDriver != null) {
      return Future.value(DriverModel.fromJson(json.decode(jsonDriver)));
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
      json.encode(configModel.toJsonCache()),
    );
  }

  @override
  Future<void> clearData() {
    return sharedPreferences.clear();
  }
}
