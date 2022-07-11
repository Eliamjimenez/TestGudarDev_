import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/map/map_bloc.dart';

class MapViewScreen extends StatefulWidget {
  final LatLng initialLocation;
  final Set<Marker> markers;

  const MapViewScreen(
      {Key? key, required this.initialLocation, required this.markers})
      : super(key: key);

  @override
  State<MapViewScreen> createState() => _MapViewScreenState();
}

class _MapViewScreenState extends State<MapViewScreen> {
  BitmapDescriptor? myIcon;

  @override
  Widget build(BuildContext context) {
    final CameraPosition developerHouse = CameraPosition(
        target: LatLng(
            widget.initialLocation.latitude, widget.initialLocation.longitude),
        zoom: 9);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return GoogleMap(
      myLocationEnabled: true,
      initialCameraPosition: developerHouse,
      markers: widget.markers,
      zoomControlsEnabled: true,
      tileOverlays: const {},
      onMapCreated: (controller) =>
          mapBloc.add(OnMapInitializedEvent(controller)),
    );
  }
}
