import 'dart:convert';

Station stationFromJson(String str) => Station.fromJson(json.decode(str));

String stationToJson(Station data) => json.encode(data.toJson());

class Station {
  int status;
  String message;
  List<Datum> data;

  Station({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  StationClass station;
  double distance;
  double occupancy200;
  double occupancy400;
  double occupancy600;
  double occupancy1200;

  Datum({
    required this.station,
    required this.distance,
    required this.occupancy200,
    required this.occupancy400,
    required this.occupancy600,
    required this.occupancy1200,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    station: StationClass.fromJson(json["station"]),
    distance: json["distance"]?.toDouble(),
    occupancy200: json["occupancy20_0"]?.toDouble(),
    occupancy400: json["occupancy40_0"]?.toDouble(),
    occupancy600: json["occupancy60_0"]?.toDouble(),
    occupancy1200: json["occupancy120_0"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "station": station.toJson(),
    "distance": distance,
    "occupancy20_0": occupancy200,
    "occupancy40_0": occupancy400,
    "occupancy60_0": occupancy600,
    "occupancy120_0": occupancy1200,
  };
}

class StationClass {
  double longitude;
  double latitude;
  String name;
  String address;
  int slow;
  int fast;
  int sid;

  StationClass({
    required this.longitude,
    required this.latitude,
    required this.name,
    required this.address,
    required this.slow,
    required this.fast,
    required this.sid,
  });

  factory StationClass.fromJson(Map<String, dynamic> json) => StationClass(
    longitude: json["longitude"]?.toDouble(),
    latitude: json["latitude"]?.toDouble(),
    name: json["name"],
    address: json["address"],
    slow: json["slow"],
    fast: json["fast"],
    sid: json["sid"],
  );

  Map<String, dynamic> toJson() => {
    "longitude": longitude,
    "latitude": latitude,
    "name": name,
    "address": address,
    "slow": slow,
    "fast": fast,
    "sid": sid,
  };
}
