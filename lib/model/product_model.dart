import 'package:flutter/material.dart';

class ProductResult {
  int code;
  String message;
  List<Product> data;

  ProductResult.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    message = json["message"];
    if (json["data"] != null) {
      data = new List<Product>();

      json["data"].forEach((v) {
        data.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["code"] = this.code;
    data["message"] = this.message;
    if (this.data != null) {
      data["data"] = this.data.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int id;
  int productCategoryId;
  String productAttributeIds;
  String name;
  String picture;
  int newStatus;
  int recommendStatus;
  int verifyStatus;
  int sale;
  int price;
  String description;
  String albumPics;

  Product({this.productCategoryId, this.productAttributeIds, this.name});

  @override toString() => "name: $name";

  Product.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    productCategoryId = json["product_category_id"];
    productAttributeIds = json["product_attribute_ids"];
    name = json["name"];
    picture = json["picture"];
    newStatus = json["new_status"];
    recommendStatus = json["recommend_status"];
    verifyStatus = json["verify_status"];
    sale = json["sale"];
    price = json["price"];
    description = json["description"];
    albumPics = json["album_pics"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["id"] = this.id;
    data["product_category_id"] = this.productCategoryId;
    data["product_attribute_ids"] = this.productAttributeIds;
    data["name"] = this.name;
    data["picture"] = this.picture;
    data["new_status"] = this.newStatus;
    data["recommend_status"] = this.recommendStatus;
    data["verify_status"] = this.verifyStatus;
    data["sale"] = this.sale;
    data["price"] = this.price;
    data["description"] = this.description;
    data["album_pics"] = this.albumPics;

    return data;
  }
}

class ProductState with ChangeNotifier {
  List<Product> products;

  /// 点击分类刷新奶茶列表
  changeMilkyTea(List<Product> data) {
    products = data;
    notifyListeners();
  }
}
