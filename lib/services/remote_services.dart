import 'package:http/http.dart' as http;
import 'package:shoppo/models/products.dart';

class RemoteServices {
  static var client = http.Client();
  String? url;
  static Future<List<Makeup>?> fetchtProducts(brand) async {
    String? url;
      switch (brand) {
        case "All":{
          url =
          "http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline";
        }
        break;

        case "Blush":
          {
            url =
            'https://makeup-api.herokuapp.com/api/v1/products.json?product_type=blush';
          }
          break;

        case "Bronzer":
          {
            url =
            "https://makeup-api.herokuapp.com/api/v1/products.json?product_type=bronzer";
          }
          break;

        case "Eyebrow":
          {
            url =
            "https://makeup-api.herokuapp.com/api/v1/products.json?product_type=eyebrow";
          }
          break;

        case "Foundation":
          {
            url =
            "https://makeup-api.herokuapp.com/api/v1/products.json?product_type=foundation";
          }
          break;
        default:
          {
            url =
            'http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline';
          }
           break;
      }

    var response= await client.get( Uri.parse(url));

    if (response.statusCode == 200){
      print('yaye');
    return makeupFromJson(response.body);
    }
    else{
      print('no');
     return null;
    }

  }


}
