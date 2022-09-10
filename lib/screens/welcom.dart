import 'dart:developer';
import 'dart:ui';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:shoppo/constatnts/kappbar.dart';
// import 'package:get/get.dart';

import 'package:shoppo/constatnts/navigation_page.dart';
import 'package:shoppo/constatnts/search_widget.dart';
import 'package:shoppo/controllers/product_controller.dart';
import 'package:shoppo/design/product_tile.dart';
import '../models/cart_model.dart';
import '../models/products.dart';
import '../theme/themes.dart';
import '../sotrage/user_bio.dart';



class WelcomeScreen extends StatefulWidget {
  static const id = 'welcom_screen';
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {

  final user = UserPreferences.getUser();
  late final isDarkMode = user.isDarkMode;
  late final icon = isDarkMode ? CupertinoIcons.sun_max : CupertinoIcons.moon_stars;
  late CardModel card;
  String query = '';
  late List<Makeup> searchedPrd = productController.productlist;
  @override
  void initState() {
    // TODO: implement initState
    UserPreferences.init();
    super.initState();
    searchedPrd = productController.productlist;
  }
  Drawer _drawer (){
    return  Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("categories",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
          ),
          ListTile(
            title: Row(
              children: [
                Text('switch mood'),
                ThemeSwitcher(
                  builder: (context) => IconButton(
                    icon: Icon(icon),
                    onPressed: () {
                      setState(() {
                        final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;
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
                  SizedBox(width: 10,),
                  Text('+1 110011',style: TextStyle(color: Colors.red),),
                ],
              )
          ),
        ],
      ), );
  }

  @override


  ProductController productController = Get.put(ProductController());

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Search a brand or type',
    onChanged: searchBook,
  );

  void searchBook(String query) {
    final cards = productController.productlist.where((card) {
      final titleLower = card.name?.toLowerCase();
      final authorLower = card.brand?.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower!.contains(searchLower)||
          authorLower!.contains(searchLower);
      ;
    }).toList();

    setState(() {
      this.query = query;
      this.searchedPrd = cards;
    });
  }
  Widget buildBook(Makeup book) => ListTile(
    leading: Image.network(
       book.imageLink ?? "",
      fit: BoxFit.cover,
      width: 50,
      height: 50,
    ),
    title: Text(book.name?? ""),
    subtitle: Text(book.brand?? ""),
  );


  Widget build(BuildContext context) {
    String brandName;
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) =>  Scaffold(
            appBar: kAppBar(context),
            // appBar:kAppBar(context),
            drawer:_drawer(),

            body: SafeArea(
              bottom: true,
              top: true,
              right: true,
              left: true,
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                child: DraggableScrollableSheet(
                  initialChildSize: 0.999,
                  builder: (context,scrollableController){
                    return  Column(
                      children: <Widget>[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      brandName = "All";
                                      productController.fechtData(brandName);
                                      searchedPrd = productController.productlist;



                                    }
                                    );

                                  },

                                  child: const Text('All'),
                                ),
                                SizedBox(width: 4,),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      brandName = "Blush";
                                      productController.fechtData(brandName);
                                      searchedPrd = productController.productlist;

                                    });

                                  },
                                  child: const Text('Blush'),
                                ),
                                SizedBox(width: 4,),

                                ElevatedButton(
                                  child: const Text('Bronzer'),
                                  onPressed: () {
                                    setState(() {
                                      brandName = "Bronzer";
                                      productController.fechtData(brandName);
                                      searchedPrd = productController.productlist;

                                    });

                                  },

                                ),
                                SizedBox(width: 4,),

                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      brandName = "Eyebrow";
                                      productController.fechtData(brandName);
                                      searchedPrd = productController.productlist;

                                    });

                                  },
                                  child: const Text('Eyebrow'),
                                ),
                                SizedBox(width: 4,),

                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      brandName = "Foundation";
                                      productController.fechtData(brandName);
                                      searchedPrd = productController.productlist;

                                    });

                                  },
                                  child: const Text('Foundation'),
                                ),
                              ]
                          ),
                        ),
                        buildSearch(),
                        Expanded(
                            child: Obx(() {

                              if(productController.loading.value)
                                return Center(child: CircularProgressIndicator());
                              else
                                return MasonryGridView.count(

                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 4,

                                  itemCount: searchedPrd.length,
                                  itemBuilder: (context, index) {
                                    final item = searchedPrd[index];
                                    return ProductTile(item);
                                  },
                                  scrollDirection: Axis.vertical,
                                );
                            })
                        ),
                      ],
                    );
                  },

                ),

              ),
            )

        )
      ),
    );

  }

}
