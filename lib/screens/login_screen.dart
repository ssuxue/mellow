import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whitepeach/config/http_request.dart';
import 'package:whitepeach/model/user_model.dart';
import 'package:whitepeach/screens/signup_screen.dart';
import 'package:whitepeach/service/http_service.dart';
import 'package:whitepeach/util/http_util.dart';
import 'package:whitepeach/widgets/have_account_check.dart';
import 'package:whitepeach/widgets/rounded_button.dart';
import 'package:whitepeach/widgets/rounded_input_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [LoginBackground()],
        ),
      ),
    );
  }
}

class LoginBackground extends StatelessWidget {
  String username;
  String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/login_illustration.png",
            width: size.width * 0.55,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedInputField(
              hintText: "用户名",
              onChanged: (value) {
                this.username = value;
              }),
          RoundedPasswordField(
            onChanged: (value) {
              this.password = value;
            },
          ),
          RoundedButton(
            text: "登录",
            press: () => _handleAddShelf(this.username, this.password),
            // press: () => LoginRequest.requestLoginParams(this.username, this.password),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyHaveAnAccountCheck(
            press: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SignUpScreen();
            })),
          ),
        ],
      ),
    );
  }

  login(String username, String password) async {
    var map = {
      "username": username,
      "password": password
    };

    await post("login", formData: map).then((value) {
      print(map['username']);
      var data = json.decode(value.toString());
      UserResult result = UserResult.fromJson(data);
      print(result.data);
    });
  }
}

/// http_request.dart 中封装的 DIO,比http_util.dart中封装的要好
/// 但是那个有点复杂我暂时没搞懂特别是加了 Token 和其他一些设置
/// 暂时用下面那个进行使用后面在进行修补
class LoginRequest {
  static requestLoginParams(String username, String password) async {
    // 1.构建URL
    final loginURL = "http://192.168.124.9:8080/user/login}";
    // 2.发送网络请求获取结果
    final result = await XZHttpRequest.request(loginURL, method: "post", params: {
      'username': username,
      'password': password
    });

    print("result is $result");
  }
}

// POST 请求
_handleAddShelf (String username, String password) async {
  var result = await HttpUtils.request(
      '/user/login',
      method: HttpUtils.POST,
      data: {
        'username': username,
        'password': password
      }
  );
}
