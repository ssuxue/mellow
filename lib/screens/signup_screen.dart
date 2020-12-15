import 'package:flutter/material.dart';
import 'package:whitepeach/widgets/divider_icon_widget.dart';
import 'package:whitepeach/widgets/have_account_check.dart';
import 'package:whitepeach/widgets/rounded_button.dart';
import 'package:whitepeach/widgets/rounded_input_field.dart';

import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/signup_illustration.png",
            width: size.width * 0.55,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedInputField(hintText: "手机号", onChanged: (value) {}),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "登录",
            press: () {},
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LoginScreen();
            })),
          ),
          OrDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ThirdPartyIcon(
                svgSrc: "assets/icons/icon_QQ.svg",
                press: () {},
              ),
              ThirdPartyIcon(
                svgSrc: "assets/icons/icon_wechat.svg",
                press: () {},
              ),
              ThirdPartyIcon(
                svgSrc: "assets/icons/icon_weibo.svg",
                press: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
