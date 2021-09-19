import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:market/detail.dart';
import 'package:market/redux.dart';
import 'package:market/server.dart';
import 'package:vibration/vibration.dart';

class CommodityItem extends StatelessWidget {
  final Commodity commodity;

  const CommodityItem({Key? key, required this.commodity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 商品卡片
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
                // 商品图片
                Hero(
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          navigateToDetail(commodity.id, context);
                        },
                        child: Image(
                          image: AssetImage(getImagePath(commodity.id)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    tag: getImagePath(commodity.id)),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 6),
                  // 标题
                  child: Text(commodity.name,
                      overflow: TextOverflow.ellipsis, maxLines: 2, style: const TextStyle(color: Colors.black87)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 价格
                    Text(commodity.price.toString(), style: const TextStyle(color: Colors.red, fontSize: 16)),
                    DecoratedBox(
                        child: StoreConnector<List<ListItem>, VoidCallback>(converter: (store) {
                          return () async {
                            if (await Vibration.hasVibrator()) {
                              Vibration.vibrate();
                            }
                            store.dispatch(AddCommodityAction(commodity.id));
                          };
                        }, builder: (context, callback) {
                          return GestureDetector(
                              onTap: callback,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                // 购物车按钮
                                child: const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ));
                        }),
                        decoration: const BoxDecoration(
                            color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(20)))),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
