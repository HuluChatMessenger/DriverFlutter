class EmptyException implements Exception {}

class ServerException implements Exception {
  String? errMsg;

  ServerException(this.errMsg);
}

class LogoutException implements Exception {}

class CacheException implements Exception {}
