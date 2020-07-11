import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './../../const/_const.dart' as CONSTANTS;

class Residence extends Equatable {
  final String name;
  final int id;
  final double long;
  final double lat;
  final int zipCode;
  final int universityId;

  Residence({
    @required this.name,
    this.id = -1,
    @required this.long,
    @required this.lat,
    @required this.zipCode,
    @required this.universityId,
  });

  @override
  List<Object> get props => [id, long, lat];

  factory Residence.fromMap(Map res) {
    return Residence(
      zipCode: res['zip_code'],
      long: (res['lon'] is int) ? res['lon'].toDouble() : res['lon'],
      lat: (res['lat'] is int) ? res['lat'].toDouble() : res['lat'],
      id: res['id'],
      universityId: res['university_id'],
      name: res['name'],
    );
  }

  Map<String, String> toMap() => {
        CONSTANTS.ROW_NAME: name,
        CONSTANTS.ROW_ID: id.toString(),
        'lon': long.toString(),
        'lat': lat.toString(),
        'zip_code': zipCode.toString(),
        'university_id': universityId.toString(),
      };
}
