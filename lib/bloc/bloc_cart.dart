import 'dart:async';

import 'package:bloc/bloc.dart';

import './../model/_model.dart';
import './../repository/_repository.dart';
import './events/_events.dart';

class BlocCart extends Bloc<BlocCartEvent, Cart> {
  final _cartRepository = CartRepository();

  //Cart _cart = Cart();

  addToCart(CartItem cartItem) async {
    await _cartRepository.addToCart(cartItem);
  }

  updateCartItem(CartItem cartItem) async {
    await _cartRepository.updateCartItem(cartItem);
  }

  deleteCartItem(CartItem cartItem) async {
    await _cartRepository.deleteCartItemByProductId(cartItem.product.id);
  }

  deleteAllCartItems() async {
    await _cartRepository.deleteAllCartItems();
  }

  @override
  get initialState => Cart();

  @override
  Stream<Cart> mapEventToState(event) async* {
    if (event != null)
      switch (event.cartBlocEventType) {
        case BlocCartEventType.CREATE:
          await addToCart(event.cartItem);
          break;
        case BlocCartEventType.UPDATE:
          await updateCartItem(event.cartItem);
          break;
        case BlocCartEventType.DELETE:
          await deleteCartItem(event.cartItem);
          break;
        case BlocCartEventType.READ:
          break;
        case BlocCartEventType.DELETE_ALL:
          await deleteAllCartItems();
          break;
      }
    List<CartItem> _cartItems = await _cartRepository.getAllCartItems();

    yield Cart(cartItems: _cartItems);
  }
}
