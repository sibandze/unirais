import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/_model.dart';

class BlocResidenceState extends Equatable {
  final _props;

  BlocResidenceState({props}) : this._props = (props == null) ? [] : props;

  @override
  List<Object> get props => _props;
}

class BlocResidenceStateInitial extends BlocResidenceState {}

class BlocResidenceStateFetching extends BlocResidenceState {}

class BlocResidenceStateFetchingSuccess extends BlocResidenceState {
  final List<Residence> residences;

  BlocResidenceStateFetchingSuccess({
    @required this.residences,
  }) : super(props: [residences]);
}

class BlocResidenceStateFetchingFailure extends BlocResidenceState {}

class BlocResidenceStateCUDFailure extends BlocResidenceStateCUD {}

class BlocResidenceStateCUDProcessing extends BlocResidenceStateCUD {}

abstract class BlocResidenceStateCUD extends BlocResidenceState {
  BlocResidenceStateCUD({props = const []}) : super(props: props);
}

class BlocResidenceStateCUDSuccess extends BlocResidenceStateCUD {}
