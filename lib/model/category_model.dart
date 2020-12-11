import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:whitepeach/model/product_model.dart';

class CategoryModel {
  int code;
  String message;
  List<Data> data;

  CategoryModel({this.code, this.message});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    message = json["message"];
    if (json["data"] != null) {
      data = new List<Data>();

      json["data"].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  String name;
  String icon;

  Data({this.id, this.name, this.icon});

  @override toString() => 'Data: $id, $name, $icon';

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    icon = json["icon"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["icon"] = this.icon;
    return data;
  }
}

class CategoryState with ChangeNotifier {
  List<CategoryModel> _titleList = [];
  List<Data> _goodsList = [];
  int secondCategoryIndex = 0; // 二级分类索引
  int firstCategoryIndex = 2; // 一级分类索引
  int firstCategoryId = 2; // 一级ID
  int secondCategoryId = 2; // 二级ID
  int categoryId = 0;  // 上面那个一级分类ID怎么都是3有毒
  int page = 1; // 列表页数，当改变一级分类或二级分类时进行改变
  String noMoreText = ''; // 显示更多的表示
  bool newCategory = true;
  List<Product> products;

//  CategoryState(this._titleList);

  /// 点击分类刷新奶茶列表
  changeMilkyTea(List<Product> data) {
    products = data;
    notifyListeners();
  }

  /// 首页点击类别时更改类别
  changeFirstCategory(int id, int index) {
    firstCategoryId = id;
    firstCategoryIndex = index;
    secondCategoryId = 0;
    notifyListeners();
  }

  changeCategoryId(int id) {
    print(categoryId);
    categoryId = id;
    print("categoryId:$categoryId");
    notifyListeners();
  }

  /// 获取二级分类数据
  getSecondCategory(List<Data> list, int id) {
    newCategory = true;
    firstCategoryId = id;
    secondCategoryIndex = 0;
    page = 1;
    secondCategoryId = 0;
    noMoreText = '';
    _goodsList.addAll(list);
    notifyListeners();
  }

  /// 改变二级索引
  changeSecondCategory(int id, int index) {
    newCategory = true;
    secondCategoryIndex = index;
    secondCategoryId = id;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  addPage() {
    page++;
  }

  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }

  changeFale() {
    newCategory = false;
  }

  get titleList => _titleList;

  // 接口方法
  void updateRightTitles(List<CategoryModel> titleList) {
    _titleList = titleList;
    notifyListeners();
  }
}
