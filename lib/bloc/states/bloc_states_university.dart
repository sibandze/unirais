import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../model/_model.dart';

class BlocUniversityState extends Equatable {
  final _props;

  BlocUniversityState({props}) : this._props = (props == null) ? [] : props;

  @override
  List<Object> get props => _props;
}

class BlocUniversityStateInitial extends BlocUniversityState {}

class BlocUniversityStateFetching extends BlocUniversityState {}

class BlocUniversityStateFetchingSuccess extends BlocUniversityState {
  final List<University> universities;

  BlocUniversityStateFetchingSuccess({
    @required this.universities,
  }) : super(props: [universities]);
}

class BlocUniversityStateFetchingFailure extends BlocUniversityState {}

class BlocUniversityStateCUDFailure extends BlocUniversityStateCUD {}

class BlocUniversityStateCUDProcessing extends BlocUniversityStateCUD {}

abstract class BlocUniversityStateCUD extends BlocUniversityState {
  BlocUniversityStateCUD({props = const []}) : super(props: props);
}

class BlocUniversityStateCUDSuccess extends BlocUniversityStateCUD {}
