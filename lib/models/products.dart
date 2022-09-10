// To parse this JSON data, do
//
//     final makeup = makeupFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<Makeup> makeupFromJson(String str) => List<Makeup>.from(json.decode(str).map((x) => Makeup.fromJson(x)));

String?  makeupToJson(List<Makeup> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Makeup { 
  Makeup({
    required this.id,
    required this.brand,
    required this.name,
    required this.price,

    required this.imageLink,
    required this.productLink,
    required this.websiteLink,
    required this.description,
    required this.rating,
    required this.tagList,
    required this.createdAt,
    required this.updatedAt,
    required this.productApiUrl,
    required this.apiFeaturedImage,
    required  this.productColors,
  });

  int? id;
  String? brand;
  String? name;
  String? price;
  dynamic priceSign;
  dynamic currency;
  String? imageLink;
  String? productLink;
  String? websiteLink;
  String? description;
  double? rating;
  String? category;
  String? productType;
  List<dynamic> tagList;
  DateTime createdAt;
  DateTime updatedAt;
  String? productApiUrl;
  String? apiFeaturedImage;
  List<ProductColor>? productColors;
  var isFavorite = false.obs;

  factory Makeup.fromJson(Map<String, dynamic> json) => Makeup(
    id: json["id"],
    brand: json["brand"],
    name: json["name"],
    price: json["price"],
    imageLink: json["image_link"],
    productLink: json["product_link"],
    websiteLink: json["website_link"],
    description: json["description"],
    rating: json["rating"] == null ? null : json["rating"],
    tagList: List<dynamic>.from(json["tag_list"].map((x) => x)),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    productApiUrl: json["product_api_url"],
    apiFeaturedImage: json["api_featured_image"],
    productColors: List<ProductColor>.from(json["product_colors"].map((x) => ProductColor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand": brand,
    "name": name,
    "price": price,
    "price_sign": priceSign,
    "currency": currency,
    "image_link": imageLink,
    "product_link": productLink,
    "website_link": websiteLink,
    "description": description,
    "rating": rating == null ? null : rating,
    "category": category,
    "product_type": productType,
    "tag_list": List<dynamic>.from(tagList.map((x) => x)),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product_api_url": productApiUrl,
    "api_featured_image": apiFeaturedImage,
    "product_colors":List<dynamic>.from(productColors!.map((x) => x.toJson())),
  };
}

class ProductColor {
  ProductColor({
    this.hexValue,
    this.colourName,
  });

  String? hexValue;
  String? colourName;

  factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
    hexValue: json["hex_value"],
    colourName: json["colour_name"],
  );

  Map<String, dynamic> toJson() => {
    "hex_value": hexValue,
    "colour_name": colourName,
  };
}













////////////////////////////////////////////////////////////////


// // To parse this JSON data, do
// //
// //     final makeup = makeupFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:get/get.dart';
//
// List<Makeup> makeupFromJson(String str) => List<Makeup>.from(json.decode(str).map((x) => Makeup.fromJson(x)));
//
// String? makeupToJson(List<Makeup> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Makeup {
//   Makeup({
//     required this.id,
//     required this.brand,
//     required this.name,
//     required this.price,
//     // required this.priceSign,
//     // required this.currency,
//     required this.imageLink,
//     required this.productLink,
//     required this.websiteLink,
//     required this.description,
//     required this.rating,
//     // required this.category,
//     // required this.productType,
//     required this.tagList,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.productApiUrl,
//     required this.apiFeaturedImage,
//     required  this.productColors,
//   });
//
//   int? id;
//   String? brand;
//   String? name;
//   String? price;
//   // PriceSign priceSign;
//   // Currency currency;
//   String? imageLink;
//   String? productLink;
//   String? websiteLink;
//   String? description;
//   double? rating;
//   // Category category;
//   // ProductType productType;
//   List<String> tagList;
//   DateTime createdAt;
//   DateTime updatedAt;
//   String? productApiUrl;
//   String? apiFeaturedImage;
//   List<ProductColor>? productColors;
//   var isFavorite = false.obs;
//
//
//   factory Makeup.fromJson(Map<String, dynamic> json) => Makeup(
//     id: json["id"],
//     brand: json["brand"] == null ? null : json["brand"],
//     name: json["name"],
//     price: json["price"] == null ? null : json["price"],
//     // priceSign: json["price_sign"] == null ? null : priceSignValues.map[json["price_sign"]],
//     // currency: json["currency"] == null ? null : currencyValues.map[json["currency"]],
//     imageLink: json["image_link"],
//     productLink: json["product_link"],
//     websiteLink: json["website_link"],
//     description: json["description"] == null ? null : json["description"],
//     rating: json["rating"] == null ? null : json["rating"].toDouble(),
//     // category: json["category"] == null ? null : categoryValues.map[json["category"]],
//     // productType: productTypeValues.map[json["product_type"]],
//     tagList: List<String>.from(json["tag_list"].map((x) => x)),
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     productApiUrl: json["product_api_url"],
//     apiFeaturedImage: json["api_featured_image"],
//     productColors: List<ProductColor>.from(json["product_colors"].map((x) => ProductColor.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "brand": brand == null ? null : brand,
//     "name": name,
//     "price": price == null ? null : price,
//     // "price_sign": priceSign == null ? null : priceSignValues.reverse[priceSign],
//     // "currency": currency == null ? null : currencyValues.reverse[currency],
//     "image_link": imageLink,
//     "product_link": productLink,
//     "website_link": websiteLink,
//     "description": description == null ? null : description,
//     "rating": rating == null ? null : rating,
//     // "category": category == null ? null : categoryValues.reverse[category],
//     // "product_type": productTypeValues.reverse[productType],
//     "tag_list": List<dynamic>.from(tagList.map((x) => x)),
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//     "product_api_url": productApiUrl,
//     "api_featured_image": apiFeaturedImage,
//     "product_colors": List<dynamic>.from(productColors!.map((x) => x.toJson())),
//   };
// }
//
// enum Category { PENCIL, LIPSTICK, LIQUID, EMPTY, POWDER, LIP_GLOSS, GEL, CREAM, PALETTE, CONCEALER, HIGHLIGHTER, BB_CC, CONTOUR, LIP_STAIN, MINERAL }
//
// final categoryValues = EnumValues({
//   "bb_cc": Category.BB_CC,
//   "concealer": Category.CONCEALER,
//   "contour": Category.CONTOUR,
//   "cream": Category.CREAM,
//   "": Category.EMPTY,
//   "gel": Category.GEL,
//   "highlighter": Category.HIGHLIGHTER,
//   "lipstick": Category.LIPSTICK,
//   "lip_gloss": Category.LIP_GLOSS,
//   "lip_stain": Category.LIP_STAIN,
//   "liquid": Category.LIQUID,
//   "mineral": Category.MINERAL,
//   "palette": Category.PALETTE,
//   "pencil": Category.PENCIL,
//   "powder": Category.POWDER
// });
//
// enum Currency { CAD, USD, GBP }
//
// final currencyValues = EnumValues({
//   "CAD": Currency.CAD,
//   "GBP": Currency.GBP,
//   "USD": Currency.USD
// });
//
// enum PriceSign { EMPTY, PRICE_SIGN }
//
// final priceSignValues = EnumValues({
//   "\u0024": PriceSign.EMPTY,
//   "£": PriceSign.PRICE_SIGN
// });
//
// class ProductColor {
//   ProductColor({
//     required this.hexValue,
//     required this.colourName,
//   });
//
//   String? hexValue;
//   String? colourName;
//
//   factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
//     hexValue: json["hex_value"],
//     colourName: json["colour_name"] == null ? null : json["colour_name"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "hex_value": hexValue,
//     "colour_name": colourName == null ? null : colourName,
//   };
// }
//
// enum ProductType { LIP_LINER, LIPSTICK, FOUNDATION, EYELINER, EYESHADOW, BLUSH, BRONZER, MASCARA, EYEBROW, NAIL_POLISH }
//
// final productTypeValues = EnumValues({
//   "blush": ProductType.BLUSH,
//   "bronzer": ProductType.BRONZER,
//   "eyebrow": ProductType.EYEBROW,
//   "eyeliner": ProductType.EYELINER,
//   "eyeshadow": ProductType.EYESHADOW,
//   "foundation": ProductType.FOUNDATION,
//   "lipstick": ProductType.LIPSTICK,
//   "lip_liner": ProductType.LIP_LINER,
//   "mascara": ProductType.MASCARA,
//   "nail_polish": ProductType.NAIL_POLISH
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
