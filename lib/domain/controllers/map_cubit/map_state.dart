
abstract class MapState {}

class MapInitial extends MapState {}

class GetDataMapLoading extends MapState {}

class GetDataMapSuccess extends MapState {}

class GetDataMapError extends MapState {}
class MarkerGenerationDone extends MapState {}
class GetMarkersPositionDone extends MapState {}
