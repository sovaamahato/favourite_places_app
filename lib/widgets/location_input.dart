import 'dart:convert';

import 'package:favourite_places_app/screens/map_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../models.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});
  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  //api key use garyo vane chai this code will be used---------------------------------------------
  // void _getCurrentLocation() async {
  //   Location location = Location();

  //   bool serviceEnabled;
  // PermissionStatus permissionGranted;
  // LocationData locationData;

  // serviceEnabled = await location.serviceEnabled();
  // if (!serviceEnabled) {
  //   serviceEnabled = await location.requestService();
  //   if (!serviceEnabled) {
  //     return;
  //   }
  // }

  // permissionGranted = await location.hasPermission();
  // if (permissionGranted == PermissionStatus.denied) {
  //   permissionGranted = await location.requestPermission();
  //   if (permissionGranted != PermissionStatus.granted) {
  //     return;
  //   }
  // }
  // setState(() {
  //   _isGettingLocation = true;
  // });

  // locationData = await location.getLocation();
  // final lat = locationData.latitude;
  // final lng = locationData.longitude;
  // if (lat == null || lng == null) {
  //   return;
  // }
  // final url = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=...');
  //   final response = await http.get(url);

  //   final resData = json.decode(response.body);
  //   final address = resData['results'][0]['formatted_address'];

  //   setState(() {
  //     _pickedLocation = PlaceLocation(
  //       latitude: lat,
  //       longitude: lng,
  //       address: address,
  //     );
  //     _isGettingLocation = false;
  //   });
  //   print(locationData.latitude);
  //   print(locationData.longitude);
  // }
  //------------------------------------------------------------------------

  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  //map images ko lagi  -------------------------------------
  Widget buildMapPreview() {
    if (_pickedLocation == null) {
      return Container(); // Return an empty container if no location is selected
    }

    return Container(
      child: FlutterMap(
        options: MapOptions(
          initialCenter:
              LatLng(_pickedLocation!.latitude, _pickedLocation!.longitude),
          initialZoom: 10.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            //subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 50,
                height: 60,
                point: LatLng(
                    _pickedLocation!.latitude, _pickedLocation!.longitude),
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  //save place from map screen
  Future<void> _savePlace(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    setState(() {
      _currentAddress = "${place.locality}, ${place.country}";
      locationSelected = true;

      _pickedLocation = PlaceLocation(
        latitude: latitude,
        longitude: longitude,
        address: _currentAddress,
      );
      _isGettingLocation = false;
    });
    widget.onSelectLocation(_pickedLocation!);
  }

//--------------------------------------------------
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  String _currentAddress = "";
  bool locationSelected = false;

  Future<Position> _getCurrentLocation() async {
    //checking permission to access location----------------------
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service denied");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    setState(() {
      _isGettingLocation = true;
    });
    return Geolocator.getCurrentPosition();
  }

  //geocode the coordinates and convert into actual adress
  _getAdressFromCoordinates() async {
    try {
      ///////////////////////////
      _savePlace(_currentLocation!.latitude, _currentLocation!.longitude);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
//in case location is not selected
    setState(() {});
    Widget previewContent = Text(
      locationSelected ? "${_currentAddress}" : "No location choosen",
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
      textAlign: TextAlign.center,
    );
    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    } else if (_pickedLocation != null) {
      previewContent =
          buildMapPreview(); // Use the FlutterMap preview if location is selected
    }

    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: previewContent),
        const SizedBox(
          height: 8,
        ),
        //adress show
        Text(
          _pickedLocation != null ? _pickedLocation!.address : "",
          style: const TextStyle(color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () async {
                //get current location here
                _currentLocation = await _getCurrentLocation();
                await _getAdressFromCoordinates();
              },
              icon: const Icon(Icons.location_on, color: Colors.purple),
              label: const Text(
                "Get Current Location",
                style: TextStyle(color: Colors.purple),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                //get the current location first to show your current position on map and then navigate
                if (_currentLocation == null) {
                  _currentLocation = await _getCurrentLocation();
                  await _getAdressFromCoordinates();
                }

//variable here is to get back the selected value(location) from the map screen

                if (_currentLocation != null) {
                  _currentLocation = await _getCurrentLocation();
                  await _getAdressFromCoordinates();
                  final _getLocationFromMapScreen =
                      await Navigator.of(context).push<LatLng>(
                    MaterialPageRoute(
                      builder: (ctx) => MapScreen(
                        currentLocation: _pickedLocation!,
                        //??
                        // PlaceLocation(
                        //     latitude: 0.5, longitude: 0.5, address: ''),
                        isSelecting: true,
                      ),
                    ),
                  );
                  if (_getLocationFromMapScreen == null) {
                    return;
                  }
                  _savePlace(_getLocationFromMapScreen.latitude,
                      _getLocationFromMapScreen.longitude);
                }
              },
              icon: const Icon(
                Icons.map,
                color: Colors.purple,
              ),
              label: const Text(
                "Select on Map",
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        )
      ],
    );
  }
}
