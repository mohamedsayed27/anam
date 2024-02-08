import 'package:anam/domain/controllers/products_cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  LatLng? selectedLocation;
  String? selectedLocationName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        onTap: _onMapTapped,
        initialCameraPosition: const CameraPosition(
          target: LatLng(24.774265, 46.738586), // Default: San Francisco, CA
          zoom: 12.0,
        ),
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedLocation != null) {
            _getAddressFromLatLng(selectedLocation!).whenComplete(() {
              Navigator.pop(context,{"name":selectedLocationName!,"coordinates":"${selectedLocation!.latitude}, ${selectedLocation!.longitude}"});
            });

          } else {
            // Handle the case when no location is selected
            // You may want to show a message to the user.
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
  void _onMapTapped(LatLng location) {
    print("Map tapped");
    setState(() {
      selectedLocation = location;
      markers.clear();
      markers.add(Marker(
        markerId: const MarkerId('selected_location'),
        position: location,
      ));
    });
  }
  Future<void> _getAddressFromLatLng(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          selectedLocationName = '${placemark.name}, ${placemark.locality}, ${placemark.country}';
        });
      } else {
        setState(() {
          selectedLocationName = 'Location name not available';
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}