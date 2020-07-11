import './../../model/_model.dart';

enum BlocCartEventType { CREATE, READ, UPDATE, DELETE, DELETE_ALL }

class BlocCartEvent {
  BlocCartEventType cartBlocEventType;

  CartItem cartItem;

  BlocCartEvent() : cartBlocEventType = BlocCartEventType.READ;

  BlocCartEvent.create(product)
      : cartBlocEventType = BlocCartEventType.CREATE,
        cartItem = CartItem(product: product);

  BlocCartEvent.update(this.cartItem)
      : cartBlocEventType = cartItem.quantity > 0
            ? BlocCartEventType.UPDATE
            : BlocCartEventType.DELETE;

  BlocCartEvent.delete(this.cartItem)
      : cartBlocEventType = BlocCartEventType.DELETE;

  BlocCartEvent.deleteAll() : cartBlocEventType = BlocCartEventType.DELETE_ALL;
}
