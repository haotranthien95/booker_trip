import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

import 'getlisttrips_api.dart';

class GetHotKeyWordAPI {
  Client client = Client();
  Future<List<String>> getHotKeyList() async {
    var result;
    await client
        .get(Uri.http("localhost:3000", "/search/searchHotkeys"),
            headers: {'Content-Type': 'application/json'})
        .then((value) => result = onValue(value))
        .onError(
            (error, stackTrace) => Future.error(error.toString(), stackTrace));
    return result;
  }

  onValue(Response response) {
    if (response.statusCode == 200) {
      List<String> listTring = [];
      var body = json.decode(response.body)['result'];
      for (var object in body) {
        listTring.add(object["searchText"]);
      }

      return listTring;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
