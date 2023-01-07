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

List<String> images = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTThy8eCIAyAXuqnKyFR099YDLxecR1qFWRkXejgcThdpt8iP5PMXxuCnT-O2pHKKA94Gg&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBIw30uUe8r8qaToZ_3ci_pNriSG_EYwJxQJl0dKOx2wAmsh6QVqR_GAC7tvvW3lBzOJ4&usqp=CAU",
  "https://assets.boots.com/content/dam/boots/brands/brand---m/maybelline/maybeline_bt-update_21-03-2022/2022-02_maybelline_brand-treatment_50-teaser_maybelline-bestsellers.dam.ts%3D1647873719149.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTObDJ8mqAHxt7CDVST1plmuRFLSw3Re353aAF4-tTtEx5Z6ZoiL7wBnLno2_LOPOVZIXs&usqp=CAU"
];

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  final user = UserPreferences.getUser();
  late final isDarkMode = user.isDarkMode;
  late final icon =
      isDarkMode ? CupertinoIcons.sun_max : CupertinoIcons.moon_stars;
  late CardModel card;
  String query = '';
  List<String> banners = [];
  var position = 0;

  late List<Makeup> searchedPrd = productController.productlist;

  late List<Makeup> searchPrd;


  fetchData() async {
    List<String> banner = [];
    for (var i = 1; i < 7; i++) {
      banner.add("assets/images/b" + i.toString() + ".jpg");
    }
    setState(() {
      banners.clear();
      banners.addAll(banner);
    });
  }

  final List<Widget> imageSliders = images
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'No. ${images.indexOf(item)} image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  @override
  void initState() {
    // TODO: implement initState
    UserPreferences.init();
    super.initState();
    searchedPrd = productController.productlist;

    fetchData();
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
                            // Container(
                            //   child: CarouselSlider(
                            //     options: CarouselOptions(
                            //       autoPlay: true,
                            //       aspectRatio: 2.0,
                            //       enlargeCenterPage: true,
                            //     ),
                            //     items: images
                            //         .map((item) => Container(
                            //       child: ClipRRect(
                            //         borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            //         child: Center(
                            //             child:
                            //             Image.network(item, fit: BoxFit.cover, width: 1000)),
                            //       ),
                            //     ))
                            //         .toList(),
                            //   ),
                            // ),
                            //
                            // Container(
                            //   height: height * 0.55,
                            //   child: Stack(
                            //     alignment: Alignment.bottomCenter,
                            //     children: <Widget>[
                            //       PageView.builder(
                            //         itemCount: banners.length,
                            //         itemBuilder: (context, index) {
                            //           return Image.asset(banners[index], width: width, height: height * 0.55, fit: BoxFit.cover);
                            //         },
                            //         onPageChanged: (index) {
                            //           setState(() {
                            //             position = index;
                            //           });
                            //         },
                            //       ),
                            //       Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: DotsIndicator(
                            //           dotsCount: banners.length,
                            //           position: position,
                            //           decorator: DotsDecorator(
                            //
                            //             activeColor: Colors.red,
                            //             size: const Size.square(7.0),
                            //             activeSize: const Size.square(10.0),
                            //             spacing: EdgeInsets.all(3),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
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
