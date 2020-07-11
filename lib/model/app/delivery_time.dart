import 'package:equatable/equatable.dart';

import './../../const/_const.dart' as CONSTANTS;

class DeliveryTime extends Equatable {
  final DateTime deliveryTime;
  final DateTime orderingCutOffTimes;
  final int id;

  DeliveryTime({this.deliveryTime, this.orderingCutOffTimes, this.id = -1});

  @override
  List<Object> get props => [id];

  factory DeliveryTime.fromMap(Map res) {
    return DeliveryTime(
      orderingCutOffTimes: DateTime.parse(res['ordering_cut_off_times']),
      deliveryTime: DateTime.parse(res['delivery_time']),
      id: res['id'],
    );
  }

  Map<String, String> toMap() => {
        CONSTANTS.ROW_ID: id.toString(),
        'delivery_time': deliveryTime.toString(),
        'ordering_cut_off_times': orderingCutOffTimes.toString(),
      };
}
