import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/_model.dart';

class BlocDeliveryTimeEvent extends Equatable {
  final _props;

  BlocDeliveryTimeEvent({props}) : this._props = (props == null) ? [] : props;

  @override
  List<Object> get props => _props;
}

class BlocDeliveryTimeEventFetch extends BlocDeliveryTimeEvent {
  final Address address;

  BlocDeliveryTimeEventFetch({@required this.address});
}

abstract class BlocDeliveryTimeEventCUD extends BlocDeliveryTimeEvent {
  BlocDeliveryTimeEventCUD({props}) : super(props: props);
}

class BlocDeliveryTimeEventCreate extends BlocDeliveryTimeEventCUD {
  final DeliveryTime deliveryTime;

  BlocDeliveryTimeEventCreate({@required this.deliveryTime})
      : super(props: [deliveryTime]);
}

class BlocDeliveryTimeEventUpdate extends BlocDeliveryTimeEventCUD {
  final DeliveryTime deliveryTime;

  BlocDeliveryTimeEventUpdate({@required this.deliveryTime})
      : super(props: [deliveryTime]);
}

class BlocDeliveryTimeEventDelete extends BlocDeliveryTimeEventCUD {
  final DeliveryTime deliveryTime;

  BlocDeliveryTimeEventDelete({@required this.deliveryTime})
      : super(props: [deliveryTime]);
}
