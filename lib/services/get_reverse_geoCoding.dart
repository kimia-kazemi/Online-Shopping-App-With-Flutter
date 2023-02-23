import 'dart:convert';
import 'package:http/http.dart' as http;

class GetGeoCoding {
  static Future<dynamic>? getRequest(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        String data = response.body.toString();
        var decodejson = jsonDecode(data);
        return decodejson;
      }
    } catch (e) {
      return 'failed';
    }
  }
}
