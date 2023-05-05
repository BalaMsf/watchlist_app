import 'dart:convert';
import 'package:http/http.dart';
import '/models/watchlist_model.dart';

class WatchListRepo {
  String url = 'http://5e53a76a31b9970014cf7c8c.mockapi.io/msf/getContacts';
  Future<List<WatchListModel>> getWatchList() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => WatchListModel.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
