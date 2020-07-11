import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/_model.dart';

class BlocUniversityEvent extends Equatable {
  final _props;

  BlocUniversityEvent({props}) : this._props = (props == null) ? [] : props;

  @override
  List<Object> get props => _props;
}

class BlocUniversityEventFetch extends BlocUniversityEvent {}

abstract class BlocUniversityEventCUD extends BlocUniversityEvent {
  BlocUniversityEventCUD({props}) : super(props: props);
}

class BlocUniversityEventCreate extends BlocUniversityEventCUD {
  final University university;

  BlocUniversityEventCreate({@required this.university})
      : super(props: [university]);
}

class BlocUniversityEventUpdate extends BlocUniversityEventCUD {
  final University university;

  BlocUniversityEventUpdate({@required this.university})
      : super(props: [university]);
}

class BlocUniversityEventDelete extends BlocUniversityEventCUD {
  final University university;

  BlocUniversityEventDelete({@required this.university})
      : super(props: [university]);
}
