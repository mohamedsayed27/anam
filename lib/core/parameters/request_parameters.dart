import 'package:equatable/equatable.dart';

class RequestParameters extends Equatable{
  final String? description;
  final String? title;
  final String? price;
  final String? notes;
  final String? countryId;
  final String? coordinates;
  final String? mapLocation;

  const RequestParameters({
    this.description,
    this.title,
    this.price,
    this.notes,
    this.countryId,
    this.coordinates,
    this.mapLocation,
  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'title': title,
      'price': price,
      'notes': notes,
      'country_id': countryId,
      'coordinates': coordinates,
      'map_location': mapLocation,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    description,
    title,
    price,
    notes,
    countryId,
    coordinates,
    mapLocation,
  ];
}
