import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/screens/mapview_screen.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const LatLng initialPosition = LatLng(41.759020, -432.679016);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MapBloc, MapState>(builder: (context, mapState) {
        return MapViewScreen(
          markers: mapState.markers,
          initialLocation: initialPosition,
        );
      }),
    );
  }
}
