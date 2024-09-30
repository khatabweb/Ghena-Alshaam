class ProdctsFormData {
  List<Products>? products;

  ProdctsFormData({this.products});

  ProdctsFormData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? productId;
  int? qty;
  String? shredder;
  String? packaging;
  String? image;
  String? name;
  String? price;

  Products(
      {this.productId,
      this.qty,
      this.shredder,
      this.packaging,
      this.price,
      this.image,
      this.name});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    qty = json['qty'];
    price = json['price'];
    shredder = json['Shredder'];
    packaging = json['packaging'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['Shredder'] = this.shredder;
    data['packaging'] = this.packaging;
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
