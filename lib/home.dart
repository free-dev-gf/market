import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:market/redux.dart';
import 'package:market/server.dart';

class CommodityItem extends StatelessWidget {
  final Commodity commodity;

  const CommodityItem({Key? key, required this.commodity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(getImagePath(commodity.id)),
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                  child: Text(commodity.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(color: Colors.black38)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(commodity.price.toString(),
                        style:
                            const TextStyle(color: Colors.red, fontSize: 16)),
                    DecoratedBox(
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

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
      body: StoreConnector<List<int>, List<int>>(
          converter: (store) => store.state,
          builder: (context, cart) {
            Set<Category> tabs = {
              Category.all,
              ...commodityData.map((c) => c.category).toList().toSet(),
            };
            return Column(children: [
              // 商品类别
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45,
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
                                  margin:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 0),
                                  child: SizedBox(
                                      child: DecoratedBox(
                                    child: Text(
                                      categoryMap[category].toString(),
                                    ),
                                    decoration: _tab == category
                                        ? const BoxDecoration(
                                            border: Border(
                                            bottom: BorderSide(
                                                width: 3.0, color: Colors.red),
                                          ))
                                        : const BoxDecoration(),
                                  )))),
                        )
                        .toList()),
              ),
              // 商品列表
              Expanded(
                  child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: GridView.count(
                  childAspectRatio: (width / height),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: commodityData
                      .where((element) =>
                          _tab == Category.all || element.category == _tab)
                      .map((c) => CommodityItem(
                            commodity: c,
                          ))
                      .toList(),
                ),
              ))
            ]);
          }),
      floatingActionButton:
          StoreConnector<List<int>, VoidCallback>(converter: (store) {
        return () => store.dispatch(AddCommodityAction(1));
      }, builder: (context, callback) {
        return FloatingActionButton(
          onPressed: callback,
          tooltip: 'cart',
          child: const Icon(Icons.shopping_cart),
        );
      }),
    );
  }
}
