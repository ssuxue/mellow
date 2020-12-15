import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whitepeach/config/constants.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      child: Row(
        children: [
          BuildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "其他方式",
              style: TextStyle(
                color: Color(0xFF636E72),
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
          BuildDivider(),
        ],
      ),
    );
  }
}

class BuildDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        color: Color(0xFFB2BEC3),
        height: 1.5,
      ),
    );
  }
}

class ThirdPartyIcon extends StatelessWidget {
  final String svgSrc;
  final Function press;

  const ThirdPartyIcon({
    Key key,
    this.svgSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: mHintofPensive,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          svgSrc,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
