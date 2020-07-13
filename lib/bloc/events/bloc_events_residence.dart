import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/_model.dart';

class BlocResidenceEvent extends Equatable {
  final _props;

  BlocResidenceEvent({props}) : this._props = (props == null) ? [] : props;

  @override
  List<Object> get props => _props;
}

class BlocResidenceEventFetch extends BlocResidenceEvent {
  final University university;

  BlocResidenceEventFetch({@required this.university})
      : super(props: [university]);
}

abstract class BlocResidenceEventCUD extends BlocResidenceEvent {
  BlocResidenceEventCUD({props}) : super(props: props);
}

class BlocResidenceEventCreate extends BlocResidenceEventCUD {
  final Residence residence;

  BlocResidenceEventCreate({@required this.residence})
      : super(props: [residence]);
}

class BlocResidenceEventUpdate extends BlocResidenceEventCUD {
  final Residence residence;

  BlocResidenceEventUpdate({@required this.residence})
      : super(props: [residence]);
}

class BlocResidenceEventDelete extends BlocResidenceEventCUD {
  final Residence residence;

  BlocResidenceEventDelete({@required this.residence})
      : super(props: [residence]);
}
