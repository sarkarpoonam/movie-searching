
import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/response.dart';


typedef ItemCreator<S> = S Function();

class ApiHelper<T extends Response> {
  final String url;
  ApiHelper(this.url);

  Future apiCall() async {
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = response.body.toString();
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }



}
