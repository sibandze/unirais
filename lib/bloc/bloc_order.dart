import 'package:bloc/bloc.dart';

import './../repository/_repository.dart';
import './events/_events.dart';
import './states/_states.dart';

class BlocOrder extends Bloc<BlocOrderEvent, BlocOrderState> {
  final _orderRepository = OrderRepository.orderRepository;

  @override
  get initialState => BlocOrderStateInitial();

  @override
  Stream<BlocOrderState> mapEventToState(BlocOrderEvent event) async* {
    if (event is BlocOrderEventCUD) {
      yield BlocOrderStateCUDProcessing();
      try {
        bool success = false;
        if (event is BlocOrderEventCreate) {
          success = await _orderRepository.makeOrder(order: event.order);
        } else if (event is BlocOrderEventUpdate) {
          success = await _orderRepository.updateOrder(order: event.order);
        } else if (event is BlocOrderEventDelete) {
          success = await _orderRepository.deleteOrder(order: event.order);
        }
        yield (success)
            ? BlocOrderStateCUDSuccess()
            : BlocOrderStateCUDFailure();
      } catch (e) {
        print(e);
        yield BlocOrderStateCUDFailure();
      }
    } else if (event is BlocOrderEventFetch) {
      yield BlocOrderStateFetching();
      try {
        final orders = await _orderRepository.getOrders(
            orderState: event.orderState);
        yield BlocOrderStateFetchingSuccess(
            orders: orders);
      } catch (e) {
        print(e);
        yield BlocOrderStateFetchingFailure();
      }
    }
    else if (event is BlocOrderEventFetchOrder) {
      yield BlocOrderStateFetchingOrder();
      try {
        final order = await _orderRepository.getOrder(
            orderNumber: event.orderNumber);
        yield BlocOrderStateFetchingOrderSuccess(
            order: order);
      } catch (e) {
        print(e);
        yield BlocOrderStateFetchingOrderFailure();
      }
    }
  }
}