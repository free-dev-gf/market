import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:market/redux.dart';
import 'package:market/server.dart';
import 'package:flutter/services.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<Detail> createState() => _DetailState();
}

final commonTextStyle = TextStyle(color: Colors.black87, fontSize: 16, decoration: TextDecoration.none);

class _DetailState extends State<Detail> {
  late Commodity commodity;

  @override
  void initState() {
    super.initState();
    commodity = Server.getCommodityById(widget.id);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              foregroundColor: Colors.red,
              backgroundColor: Colors.orange,
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,
                ],
                centerTitle: true,
                title: Text("商品详情",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                        color: Colors.white,
                        child: Image(
                          image: AssetImage(getImagePath(widget.id)),
                          fit: BoxFit.contain,
                        )),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.0, 1),
                          end: Alignment(0.0, 0.4),
                          colors: <Color>[
                            Color(0x40000000),
                            Color(0x00000000),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    // 价格
                    Text(commodity.price.toString(),
                        style: commonTextStyle.merge(TextStyle(fontSize: 20, color: Colors.red))),
                    // 标题
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(commodity.name,
                          overflow: TextOverflow.ellipsis, maxLines: 4, style: commonTextStyle.merge(TextStyle())),
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    '店铺：${commodity.shop}',
                    style: commonTextStyle.merge(TextStyle()),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text('评价数：${commodity.evaluation}', style: commonTextStyle.merge(TextStyle())),
                )
              ],
            )));
  }
}

navigateToDetail(int id, BuildContext context) {
  return Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return Detail(id: id);
  }));
}
