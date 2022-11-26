import 'package:get/get.dart';
import 'package:shoppo/models/products.dart';
import 'package:shoppo/services/remote_services.dart';

class ProductController extends GetxController {
  ProductController({this.brandname});

  var loading = true.obs;
  var productlist = <Makeup>[].obs;
  var brandname;

  @override
  void onInit() {
    fechtData(brandname: brandname);
    super.onInit();
  }

  void fechtData({brandname}) async {
    try {
      loading(true);
      var products = await RemoteServices.fetchtProducts(brand: brandname);
      if (products != null) {
        productlist.value = products;
      }
    } finally {
      loading(false);
    }
  }
}
