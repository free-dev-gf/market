import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:market/cart.dart';
import 'package:market/commodity_item.dart';
import 'package:market/redux.dart';
import 'package:market/server.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Category _tab = Category.all;

  void changeTab(Category tab) {
    setState(() {
      _tab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Commodity> commodityData = Server.getCommodityData();
    var width = (MediaQuery.of(context).size.width - 60) / 2;
    var height = width + 70;

    return Scaffold(
      appBar: AppBar(
        title: const Text('轻松购物'),
      ),
      body: StoreConnector<List<ListItem>, List<ListItem>>(
          converter: (store) => store.state,
          builder: (context, cart) {
            Set<Category> tabs = {
              Category.all,
              ...commodityData.map((c) => c.category).toList().toSet(),
            };
            return Container(
                child: Stack(children: [
              Positioned(
                top: 0,
                left: 0,
                // 商品类别
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ListView(
                      padding: const EdgeInsets.all(8.0),
                      scrollDirection: Axis.horizontal,
                      children: tabs
                          .map(
                            (category) => GestureDetector(
                                onTap: () {
                                  changeTab(category);
                                },
                                child: Container(
                                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                                    child: SizedBox(
                                        child: DecoratedBox(
                                      child: Text(
                                        categoryMap[category].toString(),
                                      ),
                                      decoration: _tab == category
                                          ? const BoxDecoration(
                                              border: Border(
                                              bottom: BorderSide(width: 3.0, color: Colors.red),
                                            ))
                                          : const BoxDecoration(),
                                    )))),
                          )
                          .toList()),
                ),
              ),
              // 商品列表
              Container(
                  child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                margin: EdgeInsets.only(top: 50),
                child: GridView.count(
                  childAspectRatio: (width / height),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: commodityData
                      .where((element) => _tab == Category.all || element.category == _tab)
                      .map((c) => CommodityItem(
                            commodity: c,
                          ))
                      .toList(),
                ),
              )),
              // 购物车
              Cart()
            ]));
          }),
    );
  }
}
