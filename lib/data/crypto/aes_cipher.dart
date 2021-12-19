import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

class AESCipher {
  final List<int> passphrase = utf8.encode('a very very very very secret key');

  Future<String> decrypt(String cipherText) async {
    Uint8List ivCiphertextMac = base64.decode(cipherText);
    Uint8List iv = ivCiphertextMac.sublist(0, 12);
    Uint8List ciphertext =
        ivCiphertextMac.sublist(12, ivCiphertextMac.length - 16);
    Uint8List mac = ivCiphertextMac.sublist(ivCiphertextMac.length - 16);

    SecretKey secretKey = SecretKey(passphrase);
    SecretBox secretBox = SecretBox(ciphertext, nonce: iv, mac: Mac(mac));

    List<int> decrypted =
        await AesGcm.with256bits().decrypt(secretBox, secretKey: secretKey);
    return utf8.decode(decrypted);
  }
}
