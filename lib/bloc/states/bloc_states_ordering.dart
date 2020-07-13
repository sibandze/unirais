import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/_model.dart';

abstract class BlocOrderState extends Equatable {
  final _props;

  BlocOrderState({props}) : this._props = (props == null) ? [] : props;

  @override
  List<Object> get props => _props;
}

class BlocOrderStateInitial extends BlocOrderState {}

class BlocOrderStateFetching extends BlocOrderState {}

class BlocOrderStateFetchingSuccess extends BlocOrderState {
  final List<Order> orders;

  BlocOrderStateFetchingSuccess({
    @required this.orders,
  }) : super(props: [orders]);
}

class BlocOrderStateFetchingFailure extends BlocOrderState {}

class BlocOrderStateFetchingOrder extends BlocOrderState {}

class BlocOrderStateFetchingOrderSuccess extends BlocOrderState {
  final Order order;

  BlocOrderStateFetchingOrderSuccess({
    @required this.order,
  }) : super(props: [order]);
}

class BlocOrderStateFetchingOrderFailure extends BlocOrderState {}

class BlocOrderStateCUDFailure extends BlocOrderStateCUD {}

class BlocOrderStateCUDProcessing extends BlocOrderStateCUD {}

abstract class BlocOrderStateCUD extends BlocOrderState {
  BlocOrderStateCUD({props = const []}) : super(props: props);
}

class BlocOrderStateCUDSuccess extends BlocOrderStateCUD {}