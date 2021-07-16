import 'package:crypto/crypto.dart';
import 'dart:convert';

class HashPasswordClass {
  String convertSalt(String password) {
    var bytes1 = utf8.encode('${password}ConGauMoeBeoU'); // data being hashed
    var digest1 = sha256.convert(bytes1); // Hashing Process
    print("Digest as bytes: ${digest1.toString()}"); // Print Bytes
    //print("Digest as hex string: $digest1");
    return digest1.toString();
  }
}

final saltEnc = HashPasswordClass();
