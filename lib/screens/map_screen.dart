import 'package:favourite_places_app/models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  MapScreen({
    super.key,
    required this.currentLocation,
    this.isSelecting = true,
  });
  PlaceLocation currentLocation;
  final bool isSelecting;
  String currentAddress = "no zddress";

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  bool istap = false;

  Future<void> _getAdressFromCoordinates() async {
    // Get the address from the coordinates

    print("try block--------------------");
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _pickedLocation!.latitude,
      _pickedLocation!.longitude,
    );
    // print(placemarks);
    // print(placemarks[0]);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      setState(() {
        widget.currentAddress = "${place.locality}, ${place.country}";
        print("calling--------------------");
      });
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.isSelecting ? "Pick you location" : 'Your location'),
      //   actions: [
      //     if (widget.isSelecting)
      //       IconButton(
      //         icon: Icon(Icons.save),
      //         onPressed: () {},
      //       )
      //   ],
      // ),

      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                onTap: (point, LatLng) async {
                  setState(() {
                    _pickedLocation = LatLng;
                  });

                  if (_pickedLocation != null) {
                    try {
                      await _getAdressFromCoordinates();
                    } catch (e) {
                      print("Error handling address: $e");
                      // Handle the error or display a message to the user.
                    }
                  }
                },
                initialCenter: LatLng(widget.currentLocation!.latitude,
                    widget.currentLocation!.longitude),
                initialZoom: 10.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  //subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 50,
                      height: 60,
                      point: LatLng(
                        _pickedLocation != null
                            ? _pickedLocation!.latitude
                            : widget.currentLocation!.latitude,
                        _pickedLocation != null
                            ? _pickedLocation!.longitude
                            : widget.currentLocation!.longitude,
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    )
                  ],
                )
              ],
            ),
            //search textfield------------------------
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 16.0),
              child: Column(
                children: [
                  const Card(
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                          ),
                          hintText: "Search for location",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.all(15)),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        _pickedLocation != null
                            ? widget.currentAddress
                            : widget.currentLocation.address,
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
