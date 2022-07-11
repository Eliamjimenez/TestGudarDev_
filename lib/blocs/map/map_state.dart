part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInit;

  final Set<Marker> markers;

  const MapState({this.isMapInit = false, Set<Marker>? markers})
      : markers = markers ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    Set<Marker>? markers,
  }) =>
      MapState(
        isMapInit: isMapInitialized ?? this.isMapInit,
        markers: markers ?? this.markers,
      );

  @override
  List<Object> get props => [isMapInit, markers];
}
