import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/_model.dart';

abstract class BlocOrderEvent extends Equatable {
  final _props;

  BlocOrderEvent({props = const []}) : this._props = props;

  @override
  List<Object> get props => _props;
}

class BlocOrderEventFetch extends BlocOrderEvent {
  final OrderState orderState;

  BlocOrderEventFetch({this.orderState}) :super(props: [orderState]);
}

class BlocOrderEventFetchOrder extends BlocOrderEvent {
  final String orderNumber;

  BlocOrderEventFetchOrder({@required this.orderNumber})
      :super(props: [orderNumber]);
}

abstract class BlocOrderEventCUD extends BlocOrderEvent {
  BlocOrderEventCUD({props}) : super(props: props);
}

class BlocOrderEventCreate extends BlocOrderEventCUD {
  final Order order;

  BlocOrderEventCreate({@required this.order})
      : super(props: [order]);
}

class BlocOrderEventUpdate extends BlocOrderEventCUD {
  final Order order;

  BlocOrderEventUpdate({@required this.order})
      : super(props: [order]);
}

class BlocOrderEventDelete extends BlocOrderEventCUD {
  final Order order;

  BlocOrderEventDelete({@required this.order})
      : super(props: [order]);
}