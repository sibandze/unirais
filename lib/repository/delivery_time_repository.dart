import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import './../const/_const.dart' as CONSTANTS;
import './../model/_model.dart';
import './../services/web_service/webservice.dart';

class DeliveryTimeRepository {
  static final DeliveryTimeRepository deliveryTimeRepository =
      DeliveryTimeRepository();

  Future<List<DeliveryTime>> getDeliveryTimes() async {
    List<DeliveryTime> result = await WebService().get(
      Resource(
        parse: (http.Response response) {
          var _result = jsonDecode(response.body);
          return (_result['residencies'] as List)
              .map((e) => DeliveryTime.fromMap(e))
              .toList();
        },
        url: CONSTANTS.API_URL + '/app/residencies',
      ),
    );
    return result;
  }

  Future<bool> addDeliveryTime({@required DeliveryTime deliveryTime}) async {
    Map<String, dynamic> result = await WebService().post(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: deliveryTime.toMap(),
        url: CONSTANTS.API_URL + '/app/residencies/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> updateDeliveryTime({@required DeliveryTime deliveryTime}) async {
    Map<String, dynamic> result = await WebService().patch(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: deliveryTime.toMap(),
        url: CONSTANTS.API_URL + '/app/residencies/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> deleteDeliveryTime({@required DeliveryTime deliveryTime}) async {
    Map<String, dynamic> result = await WebService().delete(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        url: CONSTANTS.API_URL +
            '/app/residencies/index.php/?id=${deliveryTime.id}',
      ),
    );
    return result['success'];
  }
}
