import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../constants/api.dart';
import '../../models/vehicle.dart';
import 'package:http/http.dart' as http;

import '../../themes/mapLightBlue.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  Set<Marker> _markers = {};

  GoogleMapController? _mapController;

  BitmapDescriptor? arrowIcon;

  List<Vehicle> locationList = [];
  late Vehicle selectedLocation;

  Set<Marker>? myMarkers = {};

  MapBloc() : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitializeMap);
    on<MarkerEvent>(_onMarkerEvent);

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(), "assets/arrow-icon.png")
        .then((onValue) {
      arrowIcon = onValue;
    });

    Timer.periodic(Duration(seconds: 10), (timer) async {
      Uri url =
          Uri.https(ApiConstants.BASE_URL, '/api/vehicles/with_last_position');

      final accessToken = ApiConstants.ACCESS_TOKEN;

      final res = await http
          .get(url, headers: {'Authorization': 'Bearer $accessToken'});

      final List decodedRes = json.decode(res.body);

      locationList =
          decodedRes.map((location) => Vehicle.fromMap(location)).toList();
      add(MarkerEvent(locationList));
    });
    List<Vehicle?> searchVehicleLocation(String query) {
      List<Vehicle?> deviceListFiltered = locationList
          .where((location) => location.vehicleName
              .toLowerCase()
              .startsWith(query.toLowerCase()))
          .toList();

      return deviceListFiltered;
    }
  }

  void _onInitializeMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(mapLightBlue));
    emit(state.copyWith(isMapInitialized: true));
  }

  void _onMarkerEvent(MarkerEvent event, Emitter<MapState> emit) {
    myMarkers = <Marker>{};
    if (locationList.isNotEmpty) {
      for (var vehicle in locationList) {
        myMarkers!.add(Marker(
            rotation: vehicle.heading,
            markerId: MarkerId(vehicle.vehicleId.toString()),
            position: LatLng(vehicle.gpsLat, vehicle.gpsLng),
            icon: arrowIcon ?? BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(
              title: vehicle.vehicleName,
              snippet:
                  "Latitude: ${vehicle.gpsLat}  Longitude: ${vehicle.gpsLng}  Last Speed: ${vehicle.speed}",
            )));
      }
    }

    emit(state.copyWith(markers: myMarkers));
  }
}
