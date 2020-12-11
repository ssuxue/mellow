import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperWidget extends StatelessWidget {
  final List list;

  SwiperWidget({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 333.0,
      width: 750.0,
      child: Swiper(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              // TODO 点击跳转某个商品
            },
            child: Image.network("$list[index]['image']", fit: BoxFit.cover,),
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
