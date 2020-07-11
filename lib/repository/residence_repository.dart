import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import './../const/_const.dart' as CONSTANTS;
import './../model/_model.dart';
import './../services/web_service/webservice.dart';

class ResidenceRepository {
  static final ResidenceRepository residenceRepository = ResidenceRepository();

  Future<List<Residence>> getResidencies() async {
    List<Residence> result = await WebService().get(
      Resource(
        parse: (http.Response response) {
          var _result = jsonDecode(response.body);
          return (_result['residencies'] as List)
              .map((e) => Residence.fromMap(e))
              .toList();
        },
        url: CONSTANTS.API_URL + '/app/residencies',
      ),
    );
    return result;
  }

  Future<bool> addResidence({@required Residence residence}) async {
    Map<String, dynamic> result = await WebService().post(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: residence.toMap(),
        url: CONSTANTS.API_URL + '/app/residencies/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> updateResidence({@required Residence residence}) async {
    Map<String, dynamic> result = await WebService().patch(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: residence.toMap(),
        url: CONSTANTS.API_URL + '/app/residencies/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> deleteResidence({@required Residence residence}) async {
    Map<String, dynamic> result = await WebService().delete(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        url: CONSTANTS.API_URL +
            '/app/residencies/index.php/?id=${residence.id}',
      ),
    );
    return result['success'];
  }
}
