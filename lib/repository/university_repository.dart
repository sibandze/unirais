import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import './../const/_const.dart' as CONSTANTS;
import './../model/_model.dart';
import './../services/web_service/webservice.dart';

class UniversityRepository {
  static final UniversityRepository universityRepository =
      UniversityRepository();

  Future<List<University>> getUniversities() async {
    List<University> _uniList = await WebService().get(
      Resource(
        parse: (http.Response response) {
          var _result = jsonDecode(response.body);
          return (_result['universities'] as List)
              .map((e) => University.fromMap(e))
              .toList();
        },
        url: CONSTANTS.API_URL + '/app/universities',
      ),
    );
    return _uniList;
  }

  Future<bool> addUniversity({@required University university}) async {
    Map<String, dynamic> result = await WebService().post(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: university.toMap(),
        url: CONSTANTS.API_URL + '/app/universities/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> updateUniversity({@required University university}) async {
    Map<String, dynamic> result = await WebService().patch(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        params: university.toMap(),
        url: CONSTANTS.API_URL + '/app/universities/index.php',
      ),
    );
    return result['success'];
  }

  Future<bool> deleteUniversity({@required University university}) async {
    Map<String, dynamic> result = await WebService().delete(
      Resource(
        parse: (http.Response response) {
          return jsonDecode(response.body);
        },
        url: CONSTANTS.API_URL +
            '/app/universities/index.php/?id=${university.id}',
      ),
    );
    return result['success'];
  }
}