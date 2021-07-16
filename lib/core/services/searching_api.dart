import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

class SearchTextAPI {
  Client client = Client();
  Future<void> sendSearchRequest(String searchText) async {
    await client
        .get(
          Uri.http(
              "localhost:3000", "/search/searchTrip", {"text": searchText}),
          headers: {'Content-Type': 'application/json'},
        )
        .then((value) => print(value.toString()))
        .onError(
            (error, stackTrace) => Future.error(error.toString(), stackTrace));
  }
}
