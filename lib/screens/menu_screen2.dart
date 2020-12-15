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

  /// 设置分类的InkWell
  Widget _leftInkWel(int index) {
    bool isSelected = false;
    isSelected = (index == listIndex);

    return InkWell(
      onTap: () {
        // var productLis
        var cid = list[index].id;
        context.read<CategoryState>().changeCategoryId(cid);
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
    var state = context.read<CategoryState>();
    int cid = state.categoryId;
    cid ??= 2;
    // print("这里是分类ID:$cid");
    _getProductsByCid(cid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return _milkyTeaInkWel(index);
          }),
    );
  }

  /// 通过分类获取奶茶
  _getProductsByCid(int id) async {
    await request("getMilkyTeaByCid", formData: id).then((value) {
      var data = json.decode(value.toString());
      ProductResult result = ProductResult.fromJson(data["result"]);

      setState(() {
        products = result.data;
      });
    });
  }


  /// 设置奶茶的InkWell
  Widget _milkyTeaInkWel(int index) {

    return InkWell(
      onTap: () {
        // var productDetail
      },
      child: Container(
        // color: Colors.white,
          height: 140,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 2, color: Color.fromRGBO(226, 225, 228, 1.0)))),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90,
                    child: Image.network(products[index].picture),
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        products[index].name,
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            color: Color.fromRGBO(198, 223, 200, 0.6),
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(right: 10),
                            child: Text(
                              "可做冷饮",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            color: Color.fromRGBO(225, 225, 236, 0.6),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "含乳制品、茶",
                              style: TextStyle(color: Colors.black38),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                // products[index].description,
                                "冷500ml 耶耶冰淇凌打顶", // TODO 用这里这个错误令人窒息，长度溢出完全解决不了
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 15.0
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "优质生耶乳与芒芒冰沙轻轻...", // TODO 暂时手动写两行
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 15.0
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "￥${products[index].price}",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 25,
                            width: 78,
                            child: RaisedButton(
                              color: Color.fromRGBO(250, 152, 58, 1.0),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13)),
                              child: Text("选规格"),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
