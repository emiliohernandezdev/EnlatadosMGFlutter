import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final storage = new FlutterSecureStorage();

  Future getKey(String name) async {
    return await storage.read(key: name);
  }

  Future setKey(String name, String value) async {
    return await storage.write(key: name, value: value);
  }
}
