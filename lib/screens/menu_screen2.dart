import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:whitepeach/model/product_model.dart';
import 'package:whitepeach/service/http_service.dart';
import 'package:whitepeach/widgets/bottom_nav_bar.dart';
import 'package:whitepeach/model/category_model.dart';

/// 点菜页面：左边一级分类  右边分类内容
class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen>
    with AutomaticKeepAliveClientMixin {
  /// 防止刷新处理，保持当前状态
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        body: SafeArea(
          child: Container(
            child: Row(
              children: [
                LeftCategoryNav(),
                CategoryGoodsList(),
              ],
            ),
          ),
        ));
  }
}

class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CategoryState(),
      child: Consumer<CategoryState>(builder: (context, model, child) {
        // 获取商品列表
        listIndex = model.firstCategoryIndex;
        return Container(
          width: 100.0,
          decoration: BoxDecoration(
              border: Border(
                // left: BorderSide(  // TODO 选中才显示这个颜色但是我暂时没解决
                //     width: 5, color: Color.fromRGBO(250, 142, 22, 1.0)),
                  right: BorderSide(
                      width: 1, color: Color.fromRGBO(226, 225, 228, 1.0)))),
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _leftInkWel(index);
              }),
        );
      }),
    );
  }

  Widget _leftInkWel(int index) {
    bool isSelected = false;
    isSelected = (index == listIndex);

    return InkWell(
      onTap: () {
        // var productLis
        var cid = list[index].id;
        Provider.of<CategoryState>(context, listen: false)
            .changeCategoryId(cid);
      },
      child: Container(
          height: 70,
          padding: EdgeInsets.only(left: 5, top: 5),
          decoration: BoxDecoration(
              color: isSelected
                  ? Color.fromRGBO(236, 238, 239, 1.0)
                  : Colors.white,
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(226, 225, 228, 1.0)),
                  left: BorderSide(
                      width: 1,
                      color: isSelected ? Colors.purple : Colors.white))),
          child: Column(
            children: [
              SvgPicture.asset("assets/icons/" + list[index].icon,
                  height: 30, width: 30),
              Text(
                list[index].name,
                style: TextStyle(
                    color: isSelected
                        ? Colors.black
                        : Color.fromRGBO(94, 97, 109, 1.0)),
              )
            ],
          )),
    );
  }

  /// 获取分类数据
  _getCategory() async {
    await request("getCategory").then((value) {
      var data = json.decode(value.toString());
      // print(data['result']);
      CategoryModel category = CategoryModel.fromJson(data["result"]);

      setState(() {
        list = category.data;
      });

      Provider.of<CategoryState>(context).getSecondCategory(list[0], 4);
    });
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  List products = [];

  @override
  void initState() {
    super.initState();
    int cid = Provider.of<CategoryState>(context, listen: false).firstCategoryId;
    _getProductsByCid(cid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
    );
  }

  /// 通过分类获取奶茶
  _getProductsByCid(int id) async {
    await request("getMilkyTeaByCid", formData: id).then((value) {
      var data = json.decode(value.toString());
      print(data['result']);
      ProductResult result = ProductResult.fromJson(data["result"]);

      setState(() {
        products = result.data;
      });
    });
  }
}
