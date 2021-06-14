import 'dart:convert';

import 'package:http/http.dart';

class NetworkCall {
  String getAllUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=17.688112,83.213120&radius=2500&type=restaurant&key=AIzaSyDkGIvqAXuuOE5TUoDedazelbPdKtQxb1E";

  Future getAllResturants() async {
    var response = await get(Uri.parse(getAllUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  Future getSearchResturants(String thing) async {
    var response = await get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=17.688112,83.213120&radius=2500&type=restaurant&keyword=:$thing&key=AIzaSyDkGIvqAXuuOE5TUoDedazelbPdKtQxb1E'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
