import 'package:flutter/material.dart';

class UserResult {
  int code;
  String message;
  List<User> data;

  UserResult.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    message = json["message"];
    if (json["data"] != null) {
      data = new List<User>();

      json["data"].forEach((v) {
        data.add(new User.fromJson(v));
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

class User {
  int id;
  String username;
  String password;
  String nickname;
  String phone;
  int status;
  DateTime createTime;
  String icon;
  int gender;
  String birthday;
  int credit;

  User({this.username, this.password, this.phone});

  @override
  toString() => "username: $username";

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    username = json["username"];
    password = json["password"];
    nickname = json["nickname"];
    phone = json["phone"];
    status = json["status"];
    createTime = json["create_time"];
    icon = json["icon"];
    gender = json["gender"];
    birthday = json["birthday"];
    credit = json["credit"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["id"] = this.id;
    data["username"] = this.username;
    data["password"] = this.password;
    data["nickname"] = this.nickname;
    data["phone"] = this.phone;
    data["status"] = this.status;
    data["create_time"] = this.createTime;
    data["icon"] = this.icon;
    data["gender"] = this.gender;
    data["birthday"] = this.birthday;
    data["credit"] = this.credit;

    return data;
  }
}

class UserState with ChangeNotifier {
  User user;

  /// 刷新用户信息
  flushUserInfo(User user) {
    this.user = user;
    notifyListeners();
  }
}
