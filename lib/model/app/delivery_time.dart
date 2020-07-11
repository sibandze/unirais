import 'package:equatable/equatable.dart';

class DeliveryTime extends Equatable {
  final DateTime deliveryTime;
  final DateTime orderingCutOffTimes;
  final int id;

  DeliveryTime({this.deliveryTime, this.orderingCutOffTimes, this.id});

  @override
  List<Object> get props => [id];
}
