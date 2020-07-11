import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/_model.dart';

class BlocDeliveryTimeState extends Equatable {
  final _props;

  BlocDeliveryTimeState({props}) : this._props = (props == null) ? [] : props;

  @override
  List<Object> get props => _props;
}

class BlocDeliveryTimeStateInitial extends BlocDeliveryTimeState {}

class BlocDeliveryTimeStateFetching extends BlocDeliveryTimeState {}

class BlocDeliveryTimeStateFetchingSuccess extends BlocDeliveryTimeState {
  final List<DeliveryTime> deliveryTimes;

  BlocDeliveryTimeStateFetchingSuccess({
    @required this.deliveryTimes,
  }) : super(props: [deliveryTimes]);
}

class BlocDeliveryTimeStateFetchingFailure extends BlocDeliveryTimeState {}

class BlocDeliveryTimeStateCUDFailure extends BlocDeliveryTimeStateCUD {}

class BlocDeliveryTimeStateCUDProcessing extends BlocDeliveryTimeStateCUD {}

abstract class BlocDeliveryTimeStateCUD extends BlocDeliveryTimeState {
  BlocDeliveryTimeStateCUD({props = const []}) : super(props: props);
}

class BlocDeliveryTimeStateCUDSuccess extends BlocDeliveryTimeStateCUD {}
