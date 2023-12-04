abstract class ApplicationStorage {
  Future<void> saveUser(String value);

  Future<String?> loadUser();

  Future<void> deleteAll();
}
