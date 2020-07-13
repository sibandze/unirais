import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import './../const/_const.dart' as CONSTANTS;
import './../model/shop/_shop.dart';
import './../services/_services.dart';
import './user_repository.dart';

class OrderRepository {
  static final OrderRepository orderRepository = OrderRepository();
  List<Order> orderList;

  Future<List<Order>> getOrders({OrderState orderState}) async {
    int userId = await UserRepository.userRepository.getUser();

    orderList = await WebService().get(
      Resource(
        parse: (http.Response response) {
          return (jsonDecode(response.body)['orders'] as List)
              .map((e) => Order.fromMap(e))
              .toList();
        },
        url: CONSTANTS.API_URL +
            '/app/orders/?uid=$userId' +
            ((orderState == null) ? '' : '&order_state=${orderState.value}'),
      ),
    );
    return orderList;
  }

  Future<Order> getOrder({
    @required String orderNumber,
  }) async {
    int userId = await UserRepository.userRepository.getUser();
    return await WebService().get(
      Resource(
        parse: (http.Response response) {
          return Order.fromMap(jsonDecode(response.body));
        },
        url: CONSTANTS.API_URL + '/app/orders/?order_number=$orderNumber',
      ),
    );
  }

  Future<bool> makeOrder({
    @required Order order,
  }) async {
    int userId = await UserRepository.userRepository.getUser();
    Map<String, dynamic> orderResult = await WebService().post(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: order.toMap(userId),
        url: CONSTANTS.API_URL + '/app/orders/index.php',
      ),
    );
    if (orderResult['success'] == true) {
      var orderId = orderResult['order_id'];

      for (var e in order.orderItems) {
        await WebService().post(
          Resource(
            parse: (http.Response response) {
              return jsonDecode(response.body);
            },
            params: e.toMap(orderId),
            url: CONSTANTS.API_URL + '/app/orders/order_item.php',
          ),
        );
      }
      return true;
    } else
      return false;
  }

  Future<bool> updateOrder({@required Order order}) async {
    int userId = await UserRepository.userRepository.getUser();
    Map<String, dynamic> result = await WebService().post(
      // TODO: change to patch
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: order.toMap(userId),
        url: CONSTANTS.API_URL + '/app/orders/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> deleteOrder({@required Order order}) async {
    Map<String, dynamic> result = await WebService().delete(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        url: CONSTANTS.API_URL +
            '/app/orders/index.php/?id=${order.orderNumber}',
      ),
    );
    return result['success'];
  }
}
