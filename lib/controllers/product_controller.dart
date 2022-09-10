import 'package:get/get.dart';
import 'package:shoppo/models/products.dart';
import 'package:shoppo/services/remote_services.dart';
import '';
class ProductController extends GetxController{
   ProductController({this.brandname});
  var loading = true.obs;
  var productlist = <Makeup>[].obs;
  var brandname ;
  @override
  void onInit() {
    // TODO: implement onInit
    fechtData(brandname);
    super.onInit();
  }


  void fechtData(brandname) async {
    try {
      loading(true);
      var products = await RemoteServices.fetchtProducts(brandname);
      if (products != null){
        productlist.value = products;
      }
    } finally {
      loading(false);
    }
}

}