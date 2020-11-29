import 'package:aes_crypt/aes_crypt.dart';
import 'package:bsm/main.dart';

class EncryptData {
  static Future<String> encryptFile(String path) async {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    var storageHash = await storage.read(key: 'hash');
    crypt.setPassword(storageHash);
    String encFilepath;
    try {
      encFilepath = crypt.encryptFileSync(path);
    } catch (e) {
      if (e.type == AesCryptExceptionType.destFileExists) {
        print(e.message);
      }
      else {
        return 'ERROR';
      }
    }
    return encFilepath;
  }

  static Future<String> decryptFile(String path) async {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    var storageHash = await storage.read(key: 'hash');
    crypt.setPassword(storageHash);
    String decFilepath;
    try {
      decFilepath = crypt.decryptFileSync(path);
    } catch (e) {
      if (e.type == AesCryptExceptionType.destFileExists) {
        print(e.message);
      }
      else {
        return 'ERROR';
      }
    }
    return decFilepath;
  }
}