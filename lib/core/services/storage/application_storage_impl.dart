import 'package:flutter_products_demo/core/services/constants/application_constants.dart';
import 'package:flutter_products_demo/core/services/storage/application_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApplicationStorageImpl implements ApplicationStorage {
  final FlutterSecureStorage _secureStorage;

  const ApplicationStorageImpl({
    required FlutterSecureStorage securedStorage,
  }) : _secureStorage = securedStorage;

  @override
  Future<String?> loadUser() => _secureStorage.read(
        key: ApplicationConstants.authenticatedUser,
      );

  @override
  Future<void> saveUser(String value) => _secureStorage.write(
        key: ApplicationConstants.authenticatedUser,
        value: value,
      );

  @override
  Future<void> deleteAll() => _secureStorage.deleteAll();
}
