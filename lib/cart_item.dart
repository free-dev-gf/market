import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:market/redux.dart';
import 'package:market/server.dart';
import 'package:redux/redux.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key, required this.id, required this.count}) : super(key: key);
  final int id;
  final int count;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late Commodity commodity;

  @override
  void initState() {
    super.initState();
    commodity = Server.getCommodityById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: DecoratedBox(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 15,
                      // 商品图片
                      child: Image(
                        image: AssetImage(getImagePath(commodity.id)),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                        flex: 30,
                        child: Wrap(
                          children: [
                            // 标题
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text(commodity.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(color: Colors.black87)),
                            ),
                            // 店铺
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_mall,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 4),
                                    child: Text(
                                      commodity.shop,
                                      style: TextStyle(color: Colors.black45, fontSize: 12),
                                    ))
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // 价格
                                    Text(commodity.price.toString(),
                                        style: const TextStyle(
                                            color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
                                    StoreConnector<List<ListItem>, Store<List<ListItem>>>(
                                        converter: (store) => store,
                                        builder: (context, store) {
                                          // 数量操作
                                          return Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.black45,
                                                ),
                                                onPressed: () {
                                                  store.dispatch(RemoveCommodityAction(widget.id));
                                                },
                                              ),
                                              Text(widget.count.toString()),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  store.dispatch(AddCommodityAction(widget.id));
                                                },
                                              ),
                                            ],
                                          );
                                        })
                                  ],
                                ))
                          ],
                        )),
                  ],
                )),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
        ));
  }
}
