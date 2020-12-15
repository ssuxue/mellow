import 'package:flutter/material.dart';
import 'package:whitepeach/config/constants.dart';
import 'package:whitepeach/screens/login_screen.dart';
import 'package:whitepeach/screens/signup_screen.dart';
import 'package:whitepeach/widgets/header_clip_path.dart';
import 'package:whitepeach/widgets/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // FF表示透明度 后面6位是颜色
  List<Color> _colorList = [Color(0xFF7842B2), Color(0xFFFE8BD9)];
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        // 定义动画控制的范围
        lowerBound: -1.0,
        upperBound: 1.0,
        // 时间
        duration: Duration(milliseconds: 10000),
        // 初始值
        value: 0.0,
        vsync: this);

    // 重复执行
    _animationController.repeat();
  }

  @override
  void dispose() {
    // 销毁
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // 填充
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // 裁剪成自定义的图形
            AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget child) {
                  return ClipPath(
                    clipper: CustomHeaderClipPath(_animationController.value),
                    child: buildContainer(context),
                  );
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/drawkit_illustration.png",
                      width: size.width * 0.65,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedButton(
                      text: "登录",
                      textColor: Color(0xFF4b6584),
                      press: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      })),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedButton(
                      text: "注册",
                      color: kBlueLightColor,
                      textColor: Colors.black,
                      press: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUpScreen();
                      })),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.1,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      // MediaQuery.of(context).size.height:当前视图的高度
      height: size.height * 0.5,
      decoration: BoxDecoration(
        // 设置渐变样式背景
        gradient: LinearGradient(
            colors: _colorList,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
    );
  }
}
