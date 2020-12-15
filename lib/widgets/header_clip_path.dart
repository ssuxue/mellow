import 'dart:math';

import 'package:flutter/material.dart';

class CustomHeaderClipPath extends CustomClipper<Path> {
  // 进度
  double progress;

  CustomHeaderClipPath(this.progress);

  /// 定义裁剪规则
  @override
  getClip(Size size) {
    // 构建Path
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.8);

    // 修改控制点
    double controlCenterX =
        size.width * 0.5 + (size.width * 0.6 + 1) * sin(progress * pi);
    double controlCenterY = size.height * 0.8 + 70 * cos(progress * pi);

    // 构建二阶曲线
    path.quadraticBezierTo(
        // 控制点
        controlCenterX,
        controlCenterY,
        // 结束点
        size.width,
        size.height * 0.8);

    path.lineTo(size.width, 0);

    return path;
  }

  /// 是否刷新
  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }
}
