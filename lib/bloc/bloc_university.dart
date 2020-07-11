import 'package:bloc/bloc.dart';

import './../repository/_repository.dart';
import './events/_events.dart';
import './states/_states.dart';

class BlocUniversity extends Bloc<BlocUniversityEvent, BlocUniversityState> {
  final _universityRepository = UniversityRepository.universityRepository;

  @override
  get initialState => BlocUniversityStateInitial();

  @override
  Stream<BlocUniversityState> mapEventToState(
      BlocUniversityEvent event) async* {
    if (event is BlocUniversityEventCUD) {
      yield BlocUniversityStateCUDProcessing();
      try {
        bool success = false;
        if (event is BlocUniversityEventCreate) {
          success = await _universityRepository.addUniversity(
              university: event.university);
        }
        if (event is BlocUniversityEventUpdate) {
          bool success = await _universityRepository.updateUniversity(
              university: event.university);
        } else if (event is BlocUniversityEventDelete) {
          success = await _universityRepository.deleteUniversity(
              university: event.university);
        }
        yield (success)
            ? BlocUniversityStateCUDSuccess()
            : BlocUniversityStateCUDFailure();
      } catch (e) {
        print(e);
        yield BlocUniversityStateCUDFailure();
      }
    } else if (state is BlocUniversityEventFetch) {
      yield BlocUniversityStateFetching();
      await Future.delayed(Duration(
        //milliseconds: LOADING_DELAY_TIME,
      ));
      try {
        final universities = await _universityRepository.getUniversities();
        yield BlocUniversityStateFetchingSuccess(universities: universities);
      } catch (e) {
        print(e);
        yield BlocUniversityStateFetchingFailure();
      }
    }
  }
}