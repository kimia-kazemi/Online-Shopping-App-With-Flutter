import 'dart:convert';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/products.dart';
import '../models/review_model.dart';
import '../widgets/rating_bar.dart';

enum ConfirmAction { CANCEL, ACCEPT }


class DetailProduct extends StatefulWidget {
  final Makeup product;

  DetailProduct(this.product);

  @override
  _DetailProductState createState() => _DetailProductState();
}


class _DetailProductState extends State<DetailProduct> {
  double fiveStar = 0;
  double fourStar = 0;
  double threeStar = 0;
  double twoStar = 0;
  double oneStar = 0;
  List<ShReview> list = [];
  bool autoValidate = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var products = await loadProducts();

    setState(() {
      list.clear();
      list.addAll(products);
    });
    setRating();
  }

  Future<String> loadContentAsset() async {
    return await rootBundle.loadString('assets/data/reviews.json');
  }

  Future<List<ShReview>> loadProducts() async {
    String jsonString = await loadContentAsset();
    final jsonResponse = json.decode(jsonString);
    return (jsonResponse as List).map((i) => ShReview.fromJson(i)).toList();
  }

  setRating() {
    fiveStar = 0;
    fourStar = 0;
    threeStar = 0;
    twoStar = 0;
    oneStar = 0;
    list.forEach((review) {
      switch (review.rating) {
        case 5:
          fiveStar++;
          break;
        case 4:
          fourStar++;
          break;
        case 3:
          threeStar++;
          break;
        case 2:
          twoStar++;
          break;
        case 1:
          oneStar++;
          break;
      }
    });
    fiveStar = (fiveStar * 100) / list.length;
    fourStar = (fourStar * 100) / list.length;
    threeStar = (threeStar * 100) / list.length;
    twoStar = (twoStar * 100) / list.length;
    oneStar = (oneStar * 100) / list.length;
    print(fiveStar);
  }

  void showRatingDialog(BuildContext context) {
    showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: Color(0XFF980F5A),
                      boxShadow: [BoxShadow(color: Colors.transparent)],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Review"),
                        ),
                        Divider(
                          thickness: 0.5,
                        ),
                        Padding(
                          padding: EdgeInsets.all(24),
                          child: RatingBar(
                            onRatingChanged: (v) {},
                            initialRating: 0.0,
                            emptyIcon: Icon(Icons.star).icon!,
                            filledIcon: Icon(Icons.star).icon!,
                            filledColor: Colors.amber,
                            emptyColor: Colors.grey.withOpacity(0.5),
                            size: 40,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: TextFormField(
                              controller: controller,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Review Filed Required!"
                                    : null;
                              },
                              style: TextStyle(
                                  fontFamily: 'Regular', fontSize: 24),
                              decoration: new InputDecoration(
                                hintText: 'Describe your experience',
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1),
                                ),
                                filled: false,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: MaterialButton(
                                  child: Text("Cancel"),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                    side: BorderSide(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(ConfirmAction.CANCEL);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  color: Color(0XFF413F42),
                                  child: Text(
                                    "Submit",
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                  ),
                                  onPressed: () {
                                    final form = _formKey.currentState!;
                                    if (form.validate()) {
                                      form.save();
                                    } else {
                                      setState(() => autoValidate = true);
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget reviewText(rating, {size = 15.0, fontSize = 18}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(rating.toString()),
        SizedBox(width: 4),
        Icon(Icons.star, color: Colors.amber, size: size)
      ],
    );
  }

  Widget ratingProgress(value, color) {
    return Expanded(
      child: LinearPercentIndicator(
        lineHeight: 10.0,
        percent: value / 100,
        linearStrokeCap: LinearStrokeCap.roundAll,
        backgroundColor: Colors.grey.withOpacity(0.2),
        progressColor: color,
      ),
    );
  }

  Widget cartIcon(context, cartCount) {
    return InkWell(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Container(
          //   width: 40,
          //   height: 40,
          //   margin: EdgeInsets.only(right: spacing_standard_new),
          //   padding: EdgeInsets.all(spacing_standard),
          //   child: SvgPicture.asset(
          //     sh_ic_cart,
          //   ),
          // ),
          cartCount > 0
              ? Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 4.0),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                    child: Text(cartCount.toString()),
                  ),
                )
              : Container()
        ],
      ),
      onTap: () {
        // ShCartScreen().launch(context);
      },
      radius: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    var reviews = ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: list.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.only(left: 12, right: 12, top: 1, bottom: 1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: list[index].rating! < 2
                            ? Colors.red
                            : list[index].rating! < 4
                                ? Colors.orange
                                : Colors.green),
                    child: Row(
                      children: <Widget>[
                        Text(list[index].rating.toString()),
                        SizedBox(width: 2),
                        Icon(Icons.star, size: 12)
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("${list[index].name}"),
                        Text("${list[index].review}"),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              Image.network(
                widget.product.imageLink ?? "",
                fit: BoxFit.fill,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return const Icon(Icons.error);
                },
                width: 90,
                height: 110,
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: list[index].verified!
                                ? Colors.green
                                : Colors.grey.withOpacity(0.5)),
                        child: Icon(
                            list[index].verified! ? Icons.done : Icons.clear,
                            size: 14),
                      ),
                      Text(list[index].verified!
                          ? "Verified Buyer"
                          : "Not Verified")
                    ],
                  ),
                  Text(
                    "26 June 2019",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )
            ],
          ),
        );
      },
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          expandedHeight: 500,
                          floating: false,
                          pinned: true,
                          titleSpacing: 0,
                          actionsIconTheme: IconThemeData(color: Colors.red),
                          actions: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              margin: EdgeInsets.only(right: 16.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey.withOpacity(0.1)),
                              child: Icon(Icons.favorite_border, size: 18),
                            ),
                            cartIcon(context, 3)
                          ],
                          title: Text(
                            "${widget.product.brand}",
                            style: TextStyle(color: Colors.black),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            background: Column(
                              children: <Widget>[
                                Container(
                                    height: 350,
                                    width: double.infinity,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Image.network(
                                      widget.product.imageLink ?? "",
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                    )),
                                Padding(
                                  padding: EdgeInsets.all(14),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          (widget.product.name == null)
                                              ? Container()
                                              : Flexible(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    //Center Row contents horizontally,
                                                    children: [
                                                      Text(
                                                        widget.product.name ??
                                                            "",
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'avenir',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 12),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              12,
                                                                          right:
                                                                              12,
                                                                          top:
                                                                              0,
                                                                          bottom:
                                                                              0),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(13)),
                                                                    color: (widget.product.rating ??
                                                                                3) <
                                                                            2
                                                                        ? Colors
                                                                            .red
                                                                        : (widget.product.rating ?? 3) <
                                                                                4
                                                                            ? Colors.orange
                                                                            : Colors.green,
                                                                  ),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                          "${widget.product.rating}"),
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                      Icon(
                                                                          Icons
                                                                              .star,
                                                                          size:
                                                                              12),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width: 10),
                                                                Text(
                                                                    "6 Reviewer")
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          '\$${widget.product.price}',
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontFamily:
                                                                  'avenir')),
                                                    ],
                                                  ),
                                                  fit: FlexFit.tight,
                                                ),
                                        ],
                                      ),
                                      //TODO
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            collapseMode: CollapseMode.pin,
                          ),
                        ),
                        SliverPersistentHeader(
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                              labelColor: Color(0XFF980F5A),
                              indicatorColor: Colors.white60,
                              unselectedLabelColor: Colors.white70,
                              tabs: [
                                Tab(text: "Description"),
                                Tab(text: "Reviews"),
                              ],
                            ),
                          ),
                          pinned: true,
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text("${widget.product.description}"),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          padding: EdgeInsets.only(bottom: 60),
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 16, top: 20, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.33,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.33,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.grey.withOpacity(0.1)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            reviewText("3.0",
                                                size: 28.0, fontSize: 30.0),
                                            Text(list.length.toString() +
                                                " Reviews"),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                reviewText(5),
                                                ratingProgress(
                                                    fiveStar, Colors.green)
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                reviewText(4),
                                                ratingProgress(
                                                    fourStar, Colors.green)
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                reviewText(3),
                                                ratingProgress(
                                                    threeStar, Colors.amber)
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                reviewText(2),
                                                ratingProgress(
                                                    twoStar, Colors.amber)
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                reviewText(1),
                                                ratingProgress(
                                                    oneStar, Colors.red)
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Divider(
                                  height: 1,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Reviws"),
                                    MaterialButton(
                                      // textColor: sh_colorPrimary,
                                      color: Color(0XFF980F5A),
                                      padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 0,
                                          bottom: 0),
                                      child: Text("Rate Now"),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(24),
                                        side: BorderSide(
                                            color: Color(0XFF980F5A)),
                                      ),
                                      onPressed: () {
                                        showRatingDialog(context);
                                      },
                                    )
                                  ],
                                ),
                                reviews
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    // body: TabBarView(
                    //   children: [
                    //     Container(
                    //       width: 40,
                    //       height: 40,
                    //       margin: EdgeInsets.only(right: 16),
                    //       padding: EdgeInsets.all(8),
                    //       child:    Container(
                    //       height: 180,
                    //       width: double.infinity,
                    //       clipBehavior: Clip.antiAlias,
                    //       decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(4),
                    //       ),
                    //       child:
                    //         Image.network(widget.product.imageLink ?? "",
                    //         fit: BoxFit.cover,
                    //         errorBuilder:
                    //           (BuildContext context, Object exception, StackTrace? stackTrace) {
                    //           return const Icon(Icons.error);
                    //             },
                    //             )),),
                    //     moreInfoTab,
                    //     reviewsTab,
                    //   ],
                    // ),
                  ),
                ),
              ],
            ),
            // child: Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.only(left: 10,right: 10),
            //   child: ListView(
            //     physics: BouncingScrollPhysics(),
            //     children: [
            //     Container(
            //       height: 400,
            //       child: Card(
            //       elevation: 4,
            //       child: Column(
            //         children: [
            //           Image.network(
            //             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTz3rX--yF4p2o2dU-uqyKjTz39mHjxCQ38z9eIDgURE86AH_zoNpRbJedSWaYAGerAh0Q&usqp=CAU"
            //             ,
            //             fit: BoxFit.cover,
            //           ),
            //           // Padding(
            //           //   padding: EdgeInsets.all(10),
            //           //   child: Row(
            //           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           //     children: <Widget>[ Quantitybtn()],
            //           //   ),
            //           // )
            //         ],
            //
            //       ),
            //     ),
            //     )
            //     ],
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Container(child: _tabBar),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
