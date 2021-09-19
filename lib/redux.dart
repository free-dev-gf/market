import 'package:redux/redux.dart';

class AddCommodityAction {
  final int id;

  AddCommodityAction(this.id);
}

class RemoveCommodityAction {
  final int id;

  RemoveCommodityAction(this.id);
}

class ClearCartAction {
  ClearCartAction();
}

class ListItem {
  final int id;
  int count;

  ListItem(this.id, this.count);
}

List<ListItem> _addCommodity(List<ListItem> cart, AddCommodityAction action) {
  var newCart = cart;
  var index = cart.indexWhere((element) => element.id == action.id);
  if (index > -1) {
    newCart[index].count += 1;
  } else {
    newCart.add(ListItem(action.id, 1));
  }
  return newCart;
}

List<ListItem> _removeCommodity(List<ListItem> cart, RemoveCommodityAction action) {
  var newCart = cart;
  var index = cart.indexWhere((element) => element.id == action.id);
  if (index > -1 && newCart[index].count > 1) {
    newCart[index].count -= 1;
  } else {
    newCart.removeAt(index);
  }
  return newCart;
}

List<ListItem> _clearCart(List<ListItem> cart, ClearCartAction action) {
  return [];
}

final cartReducer = combineReducers<List<ListItem>>([
  TypedReducer(_addCommodity),
  TypedReducer(_removeCommodity),
  TypedReducer(_clearCart),
]);
