import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppo/constatnts/kappbar.dart';
import 'package:shoppo/constatnts/search_widget.dart';
import 'package:shoppo/controllers/product_controller.dart';
import 'package:shoppo/design/product_tile.dart';
import '../models/cart_model.dart';
import '../models/products.dart';
import '../theme/themes.dart';
import '../sotrage/user_bio.dart';

class HomeScreen extends StatefulWidget {
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<HomeScreen> {
  final user = UserPreferences.getUser();
  late final isDarkMode = user.isDarkMode;
  late final icon =
      isDarkMode ? CupertinoIcons.sun_max : CupertinoIcons.moon_stars;
  late CardModel card;
  String query = '';
  var position = 0;

  late List<Makeup> searchedPrd = productController.productlist;

  late List<Makeup> searchPrd;

  @override
  void initState() {
    // TODO: implement initState
    UserPreferences.init();
    super.initState();
    searchedPrd = productController.productlist;
  }

  Drawer _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              "categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          ListTile(
            title: Row(
              children: [
                ThemeSwitcher(
                  builder: (context) => IconButton(
                    icon: Icon(icon),
                    onPressed: () {
                      setState(() {
                        final theme = isDarkMode
                            ? MyThemes.lightTheme
                            : MyThemes.darkTheme;
                        final switcher = ThemeSwitcher.of(context);
                        switcher.changeTheme(theme: theme);
                      });
                      final newUser = user.copy(isDarkMode: !isDarkMode);
                      UserPreferences.setUser(newUser);
                    },
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('shops'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('sellers'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('new product'),
          ),
          ListTile(
              title: Row(
            children: <Widget>[
              Text('support 24/7'),
              SizedBox(
                width: 10,
              ),
              Text(
                '+1 110011',
                style: TextStyle(color: Colors.red),
              ),
            ],
          )),
        ],
      ),
    );
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
    late String brandName;

    return ThemeSwitchingArea(
      child: Builder(
          builder: (context) => Scaffold(
                appBar: UserAppBar(context),
                drawer: _drawer(),
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
                            Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'categories',
                                    style: GoogleFonts.aclonica(
                                        fontSize: 20, color: Colors.grey),
                                  )),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          brandName = "All";
                                          searchedPrd =
                                              productController.productlist;

                                          changeurl("All");
                                        });
                                      },
                                      child: const Text('All'),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          brandName = "Blush";
                                          searchedPrd =
                                              productController.productlist;

                                          changeurl("Blush");
                                        });
                                      },
                                      child: const Text('Blush'),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    ElevatedButton(
                                      child: const Text('Bronzer'),
                                      onPressed: () {
                                        setState(() {
                                          brandName = "Bronzer";
                                          searchedPrd =
                                              productController.productlist;

                                          changeurl("Bronzer");
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          brandName = "Eyebrow";
                                          searchedPrd =
                                              productController.productlist;
                                          changeurl("Eyebrow");
                                        });
                                      },
                                      child: const Text('Eyebrow'),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          brandName = "Foundation";
                                          searchedPrd =
                                              productController.productlist;
                                          changeurl("Foundation");
                                        });
                                      },
                                      child: const Text('Foundation'),
                                    ),
                                  ]),
                            ),
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
                                        ProductTile(item),
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
