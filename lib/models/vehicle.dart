// To parse this JSON data, do
//
//     final Vehicle = VehicleFromMap(jsonString);

import 'dart:convert';

class Vehicle {
  Vehicle({
    required this.deviceIds,
    required this.vehicleId,
    required this.vehicleName,
    required this.status,
    required this.statusOrder,
    required this.speed,
    required this.gpsLat,
    required this.gpsLng,
    required this.heading,
    required this.lastUpdated,
    required this.totalDistance,
    required this.totalTime,
  });

  String deviceIds;
  int vehicleId;
  String vehicleName;
  String status;
  int statusOrder;
  double speed;
  double gpsLat;
  double gpsLng;
  double heading;
  DateTime lastUpdated;
  double totalDistance;
  int totalTime;

  factory Vehicle.fromJson(String str) => Vehicle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
        deviceIds: json["deviceIds"],
        vehicleId: json["vehicleId"],
        vehicleName: json["vehicleName"],
        status: json["status"],
        statusOrder: json["statusOrder"],
        speed: json["speed"],
        gpsLat: json["gpsLat"].toDouble(),
        gpsLng: json["gpsLng"].toDouble(),
        heading: json["heading"],
        lastUpdated: DateTime.parse(json["lastUpdated"]),
        totalDistance: json["totalDistance"],
        totalTime: json["totalTime"],
      );

  Map<String, dynamic> toMap() => {
        "deviceIds": deviceIds,
        "vehicleId": vehicleId,
        "vehicleName": vehicleName,
        "status": status,
        "statusOrder": statusOrder,
        "speed": speed,
        "gpsLat": gpsLat,
        "gpsLng": gpsLng,
        "heading": heading,
        "lastUpdated": lastUpdated.toIso8601String(),
        "totalDistance": totalDistance,
        "totalTime": totalTime,
      };
}
