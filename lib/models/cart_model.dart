class CardModel {
  CardModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.price,

    required this.imageLink,

  });
  CardModel copy({
    int? id,
    String? brand,
    String? name,
    String? price,
    String? imageLink,

  }) =>
      CardModel(
        id: id ?? this.id,
        brand: brand ?? this.brand,
        name: name ?? this.name,
        price: price ?? this.price,

        imageLink: imageLink ?? this.imageLink,
      );

  int? id;
  String? brand;
  String? name;
  String? price;
  String? imageLink;


  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(

    id: json["id"],
    brand: json["brand"],
    name: json["name"],
    price: json["price"],

    imageLink: json["image_link"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "brand": brand,
    "name": name,
    "price": price,

    "image_link": imageLink,

  };
}