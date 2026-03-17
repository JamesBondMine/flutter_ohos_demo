import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

String aesDecrypt(String strToDecrypt, String secret) {
  final key = Key(Uint8List.fromList(getKey(secret)));
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

  final decrypted = encrypter.decrypt64(strToDecrypt, iv: iv);
  return decrypted;
}

String aesEncrypt(String plaintext, String secret) {
  final key = Key(Uint8List.fromList(getKey(secret)));
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

  final encrypted = encrypter.encrypt(plaintext, iv: iv);
  return encrypted.base64;
}

List<int> getKey(String myKey) {
  var bytes = utf8.encode(calculateMD5(myKey));

  var sha = sha1.convert(bytes);
  var trimmedKey = sha.bytes.sublist(0, 16);
  return trimmedKey;
}

String calculateMD5(String input) {
  var bytes = utf8.encode(input); // 将输入字符串编码为字节流
  var digest = md5.convert(bytes); // 计算MD5哈希值
  var md5Hash = digest.toString(); // 将哈希值转换为字符串表示
  return md5Hash;
}
