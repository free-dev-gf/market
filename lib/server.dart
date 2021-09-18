enum Category {
  all,
  toyAppliances,
  petLife,
  computer,
}

const Map<Category, String> categoryMap = {
  Category.all: '全部商品',
  Category.toyAppliances: '玩具电器',
  Category.petLife: '宠物生活',
  Category.computer: '电脑数码',
};

String getImagePath(int id) => 'assets/images/commodity_$id.jpeg';

const List<Commodity> _commodityData = [
  Commodity(
    id: 2,
    name: 'Apple iPhone 13 (A2634) 128GB 粉色 支持移动联通电信5G 双卡双待手机',
    evaluation: 7846,
    price: 5999.00,
    shop: '中国移动官方旗舰店',
    category: Category.computer,
  ),
  Commodity(
    id: 3,
    name: 'Apple iPhone 12 (A2404) 128GB 黑色 支持移动联通电信5G 双卡双待手机',
    evaluation: 204587,
    price: 6199.00,
    shop: 'Apple产品京东自营旗舰店',
    category: Category.computer,
  ),
  Commodity(
    id: 4,
    name: '京品手机Apple iPhone 11 (A2223) 128GB 白色 移动联通电信4G手机 ',
    evaluation: 23487,
    price: 4799.00,
    shop: 'Apple产品京东自营旗舰店',
    category: Category.computer,
  ),
  Commodity(
    id: 5,
    name:
        'Apple iPad Air 10.9英寸 平板电脑（ 2020年新款 64G WLAN版/A14芯片/触控ID/全面屏MYFQ2CH/A）天蓝色',
    evaluation: 353,
    price: 4399.00,
    shop: 'Apple产品京东自营旗舰店',
    category: Category.computer,
  ),
  Commodity(
    id: 6,
    name: 'Apple iPhone 12 Pro Max (A2412) 256GB 海蓝色 支持移动联通电信5G 双卡双待手机 ',
    evaluation: 8090,
    price: 8599.00,
    shop: 'Apple产品京东自营旗舰店',
    category: Category.computer,
  ),
  Commodity(
    id: 7,
    name:
        'Apple MacBook Air 13.3 新款8核M1芯片(7核图形处理器) 8G 256G SSD 银色 笔记本电脑 MGN93CH/A ',
    evaluation: 23453,
    price: 7999.00,
    shop: 'Apple产品京东自营旗舰店',
    category: Category.computer,
  ),
  Commodity(
    id: 0,
    name: '益米 儿童仿真过家家小家电玩具 洗衣机玩具男孩女孩 电动滚筒可加水洗衣机玩具 生日礼物礼品',
    evaluation: 10023,
    price: 139.00,
    shop: '益米玩具京东自营官方旗舰店',
    category: Category.toyAppliances,
  ),
  Commodity(
    id: 1,
    name: '德力普（Delipow） 充电电池 5号/7号电池 配12节电池充电器套装 充电器+12节电池【5号/7号各6节】',
    evaluation: 204587,
    price: 42.90,
    shop: '德力普数码旗舰店',
    category: Category.toyAppliances,
  ),
  Commodity(
    id: 8,
    name:
        'KimPets狗窝 猫窝【可拆洗机洗】宠物狗垫子冬季四季通用舒适可拆洗泰迪金毛柴犬小中大型犬送骨头枕S码 【赠稀释瓶】【一瓶可抵200瓶】浓缩型宠物消毒液1000ML，环境去味，消毒除异味，清洁率99.9%，点击抢购！》》',
    evaluation: 695,
    price: 69.00,
    shop: 'KimPets宠物生活京东自营旗舰店',
    category: Category.petLife,
  ),
  Commodity(
    id: 9,
    name:
        '澳洲Mr Clean 猫碗狗碗猫咪自动喂食器猫盆狗盆宠物食盆碗猫水盆猫咪饮水机 防湿嘴（黄色三碗） 【赠稀释瓶】【一瓶可抵200瓶】浓缩型宠物消毒液1000ML，环境去味，消毒除异味，清洁率99.9%，点击抢购！》》',
    evaluation: 56,
    price: 39.90,
    shop: 'Mr Clean宠物生活京东自营旗舰店',
    category: Category.petLife,
  ),
];

class Server {
  static List<Commodity> getCommodityData() => _commodityData;

  static Commodity getCommodityById(int id) {
    return _commodityData.firstWhere((element) => element.id == id);
  }

  static Commodity getCommodityByCategory(Category category) {
    return _commodityData.firstWhere((element) => element.category == category);
  }
}

// 商品
class Commodity {
  final int id;
  final String name;
  final int evaluation;
  final double price;
  final String shop;
  final Category category;

  const Commodity({
    required this.id,
    required this.name,
    required this.evaluation,
    required this.price,
    required this.shop,
    required this.category,
  });

  factory Commodity.fromJson(Map<String, dynamic> json) {
    return Commodity(
        id: json['id'],
        name: json['name'],
        evaluation: json['evaluation'],
        shop: json['shop'],
        category: json['category'],
        price: json['price']);
  }
}
