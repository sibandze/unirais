import 'package:bloc/bloc.dart';

import './../repository/_repository.dart';
import './events/_events.dart';
import './states/_states.dart';

class BlocDeliveryTime
    extends Bloc<BlocDeliveryTimeEvent, BlocDeliveryTimeState> {
  final _deliveryTimeRepository = DeliveryTimeRepository.deliveryTimeRepository;

  @override
  get initialState => BlocDeliveryTimeStateInitial();

  @override
  Stream<BlocDeliveryTimeState> mapEventToState(
      BlocDeliveryTimeEvent event) async* {
    if (event is BlocDeliveryTimeEventCUD) {
      yield BlocDeliveryTimeStateCUDProcessing();
      try {
        bool success = false;
        if (event is BlocDeliveryTimeEventCreate) {
          success = await _deliveryTimeRepository.addDeliveryTime(
              deliveryTime: event.deliveryTime);
        } else if (event is BlocDeliveryTimeEventUpdate) {
          success = await _deliveryTimeRepository.updateDeliveryTime(
              deliveryTime: event.deliveryTime);
        } else if (event is BlocDeliveryTimeEventDelete) {
          success = await _deliveryTimeRepository.deleteDeliveryTime(
              deliveryTime: event.deliveryTime);
        }
        yield (success)
            ? BlocDeliveryTimeStateCUDSuccess()
            : BlocDeliveryTimeStateCUDFailure();
      } catch (e) {
        print(e);
        yield BlocDeliveryTimeStateCUDFailure();
      }
    } else if (event is BlocDeliveryTimeEventFetch) {
      yield BlocDeliveryTimeStateFetching();
      try {
        final deliveryTimes = await _deliveryTimeRepository.getDeliveryTimes(
            address: event.address);
        yield BlocDeliveryTimeStateFetchingSuccess(
            deliveryTimes: deliveryTimes);
      } catch (e) {
        print(e);
        yield BlocDeliveryTimeStateFetchingFailure();
      }
    }
  }
}
