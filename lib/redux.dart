import 'package:redux/redux.dart';

class AddCommodityAction {
  final int id;

  AddCommodityAction(this.id);
}

class RemoveCommodityAction {
  final int id;

  RemoveCommodityAction(this.id);
}

List<int> _addCommodity(List<int> cart, AddCommodityAction action) {
  return List.from(cart)..add(action.id);
}

List<int> _removeCommodity(List<int> cart, RemoveCommodityAction action) {
  return cart.where((id) => id != action.id).toList();
}

final cartReducer = combineReducers<List<int>>([
  TypedReducer(_addCommodity),
  TypedReducer(_removeCommodity),
]);
