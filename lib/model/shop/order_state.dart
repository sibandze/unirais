import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  final int value;
  final String state;

  OrderState(this.value, this.state);

  @override
  List<Object> get props => [value, state];
}

class PendingOrder extends OrderState {
  PendingOrder() : super(0, 'Pending');
}

class ConfirmedOrder extends OrderState {
  ConfirmedOrder() : super(1, 'Confirmed');
}

class DeliveredOrder extends OrderState {
  DeliveredOrder() : super(2, 'Delivered');
}

class CancelledOrder extends OrderState {
  CancelledOrder() : super(3, 'Cancelled');
}

/*class OrderCancelledByUser extends CancelledOrder {
  OrderCancelledByUser() : super(3);
}

class OrderCancelledByAdmin extends CancelledOrder {
  OrderCancelledByAdmin() : super(4);
}*/
