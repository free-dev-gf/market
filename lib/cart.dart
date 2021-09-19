import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:market/cart_item.dart';
import 'package:market/redux.dart';
import 'package:market/server.dart';
import 'package:redux/redux.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _show = false;

  void showCart() {
    setState(() {
      _show = true;
    });
  }

  void hideCart() {
    setState(() {
      _show = false;
    });
  }

  Widget renderBtn(Color color, String text, VoidCallback onTap) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: size.width / 2 - 40,
          height: 40,
          child: DecoratedBox(
            child: Center(child: Text(text, style: TextStyle(color: Colors.white, fontSize: 16))),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Positioned(
      bottom: _show ? 0 : 20,
      right: _show ? 0 : 20,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: _show ? size.width : 50,
        height: _show ? size.height : 50,
        color: _show ? Color.fromARGB(255, 250, 250, 250) : Colors.transparent,
        curve: Curves.ease,
        child: _show
            ? StoreConnector<List<ListItem>, Store<List<ListItem>>>(
                converter: (store) => store,
                builder: (context, store) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(30, 80, 30, 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                store.dispatch(ClearCartAction());
                              },
                              child: Text('共${store.state.length}件商品'),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                              ),
                              onPressed: () {
                                store.dispatch(ClearCartAction());
                              },
                              child: Text('清空购物车'),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width,
                          height: size.height - 190,
                          child: ListView(
                            children: store.state.map((item) => CartItem(id: item.id, count: item.count)).toList(),
                          ),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          renderBtn(Colors.orange, '返回主页', () {
                            hideCart();
                          }),
                          renderBtn(Colors.red, '立即购买', () {
                            Fluttertoast.showToast(msg: "钱包空空如也~");
                          }),
                        ]),
                      ],
                    ),
                  );
                })
            : GestureDetector(
                onTap: () {
                  showCart();
                },
                // 购物车按钮
                child: DecoratedBox(
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 30,
                    ),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.8), spreadRadius: 1, blurRadius: 3, offset: Offset(1, 1))
                    ], color: Colors.red, borderRadius: BorderRadius.all(Radius.circular(30)))),
              ),
      ),
    );
  }
}
