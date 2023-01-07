import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:shoppo/constatnts/kappbar.dart';
import 'package:shoppo/design/edit_product.dart';

import '../constatnts/search_widget.dart';
import '../controllers/product_controller.dart';
import '../design/product_tile.dart';
import '../models/products.dart';

class AdminPortal extends StatefulWidget {
  @override
  _AdminPortal createState() => _AdminPortal();
}

class _AdminPortal extends State<AdminPortal> {
  late List<Makeup> searchedPrd = productController.productlist;

  late List<Makeup> searchPrd;

  String query = '';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    searchedPrd = productController.productlist;
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Search a brand or type',
        onChanged: searchProduct,
      );

  void searchProduct(String query) {
    final cards = productController.productlist.where((card) {
      final titleLower = card.name?.toLowerCase();
      final authorLower = card.brand?.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower!.contains(searchLower) ||
          authorLower!.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.searchedPrd = cards;
    });
  }

  Widget changethelist() {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 4,
      itemCount: searchPrd.length,
      itemBuilder: (context, index) {
        final item = searchPrd[index];
        return ProductTile(item);
      },
      scrollDirection: Axis.vertical,
    );
  }

  void changeurl(String type) {
    productController.fechtData(brandname: type);
  }

  ProductController productController = Get.put(ProductController());

  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(
          builder: (context) => Scaffold(
                appBar: AdminAppBar(context),
                body: SingleChildScrollView(
                  child: SafeArea(
                    bottom: true,
                    top: true,
                    right: true,
                    left: true,
                    child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: <Widget>[
                            buildSearch(),
                            Obx(() {
                              if (productController.loading.value)
                                return Center(
                                    child: CircularProgressIndicator());
                              else
                                return MasonryGridView.count(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 4,
                                  itemCount: searchedPrd.length,
                                  itemBuilder: (context, index) {
                                    final item = searchedPrd[index];
                                    return Column(
                                      children: [
                                        EditProduct(item),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('remove'),
                                            IconButton(
                                                onPressed: () {
                                                  searchedPrd.removeAt(index);
                                                },
                                                icon: Icon(Icons
                                                    .remove_circle_outlined)),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                );
                            })
                          ],
                        )),
                  ),
                ),
              )),
    );
  }
}
