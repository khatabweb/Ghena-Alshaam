import 'package:equatable/equatable.dart';

class CartItemsModel extends Equatable{
  int? productId;
  int? qty;
  String? shredder;
  String? packaging;
  String? image;
  String? name;
  String? price;
  CartItemsModel({this.productId, this.qty, this.shredder, this.packaging, this.image, this.name, this.price});

  CartItemsModel copyWith({
    int? productId,
    int? qty,
    String? shredder,
    String? packaging,
    String? image,
    String? name,
    String? price,
  }) {
    return CartItemsModel(
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      shredder: shredder ?? this.shredder,
      packaging: packaging ?? this.packaging,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
      );
  }


  CartItemsModel.fromJson(Map<String, dynamic> json) {
    productId = json["productId"];
    qty = json["qty"];
    shredder = json["shredder"];
    packaging = json["packaging"];
    image = json["image"];
    name = json["name"];
    price = json["price"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["productId"] = productId;
    data["qty"] = qty;
    data["shredder"] = shredder;
    data["packaging"] = packaging;
    data["image"] = image;
    data["name"] = name;
    data["price"] = price;
    return data;
  }

  @override
  List<Object?> get props => [
    this.productId,
    this.qty,
    this.shredder,
    this.packaging,
    this.image,
    this.name,
    this.price,
  ];

  @override
  bool? get stringify => true;
}